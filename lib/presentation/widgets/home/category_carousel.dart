import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gymnastic_center/application/blocs/all_categories/all_categories_bloc.dart';
import 'package:gymnastic_center/application/blocs/theme/theme_bloc.dart';
import 'package:gymnastic_center/domain/category/category.dart';
import 'package:gymnastic_center/presentation/screens/categories/category_screen.dart';

class CategoryCarousel extends StatelessWidget {
  const CategoryCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    final allCategoriesBloc = GetIt.instance<AllCategoriesBloc>();
    allCategoriesBloc.add(AllCategoriesRequested());
    return SizedBox(
        height: 100,
        child: BlocProvider<AllCategoriesBloc>.value(
          value: allCategoriesBloc,
          child: BlocBuilder<AllCategoriesBloc, AllCategoriesState>(
            builder: (context, state) {
              if (state is AllCategoriesLoading) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 25),
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              if (state is AllCategoriesFailed) {
                return Center(
                  child: Text(state.message),
                );
              }
              if (state is AllCategoriesSuccess) {
                if (state.categories.isEmpty) {
                  return const Center(
                    child: Text('No categories found'),
                  );
                }
                final theme = context.watch<ThemeBloc>().state.themeData.colorScheme;
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.categories.length,
                  itemBuilder: (BuildContext context, int index) {
                    Category currentCategory = state.categories[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CategoryScreen(
                                    categoryId: currentCategory.id,
                                    categoryName: currentCategory.name,
                                  )),
                        );
                      },
                      child: Container(
                        width: 100,
                        margin: EdgeInsets.only(
                            left: 15,
                            right: index ==
                                    state.categories.length -
                                        1 //add margin to the last element of the carousel
                                ? 15
                                : 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: theme.surfaceTint,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 40,
                              width: 40,
                              child: ColorFiltered(
                                  colorFilter: ColorFilter.mode(
                                      theme.primary,
                                      BlendMode.srcIn),
                                  child: Image.network(currentCategory.icon)),
                            ),
                            const SizedBox(height: 10.0),
                            Text(
                              currentCategory.name,
                              style: const TextStyle(fontSize: 13),
                            ),
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
        ));
  }
}
