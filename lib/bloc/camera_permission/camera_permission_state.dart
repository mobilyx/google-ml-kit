part of 'camera_permission_cubit.dart';

abstract class CameraPermissionState extends Equatable {
  const CameraPermissionState();
  @override
  List<Object> get props => [];
}

class CameraPermissionInitial extends CameraPermissionState {}

class CheckingCameraPermission extends CameraPermissionState {}

class CameraPermissionGranted extends CameraPermissionState {}

class CameraPermissionDenied extends CameraPermissionState {}

class CameraPermissionPermanentlyDenied extends CameraPermissionState {}

class CameraPermissionRestricted extends CameraPermissionState {}
