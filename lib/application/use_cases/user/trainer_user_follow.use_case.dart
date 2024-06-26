import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/core/use_case.dart';
import 'package:gymnastic_center/domain/auth/user_repository.dart';

class TrainerUserFollowUseCase extends IUseCase<int, int> {
  final IUserRepository _userRepository;

  TrainerUserFollowUseCase(this._userRepository);

  @override
  Future<Result<int>> execute(int dto) async {
    final result = await _userRepository.trainerUserFollow();
    if (result.isSuccessful) {
      return Result.success(result.unwrap());
    }
    return Result.failure(result.error);
  }
}
