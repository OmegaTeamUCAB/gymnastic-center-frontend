import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/blocs/auth/auth_bloc.dart';
import 'package:gymnastic_center/application/blocs/create_comment/create_comment_bloc.dart';
import 'package:gymnastic_center/application/use_cases/comment/create_blog_comment.use_case.dart';
import 'package:gymnastic_center/infrastructure/data-sources/http/http_manager_impl.dart';
import 'package:gymnastic_center/infrastructure/repositories/comments/comment_repository.dart';

import 'package:gymnastic_center/presentation/widgets/common/brand_gradient.dart';
import 'package:gymnastic_center/presentation/widgets/profile/profile_avatar.dart';

class AddCommentBar extends StatefulWidget {
  final String blogId;
  late final CreateCommentBloc bloc;

  AddCommentBar({super.key, required this.blogId}) {
    bloc = CreateCommentBloc(
        createBlogCommentUseCase:
            CreateBlogCommentUseCase(CommentRepository(HttpManagerImpl())));
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
        color: Theme.of(context).colorScheme.background,
        border: Border(
          top: BorderSide(
              color: Theme.of(context).colorScheme.outline, width: 1.0),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
            top: 10, bottom: MediaQuery.of(context).viewInsets.bottom + 10),
        child: Form(
          key: _formKey,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                width: 10,
              ),
              ProfileAvatar(
                fullName: (authBloc.state as Authenticated).user.fullName,
                radius: 20,
                image: (authBloc.state as Authenticated).user.image,
              ),
              const SizedBox(width: 10),
              Expanded(
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
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
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
              const SizedBox(
                width: 10,
              ),
              Container(
                width: 45,
                height: 45,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: brandGradient,
                ),
                child: FloatingActionButton(
                  onPressed: onSubmit,
                  shape: const CircleBorder(),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  child: const Icon(Icons.send, color: Colors.white, size: 20),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
