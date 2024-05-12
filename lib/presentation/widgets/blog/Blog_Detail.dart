import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/blocs/blog_detail/blog_detail_bloc.dart';
import 'package:gymnastic_center/application/use_cases/blog/get_blog_by_id.use_case.dart';
import 'package:gymnastic_center/infrastructure/config/constants/environment.dart';
import 'package:gymnastic_center/infrastructure/datasources/http/http_manager_impl.dart';
import 'package:gymnastic_center/infrastructure/services/blogs/blogs_service.dart';
import 'package:gymnastic_center/presentation/widgets/blog/add_comment_bar.dart';
import 'package:gymnastic_center/presentation/widgets/blog/comment_expansion_panel.dart';
import 'package:gymnastic_center/presentation/widgets/common/custom_app_bar.dart';
import 'package:intl/intl.dart';

class BlogDetail extends StatelessWidget {
  final String blogId;
  late final BlogDetailBloc bloc;

  BlogDetail({super.key, required this.blogId}) {
    bloc = BlogDetailBloc(
        getBlogUseCase: GetBlogByIdUseCase(
            BlogsService(HttpManagerImpl(baseUrl: Environment.getApiUrl()))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const AddCommentBar(),
      body: BlocProvider(
        create: (context) {
          bloc.add(BlogDetailRequested(blogId: blogId));
          return bloc;
        },
        child: BlocBuilder<BlogDetailBloc, BlogDetailState>(
          builder: (context, state) {
            if (state is BlogDetailLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is BlogDetailLoaded) {
              return LayoutBuilder(
                builder:
                    (BuildContext context, BoxConstraints viewportConstraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: viewportConstraints.maxHeight,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Stack(
                            children: [
                              Transform.translate(
                                offset: const Offset(0, 20),
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 0.0),
                                      child: Center(
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                            bottomRight: Radius.circular(40.0),
                                          ),
                                          child: Stack(
                                            children: [
                                              Image.network(
                                                state.blog.imageUrl,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: 300,
                                                fit: BoxFit.cover,
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: 300,
                                                color: Colors.black
                                                    .withOpacity(0.6),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 10,
                                      left: 10,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 300,
                                            child: Text(
                                              state.blog.title,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                shadows: <Shadow>[
                                                  Shadow(
                                                    offset: Offset(1.0, 1.0),
                                                    blurRadius: 3.0,
                                                    color: Color.fromARGB(
                                                        255, 0, 0, 0),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Text(
                                            DateFormat('yyyy-MM-dd')
                                                .format(state.blog.uploadDate),
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              shadows: <Shadow>[
                                                Shadow(
                                                  offset: Offset(1.0, 1.0),
                                                  blurRadius: 3.0,
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              PreferredSize(
                                preferredSize: const Size(double.infinity, 100),
                                child: CustomAppBar(
                                  content: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      IconButton(
                                          icon: const Icon(
                                            Icons.chevron_left,
                                            color: Colors.white,
                                            size: 30,
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          }),
                                      const Text(
                                        'Blog',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: Text(
                              state.blog.description,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              state.blog.content,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          CommentExpansionPanel(comments: state.blog.comments),
                        ],
                      ),
                    ),
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
      ),
    );
  }
}
