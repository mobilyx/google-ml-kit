import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ml_kit/bloc/camera_permission/camera_permission_cubit.dart';

import '../../widget/app_dialog.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen>
    with WidgetsBindingObserver {
  late final CameraPermissionCubit cameraPermissionCubit;
  bool checkPermission = false;
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    cameraPermissionCubit = BlocProvider.of<CameraPermissionCubit>(context);
    cameraPermissionCubit.checkCameraPermission();
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
      cameraPermissionCubit.checkCameraPermission();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<CameraPermissionCubit, CameraPermissionState>(
        listener: (context, state) {
          if (state is CameraPermissionDenied) {
            cameraPermissionCubit.checkCameraPermission();
          } else if (state is CameraPermissionPermanentlyDenied) {
            appPrimaryDialog(
              barrierDismissible: false,
              context: context,
              title: "Camera",
              subTitle: "App require camera permission",
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
          if (state is CameraPermissionGranted) {
            return const Center(
              child: Text(
                "Camera Permission Granted",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
