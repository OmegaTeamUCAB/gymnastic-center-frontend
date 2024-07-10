import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gymnastic_center/application/use_cases/search/get_search_tags.use_case.dart';

part 'get_search_tags_event.dart';
part 'search_tags_state.dart';

class GetSearchTagsBloc extends Bloc<GetSearchTagsEvent, GetSearchTagsState> {
  final GetSearchTagsUseCase getSearchTagsUseCase;
  final List<String> _cachedSearchTags = [];

  GetSearchTagsBloc(this.getSearchTagsUseCase) : super(SearchTagsLoading()) {
    on<SearchTagsRequested>(_getGetSearchTags);
  }

  Future<void> _getGetSearchTags(
      SearchTagsRequested event, Emitter<GetSearchTagsState> emit) async {
    if (_cachedSearchTags.isNotEmpty) {
      emit(GetSearchTagsSuccess(searchTags: _cachedSearchTags));
    } else {
      emit(SearchTagsLoading());
      final result = await getSearchTagsUseCase.execute(SearchTagsDto());
      if (result.isSuccessful) {
        _cachedSearchTags.addAll(result.unwrap());
        emit(GetSearchTagsSuccess(searchTags: _cachedSearchTags));
      } else {
        try {
          throw result.unwrap();
        } catch (e) {
          emit(GetSearchTagsFailed(message: e.toString()));
        }
      }
    }
  }
}
