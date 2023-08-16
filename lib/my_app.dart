import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ml_kit/bloc/camera_permission/camera_permission_cubit.dart';
import 'package:flutter_ml_kit/screens/home_screen/home_screen.dart';

import 'bloc/gallery_permission/gallery_permission_cubit.dart';
import 'bloc/photo_manager/photo_manager_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GalleryPermissionCubit>(
          create: (context) => GalleryPermissionCubit(),
        ),
        BlocProvider<PhotoManagerBloc>(
          create: (context) => PhotoManagerBloc(),
        ),
        BlocProvider<CameraPermissionCubit>(
          create: (context) => CameraPermissionCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
          useMaterial3: true,
        ),
        home: const HomeScreen(initialIndex: 0),
      ),
    );
  }
}
