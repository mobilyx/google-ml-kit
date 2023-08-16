part of 'photo_manager_bloc.dart';

abstract class PhotoManagerEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchPhotos extends PhotoManagerEvent {
  FetchPhotos({
    required this.pageSize,
    required this.page,
    required this.photos,
  });
  final int page;
  final int pageSize;
  final List<AssetEntity> photos;
}
