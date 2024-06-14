import 'package:equatable/equatable.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}

class RequestLocationPermission extends LocationEvent {}

class GetLocation extends LocationEvent {}

class UpdateLocation extends LocationEvent {}
