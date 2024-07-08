import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'brand_notifications_event.dart';
part 'brand_notifications_state.dart';

class BrandNotificationsBloc extends Bloc<BrandNotificationsEvent, BrandNotificationsState> {
  BrandNotificationsBloc() : super(BrandNotificationsInitial()) {
    on<BrandNotificationsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
