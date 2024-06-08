import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/blocs/all_categories/all_categories_bloc.dart';
import 'package:gymnastic_center/application/use_cases/category/get_all_categories.use_case.dart';
import 'package:gymnastic_center/domain/category/category.dart';
import 'package:gymnastic_center/infrastructure/config/constants/environment.dart';
import 'package:gymnastic_center/infrastructure/data-sources/http/http_manager_impl.dart';
import 'package:gymnastic_center/infrastructure/repositories/categories/category_repository.dart';
import 'package:gymnastic_center/presentation/screens/categories/category_screen.dart';
import 'package:gymnastic_center/presentation/widgets/common/carousel_header.dart';

class CategoryCarousel extends StatelessWidget {
  late final AllCategoriesBloc bloc;

  CategoryCarousel({super.key}) {
    bloc = AllCategoriesBloc(GetAllCategoriesUseCase(
        CategoryRepository(HttpManagerImpl(baseUrl: Environment.getApiUrl()))));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselHeader(
          title: 'Categories',
          onButtonPressed: () {},
        ),
        SizedBox(
          height: 100,
          child: BlocProvider(
            create: (context) {
              bloc.add(AllCategoriesRequested());
              return bloc;
            },
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
                            color: Theme.of(context).colorScheme.surfaceTint,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 40,
                                width: 40,
                                child: ColorFiltered(
                                    colorFilter: ColorFilter.mode(
                                        Theme.of(context).colorScheme.primary,
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
          ),
        ),
      ],
    );
  }
}
