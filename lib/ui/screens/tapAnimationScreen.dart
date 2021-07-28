import 'package:flutter/material.dart';

class TapAnimationScreen extends StatefulWidget {
  TapAnimationScreen({Key? key}) : super(key: key);

  @override
  _TapAnimationScreenState createState() => _TapAnimationScreenState();
}

class _TapAnimationScreenState extends State<TapAnimationScreen>
    with TickerProviderStateMixin {
  late AnimationController animationController =
      AnimationController(vsync: this, duration: Duration(milliseconds: 75));
  late Animation<double> animation = Tween<double>(begin: 0.0, end: 1.0)
      .animate(CurvedAnimation(
          parent: animationController, curve: Curves.easeInQuad));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
              child: AnimatedTapContainer(
            child: Container(
              alignment: Alignment.center,
              child: Text("Name is safed kapda"),
              height: MediaQuery.of(context).size.height * (0.1),
              width: MediaQuery.of(context).size.width * (0.85),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
          ))
          /*
          Center(
            child: Material(
              borderRadius: BorderRadius.circular(35.0),
              color: Theme.of(context).accentColor,
              child: InkWell(
                borderRadius: BorderRadius.circular(35.0),
                onTap: () {
                  animationController.reverse();
                },
                onTapDown: (tapDownDetails) {
                  animationController.forward();
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 70.0,
                  height: 70.0,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(35.0)),
                  child: AnimatedBuilder(
                    animation: animationController,
                    builder: (context, child) {
                      return Text(
                        "1",
                        style: TextStyle(
                            fontSize: 25.0 - (5.0 * animation.value),
                            color: Theme.of(context).scaffoldBackgroundColor),
                      );
                    },
                  ),
                ),
              ),
            ),
          )
         
          
          
          */
        ],
      ),
    );
  }
}

class AnimatedTapContainer extends StatefulWidget {
  final Duration? duration;
  final Curve? curve;
  final double? endScale;
  final Widget child;
  AnimatedTapContainer(
      {Key? key, this.curve, this.duration, this.endScale, required this.child})
      : super(key: key);

  @override
  _AnimatedTapContainerState createState() => _AnimatedTapContainerState();
}

class _AnimatedTapContainerState extends State<AnimatedTapContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController = AnimationController(
      vsync: this, duration: widget.duration ?? Duration(milliseconds: 75));
  late Animation<double> animation = Tween<double>(begin: 0.0, end: 1.0)
      .animate(CurvedAnimation(
          parent: animationController,
          curve: widget.curve ?? Curves.easeInQuad));

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          animationController.reverse();
        },
        onTapDown: (tapDownDetails) {
          animationController.forward();
        },
        onTapCancel: () {
          animationController.reverse();
        },
        child: AnimatedBuilder(
          animation: animationController,
          builder: (context, child) {
            double scale = animation
                .drive(Tween<double>(begin: 1.0, end: widget.endScale ?? 0.875))
                .value;
            return Transform.scale(
              scale: scale,
              child: child,
            );
          },
          child: widget.child,
        ));
  }
}
