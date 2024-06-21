import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gymnastic_center/application/blocs/bloc/follow_trainer_bloc.dart';
import 'package:gymnastic_center/domain/trainer/trainer.dart';
import 'package:gymnastic_center/presentation/screens/trainer_screen.dart';
import 'package:gymnastic_center/presentation/widgets/common/brand_button.dart';

class TrainerList extends StatefulWidget {
  final List<Trainer> trainers;
  const TrainerList({super.key, required this.trainers});

  @override
  State<TrainerList> createState() => _TrainerListState();
}

class _TrainerListState extends State<TrainerList> {
  late FollowTrainerBloc followTrainerBloc;
  late List<bool> followStatus;
  late List<dynamic> followers;

  @override
  void initState() {
    super.initState();
    followTrainerBloc = GetIt.instance<FollowTrainerBloc>();
    followStatus = widget.trainers.map((trainer) => trainer.userFollow!).toList();
    followers = widget.trainers.map((trainer) => trainer.followers ?? 0).toList();
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: followTrainerBloc,
      child: Column(
        children: widget.trainers.asMap().entries.map((entry) {
          int index = entry.key;
          Trainer trainer = entry.value;
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.tertiaryContainer,
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TrainerScreen(trainerId: trainer.id!),
                  ),
                );
              },
              title: Text(
                trainer.name!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              titleTextStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              subtitle: Text('${followers[index]} followers | ${trainer.location}'),
              leading: trainer.image != null
                  ? CircleAvatar(
                      backgroundImage: NetworkImage(trainer.image!),
                    )
                  : const Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Icon(
                        Icons.person,
                        size: 30,
                      ),
                    ),
              trailing: BlocConsumer<FollowTrainerBloc, FollowTrainerState>(
                listener: (context, state) {
                  if (state is FollowTrainerFailed) {
                    setState(() {
                      followStatus[index] = !followStatus[index];
                      followStatus[index]
                          ? followers[index]++
                          : followers[index]--;
                    });

                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        followStatus[index]
                            ? "Failed to unfollow. Please try again."
                            : "Failed to follow. Please try again.",
                      ),
                      backgroundColor: Colors.red,
                      duration: const Duration(seconds: 3),
                    ));
                  } else if (state is FollowTrainerSuccess) {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        followStatus[index]
                            ? "Added trainer to your following list."
                            : "Removed trainer from your following list.",
                        style: const TextStyle(color: Colors.white),
                      ),
                      backgroundColor: const Color(0xFF4F14A0),
                      duration: const Duration(seconds: 3),
                    ));
                  }
                },
                builder: (context, state) {
                  return BrandButton(
                    onPressed: () {
                      setState(() {
                        followStatus[index] = !followStatus[index];
                        followStatus[index]
                            ? followers[index]++
                            : followers[index]--;
                      });
                      followTrainerBloc.add(FollowRequested(id: trainer.id!));
                    },
                    isVariant: followStatus[index],
                    fontSize: 14,
                    width: 90,
                    text: followStatus[index] ? 'following' : 'follow',
                  );
                },
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
