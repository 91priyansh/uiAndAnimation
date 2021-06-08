import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ui_animations/utils/error.dart';

class ClipperScreen extends StatefulWidget {
  ClipperScreen({Key? key}) : super(key: key);

  @override
  _ClipperScreenState createState() => _ClipperScreenState();
}

class _ClipperScreenState extends State<ClipperScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController =
      AnimationController(vsync: this, duration: Duration(milliseconds: 500));

  late Animation<double> aniamation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(curve: Curves.easeInCubic, parent: animationController));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            /*
            if (animationController.isCompleted) {
              animationController.reverse();
            } else {
              animationController.forward();
            }
            */
            showErrorMessage(context, "Unable to load images");
          },
          child: Icon(Icons.restart_alt)),
      body: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return Transform(
            transform: Matrix4.rotationX(pi * aniamation.value),
            alignment: Alignment.bottomCenter,
            child: child,
          );
        },
        child: Padding(
          padding: EdgeInsets.only(top: 100),
          child: ClipPath(
            clipper: ContainerClipper(),
            child: Container(
              height: MediaQuery.of(context).size.height * (0.3),
              width: MediaQuery.of(context).size.width,
              color: Colors.blueAccent,
            ),
          ),
        ),
      ),
    );
  }
}

class ContainerClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    final width = size.width;
    final height = size.height;
    Path path = Path();

    //to make prodracter like shape
    //path.moveTo(0, height);
    //x1 and y1 points are for curve and x2,y2 where you want to end
    //path.quadraticBezierTo(width * (0.55), 0, width, height);
    path.lineTo(width * (0.4), 0);
    path.quadraticBezierTo(width * (0.5), height * (0.2), width * (0.6), 0);
    path.lineTo(width, 0);
    path.lineTo(width, height);
    path.lineTo(0, height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return true;
  }
}
