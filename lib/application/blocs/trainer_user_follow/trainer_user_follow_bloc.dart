import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/use_cases/user/trainer_user_follow.use_case.dart';

part 'trainer_user_follow_event.dart';
part 'trainer_user_follow_state.dart';

class TrainerUserFollowBloc
    extends Bloc<TrainerUserFollowEvent, TrainerUserFollowState> {
  final TrainerUserFollowUseCase _trainerUserFollowUseCase;

  TrainerUserFollowBloc(this._trainerUserFollowUseCase)
      : super(TrainerUserFollowLoading()) {
    on<TrainerUserFollowRequested>(_onTrainerUserFollowRequested);
  }

  Future<void> _onTrainerUserFollowRequested(TrainerUserFollowRequested event,
      Emitter<TrainerUserFollowState> emit) async {
    emit(TrainerUserFollowLoading());
    final result = await _trainerUserFollowUseCase.execute(0);
    if (result.isSuccessful) {
      emit(TrainerUserFollowSuccess(count: result.unwrap()));
    } else {
      emit(TrainerUserFollowFailed(message: result.error.toString()));
    }
  }
}
