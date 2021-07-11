import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingShapeAnimation extends StatefulWidget {
  LoadingShapeAnimation({Key? key}) : super(key: key);

  @override
  _LoadingShapeAnimationState createState() => _LoadingShapeAnimationState();
}

class _LoadingShapeAnimationState extends State<LoadingShapeAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController =
      AnimationController(vsync: this)..addListener(animationListener);

  void animationListener() {
    if (currentIndex == 1) {
      if (animationController.value > 0.33) {
        animationController.forward(from: 0.0);
      }
    } else if (currentIndex == 2) {
      if (animationController.value > 0.66) {
        animationController.forward(from: 0.34);
      }
    } else if (currentIndex == 3) {
      if (animationController.value > 0.66) {
        print(animationController.value);
        //animationController.forward(from: 0.67);
      }
    }
  }

  int currentIndex = 1;
  double secondScreenHeroWidgetScale = 1.0;
  double heroWidgetScale = 1.5; //need to check reverse duration

  @override
  void dispose() {
    animationController.removeListener(animationListener);
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  currentIndex = 3;
                });
              },
              icon: Icon(Icons.add))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            currentIndex = 2;
          });
        },
        child: Icon(Icons.star_outline),
      ),
      body: Center(
        child: Lottie.asset("assets/loadingShape.json",
            controller: animationController, onLoaded: (lottieComposition) {
          animationController..duration = lottieComposition.duration;
          print(animationController.duration?.inSeconds);
          print(lottieComposition.frameRate);
          animationController..repeat(reverse: false);
          //lottieComposition.
        }),
      ),
    );
  }
}

/*
class SecondScreen extends StatefulWidget {
  final int index;
  SecondScreen({Key? key, required this.index}) : super(key: key);

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  double heroWidgetScale = 1.25;
  late PageController pageController = PageController(viewportFraction: 0.8);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pop(heroWidgetScale);
        },
        child: Icon(Icons.ac_unit),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * (0.325),
        child: PageView.builder(
          itemBuilder: (context, index) {
            return Container(
              transformAlignment: Alignment.center,
              transform: Matrix4.identity()..scale(heroWidgetScale),
              child: Hero(
                flightShuttleBuilder:
                    (context, animation, direction, fromContext, toContext) {
                  print("In Second screen");

                  return AnimatedBuilder(
                    animation: animation,
                    builder: (context, child) {
                      //begin with scale of fromContext.widget(screen from we are pushing page)
                      //end is scale of widget in second screen
                      double scale = animation
                          .drive(
                              Tween<double>(begin: 1.5, end: heroWidgetScale))
                          .value;
                      return Transform.scale(
                          scale: scale, child: toContext.widget);
                    },
                  );
                },
                tag: widget.index == index ? "pizza$index" : "$index",
                child: Image.asset(
                  "assets/03.png",
                ),
              ),
            );
          },
          itemCount: 10,
        ),
      ),
    );
  }
}
*/

/*

Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push<double>(PageRouteBuilder(
            pageBuilder: (context, animation, _) {
              return SecondScreen(index: 0);
            },
            transitionDuration: Duration(
              milliseconds: 2500,
            ),
            reverseTransitionDuration: Duration(
              milliseconds: 2500,
            ),
          ))
              .then((value) {
            //setState(() {
            secondScreenHeroWidgetScale = value!;
            //});
          });
        },
        child: Icon(Icons.ac_unit),
      ),
      body: Align(
        alignment: Alignment.centerLeft,
        child: Hero(
          flightShuttleBuilder:
              (context, animation, direction, fromContext, toContext) {
            print("In first screen");
            return AnimatedBuilder(
                animation: animation,
                builder: (context, child) {
                  //Since animaition will run in reverse so
                  //we animate scale from secondScreen hero widget scale
                  //to firstScreen widget scale

                  //if firstScreen widget scale is greater than
                  //1.0 then secondScreen hero widget scale
                  //then endScale with [1.0 - (1.1 - secondScreenHeroWidgetScale)]
                  //else endScale with secondScreenHeroWidgetScale
                  double endScale = heroWidgetScale >
                          secondScreenHeroWidgetScale
                      ? 1.0 - (heroWidgetScale - secondScreenHeroWidgetScale)
                      : secondScreenHeroWidgetScale;

                  //if firstScreen widget scale is greater than
                  //1.0 then secondScreen hero widget scale
                  //then begin with 1.0
                  //else begin with firstScreen Scale
                  double beginScale =
                      heroWidgetScale > secondScreenHeroWidgetScale
                          ? 1.0
                          : heroWidgetScale;

                  double scale = animation
                      .drive(Tween<double>(begin: beginScale, end: endScale))
                      .value;
                  return Transform(
                    alignment: Alignment.center, //

                    transform: Matrix4.identity()..scale(scale),
                    child: toContext.widget, //try with fromContext.widget
                  );
                });
          },
          tag: "pizza0",
          child: Container(
            transformAlignment: Alignment.center,
            transform: Transform.scale(scale: heroWidgetScale).transform,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/03.png")),
            ),
            height: 150.0,
            width: 150.0,
          ),
        ),
      ),
    );
    


 */
