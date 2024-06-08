import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/blocs/blogs_by_category/blogs_by_category_bloc.dart';
import 'package:gymnastic_center/application/blocs/blogs_by_category/blogs_by_category_event.dart';
import 'package:gymnastic_center/application/use_cases/blog/get_blogs_by_category.use_case.dart';
import 'package:gymnastic_center/infrastructure/config/constants/environment.dart';
import 'package:gymnastic_center/infrastructure/data-sources/http/http_manager_impl.dart';
import 'package:gymnastic_center/infrastructure/repositories/blogs/blogs_repository.dart';
import 'package:gymnastic_center/presentation/widgets/common/no_results.dart';

class BlogsByCategoryGrid extends StatelessWidget {
  final String categoryId;
  late final BlogsByCategoryBloc bloc;
  BlogsByCategoryGrid({super.key, required this.categoryId}) {
    bloc = BlogsByCategoryBloc(GetBlogsByCategoryUseCase(
        BlogsRepository(HttpManagerImpl(baseUrl: Environment.getApiUrl()))));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        bloc.add(BlogsByCategoryRequested(categoryId: categoryId));
        return bloc;
      },
      child: BlocBuilder<BlogsByCategoryBloc, BlogsByCategoryState>(
          builder: (context, state) {
        if (state is BlogsByCategoryLoading) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 25),
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (state is BlogsByCategoryFailed) {
          return Center(
            child: Text(state.message),
          );
        }
        if (state is BlogsByCategorySuccess) {
          if (state.blogs.isEmpty) {
            return const Center(
              child: NoResults(),
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 24,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  '${state.blogs.length} Blogs',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimary),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(10.0),
                itemCount: state.blogs.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2 / 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (ctx, i) => Card(
                  elevation: 0,
                  color: Colors.transparent,
                  child: Column(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          state.blogs[i].images.first,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(state.blogs[i].title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          )),
                      const SizedBox(height: 10),
                      Text(state.blogs[i].description,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context).colorScheme.onSecondary,
                          )),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 60,
              )
            ],
          );
        } else {
          return const Center(
            child: Text('Error'),
          );
        }
      }),
    );
  }
}
