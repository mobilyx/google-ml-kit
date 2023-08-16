import 'package:flutter/material.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key, required this.pageController});
  final PageController pageController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gallery'),
      ),
      body: const Placeholder(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          pageController.animateToPage(2,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut);
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}
