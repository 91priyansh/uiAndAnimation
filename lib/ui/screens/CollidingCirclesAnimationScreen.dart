import 'package:flutter/material.dart';

class CollidingCirclesAnimationScreen extends StatefulWidget {
  CollidingCirclesAnimationScreen({Key? key}) : super(key: key);

  @override
  _CollidingCirclesAnimationScreenState createState() =>
      _CollidingCirclesAnimationScreenState();
}

class _CollidingCirclesAnimationScreenState
    extends State<CollidingCirclesAnimationScreen>
    with TickerProviderStateMixin {
  late AnimationController circlesAnimationController =
      AnimationController(vsync: this, duration: Duration(milliseconds: 600))
        ..repeat(reverse: true);

  late Animation<double> circleAnimation = Tween<double>(begin: 0.0, end: 1.0)
      .animate(CurvedAnimation(
          parent: circlesAnimationController, curve: Curves.easeInOut));

  @override
  void dispose() {
    circlesAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
        ),
        child: Stack(
          children: [
            //
            Align(
              alignment: Alignment.topCenter,
              child: AnimatedBuilder(
                animation: circlesAnimationController,
                builder: (context, child) {
                  final dx = circleAnimation
                      .drive(Tween<double>(begin: -1.25, end: -0.5))
                      .value;
                  return FractionalTranslation(
                    translation: Offset(dx, 0.0),
                    child: child,
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * (0.025),
                    //right: MediaQuery.of(context).size.width * (0.29)
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          MediaQuery.of(context).size.width * (0.15)),
                      color: Colors.blueAccent.shade200),
                  height: MediaQuery.of(context).size.width * (0.3),
                  width: MediaQuery.of(context).size.width * (0.3),
                ),
              ),
            ),

            Align(
              alignment: Alignment.topCenter,
              child: AnimatedBuilder(
                animation: circlesAnimationController,
                builder: (context, child) {
                  final dx = circleAnimation
                      .drive(Tween<double>(begin: 1.0, end: 0.475))
                      .value;
                  return FractionalTranslation(
                    translation: Offset(dx, 0.0),
                    child: child,
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * (0.05),
                    //left: MediaQuery.of(context).size.width * (0.3)
                  ), //0.7
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          MediaQuery.of(context).size.width * (0.15)),
                      color: Colors.blueAccent.shade200),
                  height: MediaQuery.of(context).size.width * (0.3),
                  width: MediaQuery.of(context).size.width * (0.3),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
