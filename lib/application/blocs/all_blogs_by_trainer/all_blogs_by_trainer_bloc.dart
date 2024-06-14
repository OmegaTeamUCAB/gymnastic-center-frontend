import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/use_cases/blog/get_blogs.use_case.dart';
import 'package:gymnastic_center/domain/blog/blog.dart';
import 'package:gymnastic_center/domain/blog/blog_repository.dart';

part 'all_blogs_by_trainer_event.dart';
part 'all_blogs_by_trainer_state.dart';

class AllBlogsByTrainerBloc
    extends Bloc<AllBlogsByTrainerEvent, AllBlogsByTrainerState> {
  final GetBlogsUseCase getAllBlogsByTrainerUseCase;
  AllBlogsByTrainerBloc(this.getAllBlogsByTrainerUseCase)
      : super(AllBlogsByTrainerLoading()) {
    on<AllBlogsByTrainerRequested>(_getAllBlogsByTrainer);
  }

  Future<void> _getAllBlogsByTrainer(AllBlogsByTrainerRequested event,
      Emitter<AllBlogsByTrainerState> emit) async {
    emit(AllBlogsByTrainerLoading());
    final result = await getAllBlogsByTrainerUseCase
        .execute(GetBlogsDto(page: event.page, trainerId: event.trainerId));
    if (result.isSuccessful) {
      final previousBlogs = state is AllBlogsByTrainerSuccess
          ? (state as AllBlogsByTrainerSuccess).blogs
          : <Blog>[];
      final currentBlogs = result.unwrap();
      final allBlogs = [...previousBlogs, ...currentBlogs];
      emit(AllBlogsByTrainerSuccess(blogs: allBlogs));
    } else {
      try {
        throw result.unwrap();
      } catch (e) {
        emit(AllBlogsByTrainerFailed(message: e.toString()));
      }
    }
  }
}
