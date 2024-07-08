import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gymnastic_center/application/blocs/create_comment/create_comment_bloc.dart';
import 'package:gymnastic_center/application/blocs/get_comments/get_comments_bloc.dart';
import 'package:gymnastic_center/presentation/widgets/blog/add_comment_bar.dart';

class CustomModalSheetCourse extends StatefulWidget {
  final String lessonId;
  final String title;
  final Widget child;
  const CustomModalSheetCourse(
      {super.key,
      required this.lessonId,
      this.title = 'Comments',
      required this.child});

  @override
  State<CustomModalSheetCourse> createState() => _CustomModalSheetCourseState();
}

class _CustomModalSheetCourseState extends State<CustomModalSheetCourse> {
  @override
  Widget build(BuildContext context) {
    final createCommentBloc = GetIt.instance<CreateCommentBloc>();
    final getCommentsBloc = GetIt.instance<GetCommentsBloc>();
    return Stack(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Add your code here
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.close_rounded,
                        size: 30,
                      ))
                ],
              ),
            ),
            Divider(
              color: Theme.of(context).colorScheme.outline,
              height: 0,
              thickness: 1,
            ),
            Expanded(child: widget.child),
            const SizedBox(
              height: 80,
            )
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: BlocProvider.value(
            value: createCommentBloc,
            child: BlocListener<CreateCommentBloc, CreateCommentState>(
              listener: (context, state) {
                if (state is CreateCommentSuccess) {
                  getCommentsBloc
                      .add(CommentsRequested(lessonId: widget.lessonId, page: 1));
                }
              },
              child: SingleChildScrollView(
                child: AddCommentBar(
                targetType: 'LESSON',
                lessonOrBlogId: widget.lessonId,
                                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
