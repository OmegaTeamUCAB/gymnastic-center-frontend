import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gymnastic_center/application/blocs/blog_comments/blog_comments_bloc.dart';
import 'package:gymnastic_center/domain/comment/comment.dart';
import 'package:gymnastic_center/presentation/widgets/comment/comment_tile.dart';
import 'package:gymnastic_center/presentation/widgets/common/no_results.dart';

class BlogComments extends StatefulWidget {
  final String blogId;
  const BlogComments({
    super.key,
    required this.blogId,
  });

  @override
  State<BlogComments> createState() => _BlogCommentsState();
}

class _BlogCommentsState extends State<BlogComments> {
  late final BlogCommentsBloc _commentsBloc;
  @override
  void initState() {
    super.initState();
    _commentsBloc = GetIt.instance<BlogCommentsBloc>();
    _commentsBloc.add(BlogCommentsRequested(blogId: widget.blogId, page: 1));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _commentsBloc,
      child: BlocBuilder<BlogCommentsBloc, BlogCommentsState>(
        builder: (context, state) {
          if (state is BlogCommentsLoading) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 25),
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (state is BlogCommentsFailed) {
            return Center(
              child: Text(state.message),
            );
          }
          if (state is BlogCommentsSuccess) {
            if (state.comments.isEmpty) {
              return const Padding(
                padding: EdgeInsets.all(20),
                child: Center(
                    child: NoResults(message: 'This blog has no comments')),
              );
            }
            return ListView.builder(
              itemCount: state.comments.length,
              itemBuilder: (context, index) {
                final comment = state.comments[index];
                return Padding(
                    padding: const EdgeInsets.all(15),
                    child: CommentTile(
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
