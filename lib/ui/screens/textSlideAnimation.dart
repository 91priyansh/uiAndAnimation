import 'package:flutter/material.dart';

class TextSlideAnimation extends StatefulWidget {
  TextSlideAnimation({Key? key}) : super(key: key);

  @override
  _TextSlideAnimationState createState() => _TextSlideAnimationState();
}

class _TextSlideAnimationState extends State<TextSlideAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController changePizzaController =
      AnimationController(vsync: this, duration: Duration(milliseconds: 500));
  List<Tween<double>> translatePizzaTitleTweens = [];

  List<Animation<double>> translatePizzaTitleAnimations = [];

  List<Tween<double>> translatePizzaTitleOpacityTweens = [];

  List<Animation<double>> translatePizzaTitleOpacityAnimations = [];
  /*
  late AnimationController hoverAnimationController =
      AnimationController(vsync: this, duration: Duration(milliseconds: 200));

  late Animation<double> hoverAnimation = Tween<double>(begin: 300, end: 150.0)
      .animate(CurvedAnimation(
          parent: hoverAnimationController, curve: Curves.easeInOut));

  */

  final List<String> _messages = ["Okay", "No Problem", "So What", "Hmmmmmmm"];

  int currentIndex = 0;

  double heightAndWidth = 300;

  @override
  void initState() {
    initAnimations();
    super.initState();
  }

  void initAnimations() {
    for (int i = 0; i < _messages.length; i++) {
      double begin = (i - currentIndex) * -40;

      translatePizzaTitleTweens.add(Tween<double>(
        begin: begin,
        end: begin + 40, //(currentIndex + 1)*40 + begin
      ));
      translatePizzaTitleAnimations
          .add(translatePizzaTitleTweens[i].animate(changePizzaController));

      //-----------
      if (currentIndex == i) {
        translatePizzaTitleOpacityTweens.add(Tween<double>(
          begin: 1.0,
          end: 0.0, //(currentIndex + 1)*40 + begin
        ));
      } else if (i == (currentIndex + 1)) {
        translatePizzaTitleOpacityTweens.add(Tween<double>(
          begin: 0.0,
          end: 1.0, //(currentIndex + 1)*40 + begin
        ));
      } else {
        translatePizzaTitleOpacityTweens.add(Tween<double>(
          begin: 0.0,
          end: 0.0, //(currentIndex + 1)*40 + begin
        ));
      }

      translatePizzaTitleOpacityAnimations.add(
          translatePizzaTitleOpacityTweens[i].animate(changePizzaController));
    }
  }

  List<Widget> _buildMessages() {
    List<Widget> messages = [];
    for (int i = 0; i < _messages.length; i++) {
      messages.add(
        Align(
          alignment: Alignment.center,
          child: AnimatedBuilder(
            animation: changePizzaController,
            builder: (context, child) {
              return Opacity(
                opacity: translatePizzaTitleOpacityAnimations[i].value,
                child: Transform.translate(
                  offset: Offset(0.0, translatePizzaTitleAnimations[i].value),
                  child: Container(
                      decoration: i == currentIndex
                          ? BoxDecoration(border: Border.all())
                          : null,
                      child: child),
                ),
              );
            },
            child: Text(
              "${_messages[i]}",
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        ),
      );
    }
    return messages;
  }
  /*
  Widget itemContainer() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                  alignment: Alignment.center,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.white,
                    ),
                    height: 300,
                    width: 300,
                  )),
              Align(
                  alignment: Alignment.center,
                  child: AnimatedBuilder(
                    animation: hoverAnimationController,
                    builder: (context, child) {
                      return InkWell(
                        borderRadius: BorderRadius.circular(20.0),
                        onTap: () {},
                        onHover: (value) async {
                          if (value) {
                            if (!hoverAnimationController.isAnimating) {
                              hoverAnimationController.forward().then((value) {
                                hoverAnimationController.reverse();
                              });
                            }
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            image: DecorationImage(
                                image: AssetImage("assets/images/temp.png")),
                            //border: Border.all(),
                          ),
                          height: hoverAnimation.value,
                          width: hoverAnimation.value,
                        ),
                      );
                    },
                  )),
            ],
          ),
        ),
        SizedBox(
          height: 15.0,
        ),
        Text("Hello"),
      ],
    );
  }
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 20,
              width: 100,
              color: Colors.yellow,
            ),
          ),
          ..._buildMessages(),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  onPressed: () {
                    if (currentIndex == _messages.length - 1) {
                      return;
                    }
                    for (int i = 0; i < _messages.length; i++) {
                      if (currentIndex == i) {
                        translatePizzaTitleOpacityTweens[i].begin = 1.0;

                        translatePizzaTitleOpacityTweens[i].end = 0.0;
                      } else if (i == (currentIndex + 1)) {
                        translatePizzaTitleOpacityTweens[i].begin = 0.0;

                        translatePizzaTitleOpacityTweens[i].end = 1.0;
                      } else {
                        translatePizzaTitleOpacityTweens[i].begin = 0.0;

                        translatePizzaTitleOpacityTweens[i].end = 0.0;
                      }
                      //-------------

                      if (currentIndex == 0) {
                        double begin = (i) * -40;

                        translatePizzaTitleTweens[i].begin = begin;
                        translatePizzaTitleTweens[i].end = begin + 40;
                      } else {
                        translatePizzaTitleTweens[i].begin =
                            translatePizzaTitleTweens[i].end;

                        translatePizzaTitleTweens[i].end =
                            translatePizzaTitleTweens[i].begin! + 40;
                      }
                    }

                    changePizzaController.forward(from: 0.0).then((value) {
                      setState(() {
                        currentIndex++;
                      });
                    });
                  },
                  icon: Icon(Icons.add)),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  onPressed: () {
                    if (currentIndex == 0) {
                      return;
                    }
                    for (int i = 0; i < _messages.length; i++) {
                      if (currentIndex == i) {
                        translatePizzaTitleOpacityTweens[i].begin = 1.0;

                        translatePizzaTitleOpacityTweens[i].end = 0.0;
                      } else if (i == (currentIndex - 1)) {
                        translatePizzaTitleOpacityTweens[i].begin = 0.0;

                        translatePizzaTitleOpacityTweens[i].end = 1.0;
                      } else {
                        translatePizzaTitleOpacityTweens[i].begin = 0.0;

                        translatePizzaTitleOpacityTweens[i].end = 0.0;
                      }

                      //
                      translatePizzaTitleTweens[i].begin =
                          translatePizzaTitleTweens[i].end;

                      translatePizzaTitleTweens[i].end =
                          translatePizzaTitleTweens[i].begin! - 40;
                    }

                    changePizzaController.forward(from: 0.0).then((value) {
                      setState(() {
                        currentIndex--;
                      });
                    });
                  },
                  icon: Icon(Icons.remove)),
            ),
          ),
        ],
      ),
    );
  }
}
