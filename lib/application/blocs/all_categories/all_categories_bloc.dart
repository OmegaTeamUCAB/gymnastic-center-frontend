import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gymnastic_center/application/use_cases/category/get_all_categories.use_case.dart';
import 'package:gymnastic_center/domain/category/category.dart';

part 'all_categories_event.dart';
part 'all_categories_state.dart';

class AllCategoriesBloc extends Bloc<AllCategoriesEvent, AllCategoriesState> {
  final GetAllCategoriesUseCase getAllCategoriesUseCase;
  AllCategoriesBloc({required this.getAllCategoriesUseCase})
      : super(AllCategoriesLoading()) {
    on<AllCategoriesRequested>(_getAllCategories);
  }

  Future<void> _getAllCategories(
      AllCategoriesRequested event, Emitter<AllCategoriesState> emit) async {
    emit(AllCategoriesLoading());
    final result = await getAllCategoriesUseCase.execute(GetAllCategoriesDto());
    if (result.isSuccessful) {
      emit(AllCategoriesSuccess(categories: result.unwrap()));
    } else {
      try {
        throw result.unwrap();
      } catch (e) {
        emit(AllCategoriesFailed(message: e.toString()));
      }
    }
  }
}
