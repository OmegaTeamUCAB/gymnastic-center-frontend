

import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/core/use_case.dart';
import 'package:gymnastic_center/domain/auth/user.dart';

class UpdateProfileDto{
  final String fullName;
  final String phoneNumber;
  final String gender;

  UpdateProfileDto({
    required this.fullName, 
    required this.phoneNumber, 
    required this.gender
  });
  
}

class UpdateProfileUseCase extends IUseCase<UpdateProfileDto,User>{
  @override
  Future<Result<User>> execute(UpdateProfileDto dto) {
    throw UnimplementedError();
  }

}