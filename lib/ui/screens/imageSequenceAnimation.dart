import 'dart:math';

import 'package:flutter/material.dart';

import 'package:image_sequence_animator/image_sequence_animator.dart';

class ImageSequenceAnimationScreen extends StatefulWidget {
  ImageSequenceAnimationScreen({Key? key}) : super(key: key);

  @override
  _ImageSequenceAnimationScreenState createState() =>
      _ImageSequenceAnimationScreenState();
}

class _ImageSequenceAnimationScreenState
    extends State<ImageSequenceAnimationScreen>
    with SingleTickerProviderStateMixin {
  List<String> images = [];
  ImageSequenceAnimatorState? imageSequenceAnimatorState;

  late AnimationController animationController =
      AnimationController(vsync: this, duration: Duration(milliseconds: 500));
  late Animation<double> angleAnimation = Tween<double>(begin: 0.0, end: -45.0)
      .animate(CurvedAnimation(
          parent: animationController, curve: Curves.easeInOut));

  @override
  void initState() {
    getImagesPath();
    super.initState();
  }

  void getImagesPath() {
    String prefixPath = "assets/images/";
    String suffixPath = "-min.png";
    for (var i = 1; i < 71; i++) {
      if (i < 10) {
        images.add("${prefixPath}000$i$suffixPath");
      } else {
        images.add("${prefixPath}00$i$suffixPath");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: animationController,
          builder: (context, child) {
            return Transform(
              child: child,
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY((angleAnimation.value * pi) / 180),
            );
          },
          child: ImageSequenceAnimator(
            "assets/images",
            "",
            0,
            5,
            "png",
            70,
            fps: 60,
            fullPaths: images,
            isAutoPlay: true,
            isLooping: true,
            onReadyToPlay: (state) {
              imageSequenceAnimatorState = state;
            },
            onPlaying: (state) {},
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          imageSequenceAnimatorState?.stop();
          animationController.forward();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
