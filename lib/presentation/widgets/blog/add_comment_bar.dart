import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/blocs/auth/auth_bloc.dart';
import 'package:gymnastic_center/application/blocs/create_comment/create_comment_bloc.dart';
import 'package:gymnastic_center/application/use_cases/comment/create_blog_comment.use_case.dart';
import 'package:gymnastic_center/infrastructure/data-sources/http/http_manager_impl.dart';
import 'package:gymnastic_center/infrastructure/repositories/comments/comment_repository.dart';

import 'package:gymnastic_center/presentation/widgets/common/brand_gradient.dart';

class AddCommentBar extends StatefulWidget {
  final String blogId;
  late final CreateCommentBloc bloc;

  AddCommentBar({super.key, required this.blogId}) {
    bloc = CreateCommentBloc(
        createBlogCommentUseCase: CreateBlogCommentUseCase(CommentRepository(
            HttpManagerImpl())));
  }

  @override
  State<AddCommentBar> createState() => _AddCommentBarState();
}

class _AddCommentBarState extends State<AddCommentBar> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();
  String blogContent = '';

  @override
  Widget build(BuildContext context) {
    final authBloc = context.watch<AuthBloc>();
    final userId = (authBloc.state is Authenticated)
        ? (authBloc.state as Authenticated).user.id
        : null;

    void onSubmit() {
      if (_formKey.currentState!.validate()) {
        _controller.clear();
        FocusScope.of(context).unfocus();
        widget.bloc.add(CreatedBlogComment(
          userId: userId!,
          content: blogContent,
          blogId: widget.blogId,
        ));
      }
    }

    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
              color: Theme.of(context).colorScheme.outline, width: 1.0),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: 15.0,
          right: 15.0,
          top: 15.0,
          bottom: MediaQuery.of(context).viewInsets.bottom + 15.0,
        ),
        child: Form(
          key: _formKey,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 56,
                width: 300,
                child: TextFormField(
                  onChanged: (value) {
                    blogContent = value;
                  },
                  validator: (value) {
                    if (value == null || value.length < 4) {
                      return 'Comment must be at least 4 characters long';
                    }
                    return null;
                  },
                  controller: _controller,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(15),
                    border: InputBorder.none,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.surfaceTint,
                    hintText: 'Add a comment...',
                  ),
                ),
              ),
              const Spacer(),
              Container(
                width: 56,
                height: 56,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: brandGradient,
                ),
                child: FloatingActionButton(
                  onPressed: onSubmit,
                  shape: const CircleBorder(),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  child: const Icon(Icons.send, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
