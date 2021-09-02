import 'package:flutter/material.dart';
import 'dart:math' as math;

class TransformScreen extends StatefulWidget {
  TransformScreen({Key? key}) : super(key: key);

  @override
  _TransformScreenState createState() => _TransformScreenState();
}

class _TransformScreenState extends State<TransformScreen>
    with TickerProviderStateMixin {
  late int topContainer = 1;
  late int centerContainer = 2;
  late int bottomContainer = 3;
  late int topBehindContainer = bottomContainer;

  late AnimationController firstAnimationController = AnimationController(
    vsync: this,
    duration: Duration(
      milliseconds: 750,
    ),
  );

  late Animation<Color?> topFirstContainerColor =
      ColorTween(begin: Colors.blue, end: Colors.green)
          .animate(firstAnimationController);

  late Animation<Color?> centerFirstContainerColor =
      ColorTween(begin: Colors.green, end: Colors.blue)
          .animate(firstAnimationController);

  late Animation<Alignment> topFirstContainerAlignment =
      AlignmentTween(begin: Alignment.topCenter, end: Alignment.center)
          .animate(firstAnimationController);

  late Animation<Alignment> centerFirstContainerAlignment =
      AlignmentTween(begin: Alignment.center, end: Alignment.bottomCenter)
          .animate(firstAnimationController);

  late Animation<double> topLastContainerOpacityAnimation =
      Tween<double>(begin: 0, end: 1).animate(firstAnimationController);

  void initAnimation() {
    firstAnimationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 750,
      ),
    );
    topFirstContainerColor = ColorTween(begin: Colors.blue, end: Colors.green)
        .animate(firstAnimationController);

    centerFirstContainerColor =
        ColorTween(begin: Colors.green, end: Colors.blue)
            .animate(firstAnimationController);

    topFirstContainerAlignment =
        AlignmentTween(begin: Alignment.topCenter, end: Alignment.center)
            .animate(firstAnimationController);

    centerFirstContainerAlignment =
        AlignmentTween(begin: Alignment.center, end: Alignment.bottomCenter)
            .animate(firstAnimationController);

    topLastContainerOpacityAnimation =
        Tween<double>(begin: 0, end: 1).animate(firstAnimationController);
  }

  List<Widget> _buildTopContainers() {
    return [
      //2rd
      Align(
        alignment: Alignment.topCenter,
        child: FadeTransition(
          opacity: topLastContainerOpacityAnimation,
          child: CircleAvatar(
            radius: 40,
            backgroundColor: Colors.blue,
            child: Center(
              child: Text("$topBehindContainer"),
            ),
          ),
        ),
      ),
      //1st
      AnimatedBuilder(
        animation: firstAnimationController,
        builder: (context, child) {
          return Align(
            alignment: topFirstContainerAlignment.value,
            child: CircleAvatar(
              radius: 40,
              backgroundColor: topFirstContainerColor.value,
              child: Center(
                child: Text("$topContainer"),
              ),
            ),
          );
        },
      ),
    ];
  }

  List<Widget> _buildCenterContainers() {
    return [
      //1st
      AnimatedBuilder(
        animation: firstAnimationController,
        builder: (context, child) {
          return Align(
            alignment: centerFirstContainerAlignment.value,
            child: CircleAvatar(
              radius: 40,
              backgroundColor: centerFirstContainerColor.value,
              child: Center(
                child: Text("$centerContainer"),
              ),
            ),
          );
        },
      ),
    ];
  }

  List<Widget> _buildBottomCenterContainers() {
    return [
/*
      Align(
        alignment: Alignment.bottomCenter,
        child: CircleAvatar(
          radius: 40,
          backgroundColor: Colors.blue,
          child: Center(
            child: Text("2"),
          ),
        ),
      ),
      //2nd
      Align(
        alignment: Alignment.bottomCenter,
        child: CircleAvatar(
          radius: 40,
          backgroundColor: Colors.blue,
          child: Center(
            child: Text("1"),
          ),
        ),
      ),
      */
      //1st
      Align(
        alignment: Alignment.bottomCenter,
        child: CircleAvatar(
          radius: 40,
          backgroundColor: Colors.blue,
          child: Center(
            child: Text("$bottomContainer"),
          ),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          firstAnimationController.forward(from: 0.0).then((value) {
            //int temp = topBehindContainer;
            firstAnimationController.dispose();
            initAnimation();
            Future.delayed(Duration(seconds: 0), () {
              setState(() {
                bottomContainer = centerContainer;
                centerContainer = topContainer;
                topContainer = topBehindContainer;
                topBehindContainer = bottomContainer;
              });
            });
          });
        },
      ),
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            ..._buildBottomCenterContainers(),
            ..._buildCenterContainers(),
            ..._buildTopContainers(),
          ],
        ),
      ),
    );
  }
}


/*
Center(
        child: Container(
          width: MediaQuery.of(context).size.width * (0.8),
          height: MediaQuery.of(context).size.height * (0.5),
          decoration: BoxDecoration(border: Border.all()),
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateX(1 * math.pi)
              ..scale(1.0),
            child: Container(
              child: Center(
                  child: Text(
                "Hello",
                style: Theme.of(context).textTheme.headline2,
              )),
              decoration: BoxDecoration(color: Colors.greenAccent.shade200),
            ),
          ),
        ),
      ),






 */