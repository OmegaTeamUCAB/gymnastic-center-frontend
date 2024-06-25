import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gymnastic_center/application/blocs/delete_comment/delete_comment_bloc.dart';
import 'package:gymnastic_center/application/blocs/get_comments/get_comments_bloc.dart';


class DeleteButton extends StatelessWidget {
  final String modalTitle;
  final String buttonLabel;
  final DeleteCommentBloc deleteCommentBloc;
  final String commentId;
  const DeleteButton({
    super.key, required this.modalTitle, required this.buttonLabel, required this.deleteCommentBloc, required this.commentId,
  });

  @override
  Widget build(BuildContext context) {
    final GetCommentsBloc getCommentsBloc = GetIt.instance<GetCommentsBloc>();
    return BlocListener<DeleteCommentBloc,DeleteCommentState>(
      listener: (context, state) {
        if (state is DeleteCommentSuccess) {
          getCommentsBloc.add(const CommentsRequested(page: 1));
        }
      },
      child: IconButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              backgroundColor: Theme.of(context).colorScheme.surface,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              builder: (BuildContext context) {
                return SizedBox(
                  height: 120,
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                        child: Text(
                          modalTitle,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          deleteCommentBloc.add(DeleteRequested(id:commentId));
                        },
                        icon: Icon(Icons.delete_outline_rounded,
                            size: 20,
                            color:
                                Theme.of(context).colorScheme.onPrimary),
                        label: Text(
                          buttonLabel,
                          style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimary),
                        ),
                      )
                    ],
                  ),
                );
              });
        },
        icon: const Icon(
          Icons.delete_outline_rounded,
          size: 20,
        ),
      ),
    );
  }
}
