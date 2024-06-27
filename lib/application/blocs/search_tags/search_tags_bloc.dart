import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'search_tags_event.dart';
part 'search_tags_state.dart';

class SearchTagsBloc extends Bloc<SearchTagsEvent, SearchTagsState> {
  final GetSearchTagsUseCase getSearchTagsUseCase;
  final List<String> _cachedSearchTags = [];

  SearchTagsBloc(this.getSearchTagsUseCase) : super(SearchTagsLoading()) {
    on<SearchTagsRequested>(_getSearchTags);
  }

  Future<void> _getSearchTags(
      SearchTagsRequested event, Emitter<SearchTagsState> emit) async {
    if (_cachedSearchTags.isNotEmpty) {
      emit(SearchTagsSuccess(searchTags: _cachedSearchTags));
    } else {
      emit(SearchTagsLoading());
      final result = await getSearchTagsUseCase.execute();
      if (result.isSuccessful) {
        _cachedSearchTags.addAll(result.unwrap());
        emit(SearchTagsSuccess(searchTags: _cachedSearchTags));
      } else {
        try {
          throw result.unwrap();
        } catch (e) {
          emit(SearchTagsFailed(message: e.toString()));
        }
      }
    }
  }
}
