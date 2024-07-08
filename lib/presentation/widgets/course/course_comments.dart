import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gymnastic_center/application/blocs/get_comments/get_comments_bloc.dart';
import 'package:gymnastic_center/presentation/widgets/comment/comment_tile.dart';
import 'package:gymnastic_center/presentation/widgets/common/no_results.dart';

class CourseComments extends StatefulWidget {
  final String lessonId;
  const CourseComments({
    super.key,
    required this.lessonId,
  });

  @override
  State<CourseComments> createState() => _CourseCommentsState();
}

class _CourseCommentsState extends State<CourseComments> {
  late final GetCommentsBloc _commentsBloc;
  @override
  void initState() {
    super.initState();
    _commentsBloc = GetIt.instance<GetCommentsBloc>();
    _commentsBloc.add(CommentsRequested(lessonId: widget.lessonId, page: 1));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _commentsBloc,
      child: BlocBuilder<GetCommentsBloc, GetCommentsState>(
        builder: (context, state) {
          if (state is GetCommentsLoading) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 25),
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (state is GetCommentsFailed) {
            return Center(
              child: Text(state.message),
            );
          }
          if (state is GetCommentsSuccess) {
            if (state.comments.isEmpty) {
              return const Padding(
                padding: EdgeInsets.all(20),
                child: Center(child: NoResults(message: 'No comments')),
              );
            }
            return ListView.builder(
              itemCount: state.comments.length,
              itemBuilder: (context, index) {
                final comment = state.comments[index];
                return Padding(
                    padding: const EdgeInsets.all(15),
                    child: CommentTile(
                      blogId: widget.lessonId,
                      comment: comment,
                    ));
              },
            );
          } else {
            return const Center(
              child: Text('Error'),
            );
          }
        },
      ),
    );
  }
}
