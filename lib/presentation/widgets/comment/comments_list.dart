import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gymnastic_center/application/blocs/get_comments/get_comments_bloc.dart';
import 'package:gymnastic_center/presentation/widgets/comment/comment_tile.dart';
import 'package:gymnastic_center/presentation/widgets/common/no_results.dart';

class CommentsList extends StatefulWidget {
  final String? blogId;
  final String? lessonId;
  const CommentsList({
    super.key,
    this.blogId,
    this.lessonId,
  });

  @override
  State<CommentsList> createState() => _CommentsListState();
}

class _CommentsListState extends State<CommentsList> {
  late final GetCommentsBloc _commentsBloc;
  @override
  void initState() {
    super.initState();
    _commentsBloc = GetIt.instance<GetCommentsBloc>();
    _commentsBloc.add(CommentsRequested(
        blogId: widget.blogId, lessonId: widget.lessonId, page: 1));
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
              return Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                    child: NoResults(
                        message:
                            'No ${widget.blogId != null ? 'comments' : 'questions'}')),
              );
            }
            return ListView.builder(
              itemCount: state.comments.length,
              itemBuilder: (context, index) {
                final comment = state.comments[index];
                return CommentTile(
                  blogId: widget.blogId,
                  lessonId: widget.lessonId,
                  comment: comment,
                );
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
