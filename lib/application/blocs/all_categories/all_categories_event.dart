part of 'all_categories_bloc.dart';

sealed class AllCategoriesEvent {
  const AllCategoriesEvent();
}

class AllCategoriesRequested extends AllCategoriesEvent {
  AllCategoriesRequested();
}
