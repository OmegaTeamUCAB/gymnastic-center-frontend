
import 'package:bloc/bloc.dart';
import 'package:gymnastic_center/domain/auth/user.dart';
import 'package:gymnastic_center/infrastructure/repositories/user/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;
  UserBloc(this.userRepository) : super(const UserState()) {
    on<UpdateUser>((event, emit) {
      emit(state.copyWith(
        name: event.user.fullName,
        email: event.user.email,
        phone: event.user.phoneNumber,
        image: event.user.image
      ));
    });
  }
}
