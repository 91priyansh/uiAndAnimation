import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ui_animations/utils/convertNumber.dart';

class PageViewSideMenuScreen extends StatefulWidget {
  PageViewSideMenuScreen({Key? key}) : super(key: key);

  @override
  _PageViewSideMenuScreenState createState() => _PageViewSideMenuScreenState();
}

class _PageViewSideMenuScreenState extends State<PageViewSideMenuScreen>
    with SingleTickerProviderStateMixin {
  double _currentPage = 1.0;
  final _dxPercentage = 0.06;
  final _dy = 40.0; //40 for lowerIndex and -40 for upperIndex than currentIndex
  final _centerColor = 255;
  final _otherColor = 0;
  final _angle =
      15.0; //15 for lowerIndex and -15 for upperIndex than currentIndex
  final _centerAngle = 0.0;
  final _centerScale = 1.0;
  final _otherScale = 0.775;

  late PageController pageController =
      PageController(initialPage: 1, viewportFraction: 0.4)
        ..addListener(pageOffsetLisntner);
  late AnimationController animationController =
      AnimationController(vsync: this, duration: Duration(seconds: 1));

  late Animation<double> angleAnimation = Tween<double>(begin: 20, end: -20)
      .animate(CurvedAnimation(
          parent: animationController, curve: Curves.easeInCirc));

  double _degreeToRadian(double angle) {
    return (angle * pi) / 180.0;
  }

  void pageOffsetLisntner() {
    setState(() {
      _currentPage = pageController.page!;
    });
  }

  @override
  void dispose() {
    pageController.removeListener(pageOffsetLisntner);
    pageController.dispose();
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dsize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade100,
      appBar: AppBar(
        backgroundColor: Colors.lightBlue.shade100,
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              transform: Matrix4.identity()
                ..setEntry(0, 3, dsize.width * (0.5)),
              height: dsize.height * (0.85),
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (scrollNotification) {
                  scrollNotification.disallowGlow();
                  return true;
                },
                child: PageView.builder(
                  clipBehavior: Clip.none,
                  scrollDirection: Axis.vertical,
                  controller: pageController,
                  onPageChanged: (index) {},
                  itemBuilder: (context, index) {
                    //for calculating offset
                    double pageOffset = 1.0 * (index) - _currentPage;
                    double scale = _centerScale;
                    double angle = _centerAngle;
                    double dx = _dxPercentage;
                    double dy = _dy;
                    int color = _centerColor;

                    if (pageOffset <= 0.0) {
                      //converting value for scale,angle,dy,dx and color
                      //based on scroll
                      scale = ConvertNumber.inRange(
                          currentValue: pageOffset,
                          minValue: -1,
                          maxValue: 0.0,
                          newMaxValue: 1.0,
                          newMinValue: _otherScale);
                      angle = ConvertNumber.inRange(
                          currentValue: pageOffset,
                          minValue: -1,
                          maxValue: 0.0,
                          newMaxValue: 0.0,
                          newMinValue: _angle);

                      dy = _dy -
                          ConvertNumber.inRange(
                              currentValue: pageOffset,
                              minValue: -1,
                              maxValue: 0.0,
                              newMaxValue: _dy,
                              newMinValue: 0.0);

                      color = _centerColor -
                          ConvertNumber.inRange(
                                  currentValue: pageOffset,
                                  minValue: -1,
                                  maxValue: 0.0,
                                  newMaxValue: _centerColor.toDouble(),
                                  newMinValue: _otherColor.toDouble())
                              .toInt();
                      if (pageController.position.userScrollDirection ==
                          ScrollDirection.reverse) {
                        //when scrolling up
                        dx = ConvertNumber.inRange(
                            currentValue: pageOffset,
                            minValue: -1,
                            maxValue: 0.0,
                            newMaxValue: 0.0,
                            newMinValue: _dxPercentage);
                      } else {
                        dx = _dxPercentage -
                            ConvertNumber.inRange(
                                currentValue: pageOffset,
                                minValue: -1,
                                maxValue: 0.0,
                                newMaxValue: _dxPercentage,
                                newMinValue: 0.0);
                      }
                    } else {
                      color = ConvertNumber.inRange(
                              currentValue: pageOffset,
                              minValue: 0.0,
                              maxValue: 1.0,
                              newMaxValue: _centerColor.toDouble(),
                              newMinValue: _otherColor.toDouble())
                          .toInt();
                      dy = -_dy -
                          ConvertNumber.inRange(
                              currentValue: pageOffset,
                              minValue: 0.0,
                              maxValue: 1.0,
                              newMaxValue: 0.0,
                              newMinValue: -_dy);
                      dx = ConvertNumber.inRange(
                          currentValue: pageOffset,
                          minValue: 0.0,
                          maxValue: 1.0,
                          newMaxValue: _dxPercentage,
                          newMinValue: 0.0);
                      if (pageController.position.userScrollDirection ==
                          ScrollDirection.reverse) {
                        scale = (1.0 + _otherScale) -
                            ConvertNumber.inRange(
                                currentValue: pageOffset,
                                minValue: 0.0,
                                maxValue: 1.0,
                                newMaxValue: 1.0,
                                newMinValue: _otherScale);
                        angle = -_angle +
                            ConvertNumber.inRange(
                                currentValue: pageOffset,
                                minValue: 0.0,
                                maxValue: 1.0,
                                newMaxValue: 0.0,
                                newMinValue: _angle);
                        if (pageOffset == 1.0) {
                          angle = 0.0;
                          dy = 0.0;
                        }
                      } else {
                        scale = (1.0 + _otherScale) -
                            ConvertNumber.inRange(
                                currentValue: pageOffset,
                                minValue: 0.0,
                                maxValue: 1.0,
                                newMaxValue: 1.0,
                                newMinValue: _otherScale);
                        angle = _angle +
                            ConvertNumber.inRange(
                                currentValue: pageOffset,
                                minValue: 0.0,
                                maxValue: 1.0,
                                newMaxValue: 0.0,
                                newMinValue: -_angle);
                        angle = angle * (-1);
                      }
                    }

                    if (pageOffset < -1.0) {
                      color = _centerColor;
                    } else if (pageOffset > 1.0) {
                      color = _centerColor;
                    }

                    return Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 25.0),
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.01)
                        ..scale(scale)
                        ..setEntry(0, 3, dsize.width * dx)
                        ..setEntry(1, 3, dy)
                        ..rotateZ(_degreeToRadian(angle)),
                      transformAlignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: Color.fromRGBO(color, color, color, 0.9),
                      ),
                    );
                  },
                  itemCount: 10,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


/*
Align(
            alignment: Alignment.centerRight,
            child: Container(
              decoration: BoxDecoration(border: Border.all()),
              child: GestureDetector(
                onTap: () {
                  if (animationController.isCompleted) {
                    animationController.reverse();
                  } else {
                    animationController.forward();
                  }
                },
                child: AnimatedBuilder(
                  animation: animationController,
                  builder: (context, child) {
                    return Container(
                      alignment: Alignment.center,
                      child: Text("Agnes"),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.purple.shade100,
                      ),
                      transformAlignment: Alignment.center,
                      transform: Matrix4.rotationZ(
                          _degreeToRadian(angleAnimation.value)),
                      width: dsize.width * (0.5),
                      height: dsize.height * (0.3),
                    );
                  },
                ),
              ),
            ),
          )
 */