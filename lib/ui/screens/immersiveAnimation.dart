import 'package:flutter/material.dart';

class ImmersiveAnimation extends StatefulWidget {
  ImmersiveAnimation({Key? key}) : super(key: key);

  @override
  _ImmersiveAnimationState createState() => _ImmersiveAnimationState();
}

class _ImmersiveAnimationState extends State<ImmersiveAnimation>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return FirstScreen();
  }
}

class FirstScreen extends StatelessWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 750),
                  pageBuilder: (context, first, second) {
                    return SecocndScreen(index: index);
                  }));
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
              height: MediaQuery.of(context).size.height * (0.125),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                    tag: "container$index",
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 20.0,
                        ),
                        ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Hero(
                                tag: "image$index",
                                child: Image.asset("assets/agnes.png"))),
                        SizedBox(
                          width: 20.0,
                        ),
                        Text(
                          "Agnes",
                          style: Theme.of(context).textTheme.headline6,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: 10,
      ),
    );
  }
}

class SecocndScreen extends StatefulWidget {
  final int index;
  SecocndScreen({Key? key, required this.index}) : super(key: key);

  @override
  _SecocndScreenState createState() => _SecocndScreenState();
}

class _SecocndScreenState extends State<SecocndScreen>
    with TickerProviderStateMixin {
  late AnimationController animationController =
      AnimationController(vsync: this, duration: Duration(milliseconds: 750));
  late Animation<double> animation = Tween<double>(begin: 1.0, end: 0.0)
      .animate(CurvedAnimation(
          parent: animationController, curve: Curves.easeInOutQuart));
  late Animation<double> scaleAnimation = Tween<double>(begin: 1.0, end: 0.5)
      .animate(CurvedAnimation(
          parent: animationController,
          curve: Interval(0.0, 0.5, curve: Curves.easeInOutCirc)));

  late Animation<double> opacityAnimation = Tween<double>(begin: 1.0, end: 0.0)
      .animate(CurvedAnimation(
          parent: animationController,
          curve: Interval(0.0, 0.5, curve: Curves.easeInOutCirc)));

  late Animation<double> titleOpacityAnimation =
      Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
          parent: animationController,
          curve: Interval(0.85, 1.0, curve: Curves.easeInOutCirc)));

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (animationController.isCompleted) {
          animationController.reverse();
          return Future.value(false);
        }
        return Future.value(true);
      },
      child: Scaffold(
        body: Stack(
          children: [
            AnimatedBuilder(
              animation: animationController,
              builder: (context, child) {
                return Positioned(
                  top: MediaQuery.of(context).size.height *
                      (0.6) *
                      (animation.value - 1.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * (0.6),
                    child: Stack(
                      children: [
                        Hero(
                          tag: "container${widget.index}",
                          child: Container(
                            color: Colors.black26,
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Transform.scale(
                            scale: scaleAnimation.value,
                            child: Hero(
                                tag: "image${widget.index}",
                                child: Image.asset(
                                  "assets/agnes.png",
                                  fit: BoxFit.cover,
                                  height: MediaQuery.of(context).size.height *
                                      (0.25),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * (0.4),
                child: AnimatedBuilder(
                  animation: animationController,
                  builder: (context, child) {
                    return Opacity(
                      opacity: opacityAnimation.value,
                      child: child,
                    );
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * (0.4),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  animationController.forward();
                                },
                                child: Text("Submit")),
                            SizedBox(
                              width: 25.0,
                            ),
                            ElevatedButton(
                                onPressed: () {}, child: Text("Submit")),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                onPressed: () {}, child: Text("Submit")),
                            SizedBox(
                              width: 25.0,
                            ),
                            ElevatedButton(
                                onPressed: () {}, child: Text("Submit")),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            AnimatedBuilder(
              builder: (context, child) {
                return Positioned(
                  top: MediaQuery.of(context).size.height * (animation.value),
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            padding: EdgeInsets.only(bottom: 15.0),
                            alignment: Alignment.bottomCenter,
                            child: Opacity(
                              opacity: titleOpacityAnimation.value,
                              child: Text(
                                "Photos",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            height:
                                MediaQuery.of(context).size.height * (0.125),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height *
                                    (0.125)),
                            child: GridView.builder(
                              padding: EdgeInsets.only(top: 25.0),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 10.0),
                              itemBuilder: (context, index) {
                                return Container(
                                    margin: EdgeInsets.only(
                                        bottom: 15.0,
                                        left: index % 2 == 0 ? 10 : 0,
                                        right: index % 2 != 0 ? 10 : 0),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20.0),
                                      child: Image.asset(
                                        "assets/02.jpg",
                                        fit: BoxFit.cover,
                                      ),
                                    ));
                              },
                              itemCount: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              animation: animation,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                child: IconButton(
                  onPressed: () {
                    if (animationController.isCompleted) {
                      animationController.reverse();
                    } else {
                      Navigator.of(context).pop();
                    }
                  },
                  icon: Icon(Icons.arrow_back_ios),
                ),
                padding: EdgeInsets.only(top: 50.0, left: 25.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
