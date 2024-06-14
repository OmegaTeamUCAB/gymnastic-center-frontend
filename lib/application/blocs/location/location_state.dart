import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

abstract class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object> get props => [];
}

class LocationInitial extends LocationState {}

class LocationPermissionGranted extends LocationState {}

class LocationPermissionDenied extends LocationState {}

class LocationPermissionPermanentlyDenied extends LocationState {}

class LocationPermissionNotRequested extends LocationState {}

class LocationLoading extends LocationState {}

class LocationLoaded extends LocationState {
  final Position position;

  const LocationLoaded(this.position);

  @override
  List<Object> get props => [position];
}

class LocationError extends LocationState {
  final String message;

  const LocationError(this.message);

  @override
  List<Object> get props => [message];
}
