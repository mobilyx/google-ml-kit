part of 'photo_manager_bloc.dart';

abstract class PhotoManagerState extends Equatable {
  @override
  List<Object> get props => [];
}

class PhotoManagerInitial extends PhotoManagerState {}

class FetchingPhotoFirstPage extends PhotoManagerState {
  FetchingPhotoFirstPage();
}

class PhotosFetchedSuccessfully extends PhotoManagerState {
  PhotosFetchedSuccessfully({required this.photos});
  final List<AssetEntity> photos;
}

class FetchingPhotoNextPage extends PhotosFetchedSuccessfully {
  FetchingPhotoNextPage({required List<AssetEntity> photos})
      : super(photos: photos);
}

class FetchingPhotoFailed extends PhotoManagerState {
  FetchingPhotoFailed({required this.errorMessage});
  final String errorMessage;
}
