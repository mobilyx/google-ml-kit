import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_manager/photo_manager.dart';

part 'photo_manager_event.dart';
part 'photo_manager_state.dart';

class PhotoManagerBloc extends Bloc<PhotoManagerEvent, PhotoManagerState> {
  PhotoManagerBloc() : super(PhotoManagerInitial()) {
    on<FetchPhotos>((event, emit) async {
      event.page < 1
          ? emit(FetchingPhotoFirstPage())
          : emit(FetchingPhotoNextPage(photos: event.photos));
      final List<AssetPathEntity> paths = await PhotoManager.getAssetPathList(
        onlyAll: true,
        type: RequestType.image,
      );

      final int length = await paths.first.assetCountAsync;
      if ((event.page * event.pageSize) >= length || length == 0) {
        emit(PhotosFetchedSuccessfully(photos: event.photos));
        return;
      }
      List<AssetEntity> assetEntities = await paths.first
          .getAssetListPaged(page: event.page, size: event.pageSize);
      event.photos.addAll(assetEntities);
      emit(PhotosFetchedSuccessfully(photos: event.photos));
    });
  }
}
