import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gymnastic_center/application/use_cases/search/get_search_tags.use_case.dart';

part 'get_search_tags_event.dart';
part 'search_tags_state.dart';

class GetSearchTagsBloc extends Bloc<GetSearchTagsEvent, GetSearchTagsState> {
  final GetSearchTagsUseCase getSearchTagsUseCase;
  GetSearchTagsBloc(this.getSearchTagsUseCase) : super(SearchTagsLoading()) {
    on<SearchTagsRequested>(_getSearchTags);
  }

  Future<void> _getSearchTags(
      SearchTagsRequested event, Emitter<GetSearchTagsState> emit) async {
    emit(SearchTagsLoading());
    final result = await getSearchTagsUseCase.execute(SearchTagsDto());
    if (result.isSuccessful) {
      emit(GetSearchTagsSuccess(searchTags: result.unwrap()));
    } else {
      try {
        throw result.unwrap();
      } catch (e) {
        emit(GetSearchTagsFailed(message: e.toString()));
      }
    }
  }
}
