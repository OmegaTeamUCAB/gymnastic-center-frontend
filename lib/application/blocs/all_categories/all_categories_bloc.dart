import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gymnastic_center/application/use_cases/category/get_all_categories.use_case.dart';
import 'package:gymnastic_center/domain/category/category.dart';

part 'all_categories_event.dart';
part 'all_categories_state.dart';

class AllCategoriesBloc extends Bloc<AllCategoriesEvent, AllCategoriesState> {
  final GetAllCategoriesUseCase getAllCategoriesUseCase;
  final List<Category> _cachedCategories = [];

  AllCategoriesBloc(this.getAllCategoriesUseCase)
      : super(AllCategoriesLoading()) {
    on<AllCategoriesRequested>(_getAllCategories);
  }

  Future<void> _getAllCategories(
      AllCategoriesRequested event, Emitter<AllCategoriesState> emit) async {
    if (_cachedCategories.isNotEmpty) {
      emit(AllCategoriesSuccess(categories: _cachedCategories));
    } else {
      emit(AllCategoriesLoading());
      final result =
          await getAllCategoriesUseCase.execute(GetAllCategoriesDto());
      if (result.isSuccessful) {
        _cachedCategories.addAll(result.unwrap());
        emit(AllCategoriesSuccess(categories: _cachedCategories));
      } else {
        try {
          throw result.unwrap();
        } catch (e) {
          emit(AllCategoriesFailed(message: e.toString()));
        }
      }
    }
  }
}
