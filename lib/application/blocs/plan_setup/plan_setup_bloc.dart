import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'plan_setup_event.dart';
part 'plan_setup_state.dart';

class PlanSetupBloc extends Bloc<PlanSetupEvent, PlanSetupState> {
  PlanSetupBloc() : super(const PlanSetupState());
}
