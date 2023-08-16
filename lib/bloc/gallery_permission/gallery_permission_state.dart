part of 'gallery_permission_cubit.dart';

abstract class GalleryPermissionState extends Equatable {
  const GalleryPermissionState();
  @override
  List<Object> get props => [];
}

class GalleryPermissionInitial extends GalleryPermissionState {}

class CheckingGalleryPermission extends GalleryPermissionState {}

class GalleryPermissionGranted extends GalleryPermissionState {}

class GalleryPermissionDenied extends GalleryPermissionState {}

class GalleryPermissionPermanentlyDenied extends GalleryPermissionState {}

class GalleryPermissionRestricted extends GalleryPermissionState {}
