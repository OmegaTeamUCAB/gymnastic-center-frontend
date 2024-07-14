

import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/core/use_case.dart';
import 'package:gymnastic_center/domain/comment/comment_repository.dart';

class DeleteCommentDto {
  final String commentId;

  DeleteCommentDto(this.commentId);
}

class DeleteCommentUseCase  extends IUseCase<DeleteCommentDto,void> {
  final ICommentRepository commentRepository;

  DeleteCommentUseCase(this.commentRepository);

  @override
  Future<Result<void>> execute(DeleteCommentDto dto) async {
    return await commentRepository.deleteComment(dto.commentId);
  }

}