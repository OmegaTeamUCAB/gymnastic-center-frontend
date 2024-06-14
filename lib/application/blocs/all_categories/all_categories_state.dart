part of 'all_categories_bloc.dart';

sealed class AllCategoriesState extends Equatable {
  @override
  List<Object> get props => [];
}

final class AllCategoriesLoading extends AllCategoriesState {}

class AllCategoriesSuccess extends AllCategoriesState {
  final List<Category> categories;

  AllCategoriesSuccess({required this.categories});

  @override
  List<Object> get props => [categories];
}

class AllCategoriesFailed extends AllCategoriesState {
  final String message;

  AllCategoriesFailed({required this.message});

  @override
  List<Object> get props => [message];
}
