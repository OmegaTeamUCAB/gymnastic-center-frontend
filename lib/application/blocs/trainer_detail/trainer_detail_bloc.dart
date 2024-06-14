import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gymnastic_center/application/use_cases/trainer/get_trainer_by_id.use_case.dart';

part 'trainer_detail_event.dart';
part 'trainer_detail_state.dart';

class TrainerDetailBloc extends Bloc<TrainerDetailEvent, TrainerDetailState> {
  final GetTrainerByIdUseCase getTrainerUseCase;

  TrainerDetailBloc(this.getTrainerUseCase) : super(TrainerDetailLoading()) {
    on<TrainerDetailRequested>(_getTrainerDetail);
  }

  Future<void> _getTrainerDetail(
      TrainerDetailRequested event, Emitter<TrainerDetailState> emit) async {
    emit(TrainerDetailLoading());
    final result =
        await getTrainerUseCase.execute(GetTrainerByIdDto(event.trainerId));
    if (result.isSuccessful) {
      emit(TrainerDetailLoaded(trainer: result.unwrap()));
    } else {
      try {
        throw result.unwrap();
      } catch (e) {
        emit(TrainerDetailFailed(message: e.toString()));
      }
    }
  }
}
