import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/gallery_permission/gallery_permission_cubit.dart';
import '../../widget/app_dialog.dart';
import 'photo_gallery.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key, required this.pageController});
  final PageController pageController;
  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen>
    with WidgetsBindingObserver {
  late final GalleryPermissionCubit galleryPermissionCubit;
  bool checkPermission = false;
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    galleryPermissionCubit = BlocProvider.of<GalleryPermissionCubit>(context);
    galleryPermissionCubit.checkGalleryPermission();
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed && checkPermission) {
      checkPermission = false;
      galleryPermissionCubit.checkGalleryPermission();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocConsumer<GalleryPermissionCubit, GalleryPermissionState>(
        listener: (context, state) {
          if (state is GalleryPermissionGranted) {
          } else if (state is GalleryPermissionDenied) {
            galleryPermissionCubit.checkGalleryPermission();
          } else if (state is GalleryPermissionPermanentlyDenied) {
            appPrimaryDialog(
              barrierDismissible: false,
              context: context,
              title: "Photos",
              subTitle: "App require gallery permission",
              primaryButtonText: 'Settings',
              onTapPrimaryButton: () async {
                Navigator.pop(context);
                await AppSettings.openAppSettings();
                checkPermission = true;
              },
            );
          }
        },
        builder: (context, state) {
          if (state is GalleryPermissionGranted) {
            return const PhotoGallery();
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.camera_alt_rounded),
        onPressed: () {
          widget.pageController.animateToPage(1,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut);
        },
      ),
    );
  }
}
