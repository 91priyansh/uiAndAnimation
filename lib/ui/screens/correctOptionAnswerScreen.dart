import 'package:flutter/material.dart';

class CorrectOptionAnswer extends StatelessWidget {
  const CorrectOptionAnswer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * (0.1),
          ),
          Center(child: OptionContainer()),
          SizedBox(
            height: MediaQuery.of(context).size.height * (0.1),
          ),
          Center(child: FindOpponentLetterAnimation()),
        ],
      ),
    );
  }
}

class FindOpponentLetterAnimation extends StatefulWidget {
  FindOpponentLetterAnimation({Key? key}) : super(key: key);

  @override
  _FindOpponentLetterAnimationState createState() =>
      _FindOpponentLetterAnimationState();
}

class _FindOpponentLetterAnimationState
    extends State<FindOpponentLetterAnimation> with TickerProviderStateMixin {
  late AnimationController letterAnimationController =
      AnimationController(vsync: this, duration: Duration(seconds: 4))
        ..repeat(reverse: false);

  late Animation<int> letterAnimation =
      IntTween(begin: 0, end: 25).animate(letterAnimationController);

  late List<String> letters = [
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "L",
    "M",
    "N",
    "O",
    "P",
    "Q",
    "R",
    "S",
    "T",
    "U",
    "V",
    "W",
    "X",
    "Y",
    "Z"
  ];

  @override
  void dispose() {
    letterAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 50.0,
      backgroundColor: Colors.redAccent.shade100,
      child: Center(
        child: AnimatedBuilder(
          animation: letterAnimationController,
          builder: (context, child) {
            return Text(
              letters[letterAnimation.value],
              style: TextStyle(
                color: Colors.white,
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      ),
    );
  }
}

class OptionContainer extends StatefulWidget {
  OptionContainer({Key? key}) : super(key: key);

  @override
  _OptionContainerState createState() => _OptionContainerState();
}

class _OptionContainerState extends State<OptionContainer>
    with TickerProviderStateMixin {
  late AnimationController animationController =
      AnimationController(vsync: this, duration: Duration(milliseconds: 90));
  late Animation<double> animation = Tween<double>(begin: 0.0, end: 1.0)
      .animate(CurvedAnimation(
          parent: animationController, curve: Curves.easeInQuad));

  late AnimationController topContainerAnimationController =
      AnimationController(vsync: this, duration: Duration(milliseconds: 180));
  late Animation<double> topContainerOpacityAnimation =
      Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
    parent: topContainerAnimationController,
    curve: Interval(0.0, 0.25, curve: Curves.easeInQuad),
  ));

  late Animation<double> topContainerAnimation =
      Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
          parent: topContainerAnimationController,
          curve: Interval(0.0, 0.5, curve: Curves.easeInQuad)));

  late Animation<double> answerCorrectnessAnimation =
      Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
          parent: topContainerAnimationController,
          curve: Interval(0.5, 1.0, curve: Curves.easeInQuad)));

  @override
  void dispose() {
    animationController.dispose();
    topContainerAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapCancel: () {
        animationController.reverse();
      },
      onTap: () async {
        animationController.reverse();
        await topContainerAnimationController.forward();
      },
      onTapDown: (_) {
        animationController.forward();
      },
      child: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return Transform.scale(
            scale: animation.drive(Tween<double>(begin: 1.0, end: 0.9)).value,
            child: child,
          );
        },
        child: Container(
          width: MediaQuery.of(context).size.width * (0.8),
          height: MediaQuery.of(context).size.height * (0.075),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25.0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 20.0),
                  color: Colors.lightBlueAccent,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Some Text",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                IgnorePointer(
                  ignoring: true,
                  child: AnimatedBuilder(
                    builder: (context, child) {
                      final height = topContainerAnimation
                          .drive(Tween<double>(begin: 0.07, end: 0.075))
                          .value;
                      final width = topContainerAnimation
                          .drive(Tween<double>(begin: 0.2, end: 0.8))
                          .value;

                      final borderRadius = topContainerAnimation
                          .drive(Tween<double>(begin: 45.0, end: 25))
                          .value;

                      return Opacity(
                        opacity: topContainerOpacityAnimation.value,
                        child: Container(
                          alignment: Alignment.center,
                          child: Transform.scale(
                            scale: answerCorrectnessAnimation.value,
                            child: Opacity(
                              opacity: answerCorrectnessAnimation.value,
                              child: Icon(Icons.check, color: Colors.white),
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius:
                                  BorderRadius.circular(borderRadius)),
                          width: MediaQuery.of(context).size.width * width,
                          height: MediaQuery.of(context).size.height * height,
                        ),
                      );
                    },
                    animation: topContainerAnimationController,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
