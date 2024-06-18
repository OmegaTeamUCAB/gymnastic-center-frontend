// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gymnastic_center/application/use_cases/user/update_user.use_case.dart';

part 'update_user_event.dart';
part 'update_user_state.dart';

class UpdateUserBloc extends Bloc<UpdatedUser, UpdateUserState> {
  final UpdateUserUseCase updateUserUseCase;
  UpdateUserBloc(this.updateUserUseCase) : super(UpdateUserInitial()) {
    on<UpdatedUser>(_updateUser);
  }

  Future<void> _updateUser(
      UpdatedUser event, Emitter<UpdateUserState> emit) async {
    emit(UpdateUserLoading());
    final result = await updateUserUseCase
        .execute(UpdateUserDto(event.image, event.fullName, event.phoneNumber));
    if (result.isSuccessful) {
      emit(UpdateUserSuccess());
    } else {
      emit(UpdateUserFailed(message: result.error.message));
    }
  }
}
