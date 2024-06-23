import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gymnastic_center/application/blocs/all_blogs_by_trainer/all_blogs_by_trainer_bloc.dart';
import 'package:gymnastic_center/application/blocs/all_course_by_trainer/all_course_by_trainer_bloc.dart';
import 'package:gymnastic_center/application/blocs/all_trainers/all_trainers_bloc.dart';
import 'package:gymnastic_center/application/blocs/bloc/follow_trainer_bloc.dart';
import 'package:gymnastic_center/domain/trainer/trainer.dart';
import 'package:gymnastic_center/presentation/screens/blog/all_blogs_screen.dart';
import 'package:gymnastic_center/presentation/screens/course/all_courses_screen.dart';
import 'package:gymnastic_center/presentation/screens/trainers/blog_by_trainer_carousel.dart';
import 'package:gymnastic_center/presentation/widgets/common/brand_back_button.dart';
import 'package:gymnastic_center/presentation/widgets/common/brand_button.dart';
import 'package:gymnastic_center/presentation/widgets/common/content_header.dart';
import 'package:gymnastic_center/presentation/widgets/trainer/course_by_trainer_carousel.dart';

class TrainerInfo extends StatefulWidget {
  final Trainer trainer;
  final ScrollController scrollController;
  final bool showFab;
  const TrainerInfo(
      {super.key,
      required this.trainer,
      required this.scrollController,
      required this.showFab});

  @override
  State<TrainerInfo> createState() => _TrainerInfoState();
}

class _TrainerInfoState extends State<TrainerInfo> {
  late FollowTrainerBloc followTrainerBloc;
  late bool followStatus;
  late dynamic followers;

  @override
  void initState() {
    followTrainerBloc = GetIt.instance<FollowTrainerBloc>();
    followStatus = widget.trainer.userFollow!;
    followers = widget.trainer.followers;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: followTrainerBloc,
      child: Stack(children: [
        Image.network(
          widget.trainer.image ??
              'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541',
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress != null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return child;
            }
          },
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        SingleChildScrollView(
          controller: widget.scrollController,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            margin: const EdgeInsets.only(top: 350),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Center(
                    child: Text(
                  widget.trainer.name!,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 30),
                )),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.trainer.followers.toString(),
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      ' ${followers == 1 ? 'follower' : 'followers'}',
                      style: const TextStyle(fontSize: 18),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: BlocListener<FollowTrainerBloc, FollowTrainerState>(
                      listener: (context, state) {
                        if (state is FollowTrainerFailed) {
                          setState(() {
                            followStatus = !followStatus;
                            followStatus ? followers++ : followers--;
                          });

                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                              followStatus
                                  ? "Failed to unfollow. Please try again."
                                  : "Failed to follow. Please try again.",
                            ),
                            backgroundColor: Colors.red,
                            duration: const Duration(seconds: 3),
                          ));
                        } else if (state is FollowTrainerSuccess) {
                          GetIt.instance<AllTrainersBloc>().add(
                              const AllTrainersRequested(
                                  page: 1, overrideCache: true));
                        }
                      },
                      child: BrandButton(
                        onPressed: () {
                          setState(() {
                            followStatus = !followStatus;
                            followStatus ? followers++ : followers--;
                          });
                          followTrainerBloc
                              .add(FollowRequested(id: widget.trainer.id!));
                        },
                        isVariant: followStatus,
                        text: followStatus ? 'following' : 'follow',
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                ContentHeader(
                    title: '${widget.trainer.name}\'s Courses',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AllCoursesScreen()),
                      );
                    }),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: BlocProvider(
                    create: (context) =>
                        GetIt.instance<AllCourseByTrainerBloc>(),
                    child:
                        CourseByTrainerCarousel(trainerId: widget.trainer.id!),
                  ),
                ),
                ContentHeader(
                    title: '${widget.trainer.name}\'s Blogs',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AllBlogsScreen()),
                      );
                    }),
                BlocProvider(
                  create: (context) => GetIt.instance<AllBlogsByTrainerBloc>(),
                  child: BlogByTrainerCarousel(trainerId: widget.trainer.id!),
                ),
                const SizedBox(
                  height: 60,
                ),
              ],
            ),
          ),
        ),
        AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOut,
            left: 0,
            right: 0,
            top: widget.showFab ? 0 : -140,
            child: Container(
              height: 110,
              width: double.infinity,
              color: const Color(0xFF4F14A0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    widget.trainer.name!,
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            )),
        Positioned(
            top: 60,
            left: 10,
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFF4F14A0),
                shape: BoxShape.circle,
              ),
              child: const BrandBackButton(
                color: Colors.white,
              ),
            )),
      ]),
    );
  }
}
