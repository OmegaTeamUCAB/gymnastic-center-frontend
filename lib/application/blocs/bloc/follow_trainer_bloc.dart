import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/use_cases/trainer/follow_trainer.use_case.dart';

part 'follow_trainer_event.dart';
part 'follow_trainer_state.dart';

class FollowTrainerBloc extends Bloc<FollowTrainerEvent, FollowTrainerState> {
  final FollowTrainersUseCase followTrainersUseCase;
  FollowTrainerBloc(this.followTrainersUseCase)
      : super(FollowTrainerLoading()) {
    on<FollowRequested>(_followRequested);
  }

  Future<void> _followRequested(
      FollowRequested event, Emitter<FollowTrainerState> emit) async {
    emit(FollowTrainerLoading());
    final result =
        await followTrainersUseCase.execute(FollowTrainerDto(event.id));
    if (result.isSuccessful) {
      emit(const FollowTrainerSuccess());
    } else {
      emit(FollowTrainerFailed(message: result.error.message));
    }
  }
}
