import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

part 'camera_permission_state.dart';

class CameraPermissionCubit extends Cubit<CameraPermissionState> {
  CameraPermissionCubit() : super(CameraPermissionInitial());

  Future<void> checkCameraPermission() async {
    emit(CheckingCameraPermission());
    try {
      const Permission permission = Permission.camera;
      PermissionStatus permissionStatus = await permission.status;
      if (permissionStatus.isDenied) {
        permissionStatus = await permission.request();
        if (permissionStatus.isPermanentlyDenied) {
          return emit(CameraPermissionPermanentlyDenied());
        } else if (permissionStatus.isDenied) {
          return emit(CameraPermissionDenied());
        }
      }
      return emit(CameraPermissionGranted());
    } catch (e) {
      return emit(CameraPermissionDenied());
    }
  }
}
