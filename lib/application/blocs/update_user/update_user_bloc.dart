
// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gymnastic_center/application/use_cases/user/update_user.use_case.dart';


part 'update_user_event.dart';
part 'update_user_state.dart';

class UpdateUserBloc extends Bloc<UpdateUser, UpdateUserState> {
  final UpdateUserUseCase updateUserUseCase;
  UpdateUserBloc(this.updateUserUseCase) : super(UpdateUserLoading()) {
    on<UpdateUser>(_updateUser);
  }

  Future<void> _updateUser(UpdateUser event, Emitter<UpdateUserState> emit) async{
    final result = await updateUserUseCase.execute(UpdateUserDto(
      event.email, 
      event.image, 
      event.fullName, 
      event.phoneNumber)
  
    );
    if (result.isSuccessful) {
      emit(UpdateUserSuccess());
    } else {
      emit(UpdateUserFailed(message: result.error.message));
    }
  }
}