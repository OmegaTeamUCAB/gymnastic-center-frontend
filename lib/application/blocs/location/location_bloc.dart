import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'location_event.dart';
import 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  StreamSubscription<Position>? _positionSubscription;

  LocationBloc() : super(LocationInitial()) {
    on<RequestLocationPermission>(_onRequestLocationPermission);
    on<GetLocation>(_onGetLocation);
    on<UpdateLocation>(_onUpdateLocation);
  }

  Future<void> _onRequestLocationPermission(
      RequestLocationPermission event, Emitter<LocationState> emit) async {
    final status = await Permission.location.request();

    if (status == PermissionStatus.granted) {
      emit(LocationPermissionGranted());
    } else if (status == PermissionStatus.denied) {
      emit(LocationPermissionDenied());
    } else if (status == PermissionStatus.permanentlyDenied) {
      emit(LocationPermissionPermanentlyDenied());
    } else {
      emit(LocationPermissionNotRequested());
    }
  }

  Future<void> _onGetLocation(
      GetLocation event, Emitter<LocationState> emit) async {
    emit(LocationLoading());

    try {
      final position = await Geolocator.getCurrentPosition();
      emit(LocationLoaded(position));

      _positionSubscription?.cancel();
      _positionSubscription = Geolocator.getPositionStream().listen(
        (position) => add(UpdateLocation()),
      );
    } catch (e) {
      emit(LocationError(e.toString()));
    }
  }

  void _onUpdateLocation(
      UpdateLocation event, Emitter<LocationState> emit) async {
    try {
      final position = await Geolocator.getCurrentPosition();
      emit(LocationLoaded(position));
    } catch (e) {
      emit(LocationError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _positionSubscription?.cancel();
    return super.close();
  }
}
