import 'package:get_it/get_it.dart';
import 'package:gymnastic_center/application/blocs/all_categories/all_categories_bloc.dart';
import 'package:gymnastic_center/application/blocs/all_courses/all_courses_bloc.dart';
import 'package:gymnastic_center/application/blocs/all_trainers/all_trainers_bloc.dart';
import 'package:gymnastic_center/application/blocs/blog_detail/blog_detail_bloc.dart';
import 'package:gymnastic_center/application/blocs/blogs_by_category/blogs_by_category_bloc.dart';
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
    final allCoursesBloc = _getIt<AllCoursesBloc>();
    allCoursesBloc.reset();
    final allTrainersBloc = _getIt<AllTrainersBloc>();
    allTrainersBloc.reset();
    final blogsByCategoryBloc = _getIt<BlogsByCategoryBloc>();
    blogsByCategoryBloc.reset();
    final blogDetailBloc = _getIt<BlogDetailBloc>();
    blogDetailBloc.reset();
  }
}
