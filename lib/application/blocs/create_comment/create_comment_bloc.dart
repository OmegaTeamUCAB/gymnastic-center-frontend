import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gymnastic_center/application/use_cases/comment/create_comment.use_case.dart';
import 'package:gymnastic_center/domain/comment/comment_repository.dart';

part 'create_comment_event.dart';
part 'create_comment_state.dart';

class CreateCommentBloc extends Bloc<CreateCommentEvent, CreateCommentState> {
  final CreateCommentUseCase createCommentUseCase;
  CreateCommentBloc(
    this.createCommentUseCase,
  ) : super(CreateCommentLoading()) {
    on<CreatedBlogComment>(_createBlogComment);
    on<CreatedCourseComment>(_createCourseComment);
  }

  Future<void> _createBlogComment(
      CreatedBlogComment event, Emitter<CreateCommentState> emit) async {
    emit(CreateCommentLoading());
    final result = await createCommentUseCase.execute(CreateCommentDto(
      lessonOrBlogId: event.blogId,
      content: event.content,
      targetType: 'BLOG',
    ));
    if (result.isSuccessful) {
      emit(CreateCommentSuccess());
    } else {
      emit(CreateCommentFailed(message: result.error.message));
    }
  }

  Future<void> _createCourseComment(
      CreatedCourseComment event, Emitter<CreateCommentState> emit) async {
    emit(CreateCommentLoading());
    final result = await createCommentUseCase.execute(CreateCommentDto(
      lessonOrBlogId: event.courseId,
      content: event.content,
      targetType: 'COURSE',
    ));
    if (result.isSuccessful) {
      emit(CreateCommentSuccess());
    } else {
      emit(CreateCommentFailed(message: result.error.message));
    }
  }
}
