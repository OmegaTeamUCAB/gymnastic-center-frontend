import 'package:get_it/get_it.dart';
import 'package:gymnastic_center/application/blocs/all_categories/all_categories_bloc.dart';
import 'package:gymnastic_center/application/blocs/feature_courses/feature_courses_bloc.dart';
import 'package:gymnastic_center/application/blocs/popular_blogs/popular_blogs_bloc.dart';

class BlocResetHandler {
  final GetIt _getIt;

  BlocResetHandler() : _getIt = GetIt.instance;

  void resetBlocs() {
    final categoriesBloc = _getIt<AllCategoriesBloc>();
    categoriesBloc.reset();
    final featuredCourses = _getIt<FeatureCoursesBloc>();
    featuredCourses.reset();
    final popularBlogsBloc = _getIt<PopularBlogsBloc>();
    popularBlogsBloc.reset();
  }
}
