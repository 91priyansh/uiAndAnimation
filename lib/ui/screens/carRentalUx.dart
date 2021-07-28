import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CarRental extends StatefulWidget {
  CarRental({Key? key}) : super(key: key);

  @override
  _CarRentalState createState() => _CarRentalState();
}

class _CarRentalState extends State<CarRental> with TickerProviderStateMixin {
  //to animate
  late AnimationController _animationController = AnimationController(
      vsync: this, duration: Duration(milliseconds: 1550)); //1150

  late Animation<double> _animation = Tween<double>(begin: 0.0, end: 1.0)
      .animate(CurvedAnimation(
          parent: _animationController, curve: Curves.easeInQuad));

  late Animation<double> _bottomSheetAnimation =
      Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
          parent: _animationController,
          curve: Interval(0.0, 0.45, curve: Curves.easeInQuad)));

  late Animation<double> _carFirstAnimation =
      Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
          parent: _animationController,
          curve: Interval(0.0, 0.25, curve: Curves.easeInQuad)));

  late Animation<double> _carSecondAnimation =
      Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
          parent: _animationController,
          curve: Interval(0.25, 0.45, curve: Curves.easeInQuad)));

  late Animation<double> _carThirdAnimation =
      Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
          parent: _animationController,
          curve: Interval(0.45, 0.65, curve: Curves.easeInQuad)));

  late Animation<double> _carFourthAnimation =
      Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
          parent: _animationController,
          curve: Interval(0.65, 0.85, curve: Curves.easeInQuad)));

  late Animation<double> _otherDetailsAnimation =
      Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
          parent: _animationController,
          curve: Interval(0.7, 1.0, curve: Curves.easeInQuad)));

  Widget _buildCarContainer() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        double heightPercentage = 0.3 +
            0.025 * (_carFirstAnimation.value) -
            0.025 * (_carSecondAnimation.value) +
            0.025 * (_carThirdAnimation.value);
        double widthPercentage = 0.75 +
            0.075 * (_carFirstAnimation.value) -
            0.075 * _carSecondAnimation.value +
            0.075 * (_carThirdAnimation.value);
        double angle = 30 * (1.0 - _carFirstAnimation.value) +
            (30 * _carSecondAnimation.value) +
            -30 * _carFourthAnimation.value;

        double topMarginPercentage = _carSecondAnimation
            .drive(Tween<double>(begin: 0.375, end: 0.2))
            .value;

        return Align(
          alignment: Alignment.topCenter,
          child: Container(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.0002)
              ..rotateX((pi * angle) / 180.0),
            transformAlignment: Alignment.bottomCenter,
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * topMarginPercentage),
            height: MediaQuery.of(context).size.height * heightPercentage,
            width: MediaQuery.of(context).size.width * widthPercentage,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.0),
              color: Colors.lightBlue.shade100,
            ),
          ),
        );
      },
    );
  }

  Widget _buildBottomSheetContainer() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Positioned(
          child: child!,
          bottom: 0.0 -
              MediaQuery.of(context).size.height *
                  (0.45) *
                  _bottomSheetAnimation.value,
        );
      },
      child: Container(
        height: MediaQuery.of(context).size.height * (0.45),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50.0),
              topRight: Radius.circular(50.0),
            ),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 5.0,
              ),
            ]),
      ),
    );
  }

  Widget _buildTopUp() {
    return Align(
      alignment: Alignment.center,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Opacity(
            opacity: _otherDetailsAnimation.value,
            child: Container(
              alignment: Alignment.center,
              child: Icon(
                Icons.add,
                size: 25 + (10 * _otherDetailsAnimation.value),
              ),
              margin: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width * (0.3),
                  top: MediaQuery.of(context).size.height * (0.25)),
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateX(
                    (pi * 60 * (1.0 - _otherDetailsAnimation.value)) / 180),
              transformAlignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                color: Colors.greenAccent,
                borderRadius: BorderRadius.circular(25.0),
              ),
              height: MediaQuery.of(context).size.height *
                  (0.05 + (0.075) * _otherDetailsAnimation.value),
              width: MediaQuery.of(context).size.width * (0.45),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNotification() {
    return Align(
      alignment: Alignment.center,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Opacity(
            opacity: _otherDetailsAnimation.value,
            child: Container(
              margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * (0.5),
                  top: MediaQuery.of(context).size.height * (0.25)),
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateX(
                    (pi * 60 * (1.0 - _otherDetailsAnimation.value)) / 180),
              transformAlignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                color: Colors.deepPurpleAccent,
                borderRadius: BorderRadius.circular(25.0),
              ),
              height: MediaQuery.of(context).size.height *
                  (0.05 + (0.075) * _otherDetailsAnimation.value),
              width: MediaQuery.of(context).size.width * (0.3),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMapDetails() {
    return Align(
      alignment: Alignment.topCenter,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Opacity(
            opacity: _otherDetailsAnimation.value,
            child: Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * (0.725)), //0.675
              decoration: BoxDecoration(
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(50.0),
              ),
              height: MediaQuery.of(context).size.height *
                  (0.1 + (0.15) * _otherDetailsAnimation.value),
              width: MediaQuery.of(context).size.width * (0.8),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarBrightness: Brightness.light));
            if (_animationController.isCompleted) {
              _animationController.reverse();
            } else {
              _animationController.forward();
            }
          },
        ),
        backgroundColor: Color(0xffFFFDD0),
        body: Stack(
          children: [
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Positioned(
                  top: -MediaQuery.of(context).size.height *
                      (0.775) *
                      (1.0 - _animation.value),
                  child: CustomPaint(
                    painter: BackgroundContainerCustomPainter(_animation
                        .drive(Tween<double>(begin: 0.5, end: 1.0))
                        .value),
                    size: Size(MediaQuery.of(context).size.width,
                        MediaQuery.of(context).size.height),
                  ),
                );
              },
            ),
            _buildCarContainer(),
            _buildBottomSheetContainer(),
            _buildTopUp(),
            _buildNotification(),
            _buildMapDetails()
          ],
        ));
  }
}

class BackgroundContainerCustomPainter extends CustomPainter {
  final double dy;
  BackgroundContainerCustomPainter(this.dy);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.black87;
    Path path = Path();
    path.lineTo(size.width, 0.0);
    path.lineTo(size.width, size.height * dy);
    path.quadraticBezierTo(
        size.width * (0.5), size.height * 1.0, 0.0, size.height * dy);

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
