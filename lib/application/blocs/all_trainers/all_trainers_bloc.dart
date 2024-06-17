import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gymnastic_center/application/use_cases/trainer/get_trainers.use_case.dart';
import 'package:gymnastic_center/domain/trainer/trainer.dart';
import 'package:gymnastic_center/domain/trainer/trainer_repository.dart';

part 'all_trainers_event.dart';
part 'all_trainers_state.dart';

class AllTrainersBloc extends Bloc<AllTrainersEvent, AllTrainersState> {
  final GetTrainersUseCase getTrainersUseCase;
  AllTrainersBloc(this.getTrainersUseCase) : super(AllTrainersLoading()) {
    on<AllTrainersRequested>(_getAllTrainers);
  }
  Future<void> _getAllTrainers(
      AllTrainersRequested event, Emitter<AllTrainersState> emit) async {
    emit(AllTrainersLoading());
    final result = await getTrainersUseCase.execute(GetTrainersDto(page: event.page));
    if (result.isSuccessful) {
      emit(AllTrainersSuccess(trainers: result.unwrap()));
    } else {
      try {
        throw result.unwrap();
      } catch (e) {
        emit(AllTrainersFailed(message: e.toString()));
      }
    }
  }
}
