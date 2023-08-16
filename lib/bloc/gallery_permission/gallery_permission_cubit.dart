import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

part 'gallery_permission_state.dart';

class GalleryPermissionCubit extends Cubit<GalleryPermissionState> {
  GalleryPermissionCubit() : super(GalleryPermissionInitial());

  checkGalleryPermission() async {
    emit(CheckingGalleryPermission());
    try {
      late final Permission permission;
      if (Platform.isAndroid) {
        final androidInfo = await DeviceInfoPlugin().androidInfo;
        if (androidInfo.version.sdkInt <= 32) {
          permission = Permission.storage;
        } else {
          permission = Permission.photos;
        }
      } else {
        permission = Permission.photos;
      }
      PermissionStatus permissionStatus = await permission.status;
      if (permissionStatus.isDenied) {
        permissionStatus = await permission.request();
        if (permissionStatus.isPermanentlyDenied) {
          return emit(GalleryPermissionPermanentlyDenied());
        } else if (permissionStatus.isDenied) {
          return emit(GalleryPermissionDenied());
        }
      }
      return emit(GalleryPermissionGranted());
    } catch (e) {
      emit(GalleryPermissionDenied());
    }
  }
}
