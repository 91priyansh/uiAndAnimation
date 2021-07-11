import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChessAnimationScreen extends StatefulWidget {
  ChessAnimationScreen({Key? key}) : super(key: key);

  @override
  _ChessAnimationScreenState createState() => _ChessAnimationScreenState();
}

class _ChessAnimationScreenState extends State<ChessAnimationScreen>
    with TickerProviderStateMixin {
  final List<String> menu = ["Random", "Offline", "Friend"];
  int _currentMenuIndex = 1;
  final fontSize = 25.0;

  late AnimationController topCardAnimationController =
      AnimationController(vsync: this, duration: Duration(milliseconds: 750));
  late Animation<Alignment> alignmentAnimation =
      AlignmentTween(begin: Alignment.topRight, end: Alignment.centerRight)
          .animate(CurvedAnimation(
              parent: topCardAnimationController,
              curve: Curves.easeInOutQuint)); //Quint
  late Animation<Color?> colorAnimation =
      ColorTween(begin: Colors.white, end: Colors.black.withOpacity(0.6))
          .animate(CurvedAnimation(
              parent: topCardAnimationController, curve: Curves.easeInOut));
  late Animation<double> baseAnimation = Tween<double>(begin: 0.0, end: 1.0)
      .animate(CurvedAnimation(
          parent: topCardAnimationController, curve: Curves.easeInOut));

  late Animation<Alignment> secondAlignmentAnimation =
      AlignmentTween(begin: Alignment.centerRight, end: Alignment.bottomRight)
          .animate(CurvedAnimation(
              parent: topCardAnimationController,
              curve: Curves.easeInOutQuint));
  late Animation<Color?> secondColorAnimation =
      ColorTween(begin: Colors.black.withOpacity(0.6), end: Colors.white)
          .animate(CurvedAnimation(
              parent: topCardAnimationController, curve: Curves.easeInOut));

  Widget menuItemContainer(
      Color? color, double scale, double angle, double dx, double dy,
      {required Widget child}) {
    return Container(
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.01)
        ..scale(scale)
        ..rotateZ((angle * pi) / 180)
        ..setEntry(0, 3, MediaQuery.of(context).size.width * (dx))
        ..setEntry(1, 3, dy),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(30), color: color),
      width: MediaQuery.of(context).size.width * (0.5),
      height: MediaQuery.of(context).size.height * (0.325),
      child: child,
    );
  }

  Widget playNowButton(VoidCallback onPressed) {
    return CupertinoButton(
      child: Text("Play now"),
      onPressed: onPressed,
      color: Colors.lightBlueAccent,
    );
  }

  final GlobalKey<NavigatorState> dialogKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade100,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              icon: Icon(Icons.next_plan),
              onPressed: () {
                if (topCardAnimationController.isCompleted) {
                  topCardAnimationController.reverse();
                } else {
                  topCardAnimationController.forward();
                }
              },
            ),
          ),
          //fixed bottom card
          Align(
            alignment: Alignment.topRight,
            child: menuItemContainer(
              Colors.white,
              0.775,
              15,
              0.225,
              50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "${menu[_currentMenuIndex - 1]}",
                    style: TextStyle(
                      color: Colors.lightBlue,
                      fontSize: fontSize,
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  playNowButton(() {}),
                ],
              ),
            ),
          ),
          //moving top card
          AnimatedBuilder(
            animation: topCardAnimationController,
            builder: (context, child) {
              double angle =
                  baseAnimation.drive(Tween<double>(begin: 15, end: 0.0)).value;
              double dx = baseAnimation
                  .drive(Tween<double>(begin: 0.225, end: 0.0))
                  .value;
              double dy =
                  baseAnimation.drive(Tween<double>(begin: 50, end: 0.0)).value;
              double scale = baseAnimation
                  .drive(Tween<double>(begin: 0.775, end: 1.0))
                  .value;

              return Align(
                alignment: alignmentAnimation.value,
                child: Opacity(
                    opacity: baseAnimation.value,
                    child: menuItemContainer(
                        colorAnimation.value, scale, angle, dx, dy,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "${menu[_currentMenuIndex - 1]}",
                              style: TextStyle(
                                  color: Colors.lightBlue, fontSize: fontSize),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            playNowButton(() {}),
                          ],
                        ))),
              );
            },
          ),
          //fixed bottom card
          Align(
            alignment: Alignment.bottomRight,
            child: menuItemContainer(Colors.white, 0.775, -15, 0.1, 15,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "${menu[_currentMenuIndex + 1]}",
                      style: TextStyle(
                          color: Colors.lightBlue, fontSize: fontSize),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    playNowButton(() {}),
                  ],
                )),
          ),

          //center card
          AnimatedBuilder(
            animation: topCardAnimationController,
            builder: (context, child) {
              double angle = baseAnimation
                  .drive(Tween<double>(begin: 0.0, end: -15))
                  .value;
              double dx = baseAnimation
                  .drive(Tween<double>(begin: 0.0, end: 0.1))
                  .value;
              double dy = baseAnimation
                  .drive(Tween<double>(begin: 0.0, end: 10.0))
                  .value;
              double scale = baseAnimation
                  .drive(Tween<double>(begin: 1.0, end: 0.775))
                  .value;

              return Align(
                alignment: secondAlignmentAnimation.value,
                child: Opacity(
                    opacity: 1.0 - baseAnimation.value,
                    child: menuItemContainer(
                        secondColorAnimation.value, scale, angle, dx, dy,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "${menu[_currentMenuIndex]}",
                              style: TextStyle(
                                  color: Colors.lightBlue, fontSize: fontSize),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            playNowButton(() {}),
                          ],
                        ))),
              );
            },
          ),
        ],
      ),
    );
  }
}
