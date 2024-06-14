import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gymnastic_center/application/use_cases/comment/create_blog_comment.use_case.dart';
import 'package:gymnastic_center/application/use_cases/comment/create_course_comment.use_case.dart';

part 'create_comment_event.dart';
part 'create_comment_state.dart';

class CreateCommentBloc extends Bloc<CreateCommentEvent, CreateCommentState> {
  final CreateCourseCommentUseCase? createCourseCommentUseCase;
  final CreateBlogCommentUseCase? createBlogCommentUseCase;
  CreateCommentBloc({
    this.createCourseCommentUseCase,
    this.createBlogCommentUseCase,
  }) : super(CreateCommentLoading()) {
    on<CreatedBlogComment>(_createBlogComment);
    on<CreatedCourseComment>(_createCourseComment);
  }

  Future<void> _createBlogComment(
      CreatedBlogComment event, Emitter<CreateCommentState> emit) async {
    emit(CreateCommentLoading());
    final result = await createBlogCommentUseCase!.execute(CreateBlogCommentDto(
      userId: event.userId,
      blogId: event.blogId,
      content: event.content,
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
    final result =
        await createCourseCommentUseCase!.execute(CreateCourseCommentDto(
      userId: event.userId,
      courseId: event.courseId,
      lessonId: event.lessonId,
      content: event.content,
    ));
    if (result.isSuccessful) {
      emit(CreateCommentSuccess());
    } else {
      emit(CreateCommentFailed(message: result.error.message));
    }
  }
}
