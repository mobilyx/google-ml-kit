import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:photo_manager/photo_manager.dart';

import '../../bloc/photo_manager/photo_manager_bloc.dart';

class PhotoGallery extends StatefulWidget {
  const PhotoGallery({super.key});

  @override
  State<PhotoGallery> createState() => _PhotoGalleryState();
}

class _PhotoGalleryState extends State<PhotoGallery> {
  int page = 0;
  final int pageSize = 30;
  late final PhotoManagerBloc photoManagerBloc;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    final PhotoManagerBloc photoManagerBloc =
        BlocProvider.of<PhotoManagerBloc>(context);
    photoManagerBloc
        .add(FetchPhotos(pageSize: pageSize, page: page, photos: []));
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (photoManagerBloc.state is PhotosFetchedSuccessfully) {
          photoManagerBloc.add(
            FetchPhotos(
              pageSize: pageSize,
              page: ++page,
              photos: photoManagerBloc.state is PhotosFetchedSuccessfully
                  ? (photoManagerBloc.state as PhotosFetchedSuccessfully).photos
                  : [],
            ),
          );
        }
      }
    });
    super.initState();
  }

  final List<QuiltedGridTile> leftTile = const [
    QuiltedGridTile(1, 1),
    QuiltedGridTile(1, 1),
    QuiltedGridTile(2, 1),
    QuiltedGridTile(1, 1),
    QuiltedGridTile(1, 1),
  ];

  final List<QuiltedGridTile> rightTile = const [
    QuiltedGridTile(2, 1),
    QuiltedGridTile(1, 1),
    QuiltedGridTile(1, 1),
    QuiltedGridTile(1, 1),
    QuiltedGridTile(1, 1),
  ];
  final List<QuiltedGridTile> bigTile = const [
    QuiltedGridTile(2, 2),
    QuiltedGridTile(1, 1),
    QuiltedGridTile(1, 1),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PhotoManagerBloc, PhotoManagerState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is PhotosFetchedSuccessfully) {
          return Stack(
            children: [
              GridView.custom(
                controller: scrollController,
                gridDelegate: SliverQuiltedGridDelegate(
                  crossAxisCount: 3,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  repeatPattern: QuiltedGridRepeatPattern.same,
                  pattern: [
                    //==============Left Panel==============
                    ...leftTile,
                    //================Right Panel===========
                    ...rightTile,
                    //==============Left Panel==============
                    ...leftTile,
                    //===============Big Tile=============
                    ...bigTile,
                    //==============Left Panel==============
                    ...leftTile,
                    //================Right Panel===========
                    ...rightTile,
                    //==============Left Panel==============
                    ...leftTile,
                    //================Right Panel===========
                    ...rightTile,
                    //==============Left Panel==============
                    ...leftTile,
                    //================Right Panel===========
                    ...rightTile,
                    //==============Left Panel==============
                    ...leftTile,
                    //===============Big Tile=============
                    ...bigTile,
                  ],
                ),
                childrenDelegate: SliverChildBuilderDelegate(
                  childCount: state.photos.length,
                  (context, index) => GestureDetector(
                    onTap: () {},
                    child: AssetEntityImage(
                      state.photos[index],
                      fit: BoxFit.cover,
                      isOriginal: false,
                      filterQuality: FilterQuality.low,
                      thumbnailFormat: ThumbnailFormat.jpeg,
                    ),
                  ),
                ),
              ),
              if (state is FetchingPhotoNextPage)
                Container(
                  color: Colors.black26,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            ],
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
