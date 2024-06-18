import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/core/use_case.dart';
import 'package:gymnastic_center/domain/auth/user_repository.dart';

class UpdateUserDto {
  final String? fullName;
  final String? phoneNumber;
  final String? image;

  UpdateUserDto(
    this.image,
    this.fullName,
    this.phoneNumber,
  );
}

class UpdateUserUseCase extends IUseCase<UpdateUserDto, void> {
  final IUserRepository _userRepository;

  UpdateUserUseCase(this._userRepository);

  @override
  Future<Result<void>> execute(UpdateUserDto dto) async {
    final result = await _userRepository.updateUser(dto);
    if (result.isSuccessful) {
      return Result.success(result.unwrap());
    }
    return Result.failure(result.error);
  }
}
