import 'package:flutter/material.dart';
import 'package:flutter_ml_kit/screens/camera_screen/camera_screen.dart';
import 'package:flutter_ml_kit/screens/gallery_screen/gallery_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, this.initialIndex = 0});
  final int initialIndex;
  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController(initialPage: initialIndex);
    return PageView(
      controller: pageController,
      children: [
        GalleryScreen(pageController: pageController),
        const CameraScreen(),
      ],
    );
  }
}
