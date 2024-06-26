
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/use_cases/comment/delete_comment.use_case.dart';

part 'delete_comment_event.dart';
part 'delete_comment_state.dart';

class DeleteCommentBloc extends Bloc<DeleteCommentEvent, DeleteCommentState> {
  final DeleteCommentUseCase deleteCommentUseCase;
  DeleteCommentBloc(this.deleteCommentUseCase) : super(DeleteCommentLoading()) {
    on<DeleteRequested>(_deleteRequested);
  }

  Future<void> _deleteRequested(DeleteRequested event, Emitter<DeleteCommentState> emit) async{
    emit(DeleteCommentLoading());
    final result =
        await deleteCommentUseCase.execute(DeleteCommentDto(event.id));
    if (result.isSuccessful) {
      emit(const DeleteCommentSuccess());
    } else {
      emit(DeleteCommentFailed(message: result.error.message));
    }
  }
}
