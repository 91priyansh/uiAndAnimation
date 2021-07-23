import 'package:flutter/material.dart';

class QuizPlayAreaScreen extends StatefulWidget {
  QuizPlayAreaScreen({Key? key}) : super(key: key);

  @override
  _QuizPlayAreaScreenState createState() => _QuizPlayAreaScreenState();
}

class _QuizPlayAreaScreenState extends State<QuizPlayAreaScreen>
    with TickerProviderStateMixin {
  late AnimationController questionAnimationController;

  late AnimationController questionContentAnimationController =
      AnimationController(vsync: this, duration: Duration(milliseconds: 500))
        ..forward();

  late AnimationController timerAnimationController =
      AnimationController(vsync: this, duration: Duration(seconds: 10))
        ..forward();

  late Animation<double> questionSlideAnimation;
  late Animation<double> questionScaleUpAnimation;

  late Animation<double> questionScaleDownAnimation;
  late Animation<double> questionContentAnimation =
      Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
          parent: questionContentAnimationController, curve: Curves.easeInOut));

  late int currentQuestionIndex = 0;

  @override
  void initState() {
    initializeAnimation();
    super.initState();
  }

  void initializeAnimation() {
    questionAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 750));

    questionSlideAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: questionAnimationController, curve: Curves.easeInOut));

    questionScaleUpAnimation = Tween<double>(begin: 0.0, end: 0.2).animate(
        CurvedAnimation(
            parent: questionAnimationController,
            curve: Interval(0.0, 0.5, curve: Curves.easeInOut)));

    questionScaleDownAnimation = Tween<double>(begin: 0.0, end: 0.1).animate(
        CurvedAnimation(
            parent: questionAnimationController,
            curve: Interval(0.5, 1.0, curve: Curves.easeInOut)));
  }

  Widget _buildQuesitonContainer(double scale, int index) {
    return Center(
      child: GestureDetector(
        onTap: () {
          if (currentQuestionIndex != 3) {
            questionAnimationController.forward(from: 0.0).then((value) {
              //questionContentAnimationController.forward(from: 0.0);
              questionAnimationController.dispose();

              setState(() {
                currentQuestionIndex++;
                initializeAnimation();
              });
            });
          }
        },
        child: Container(
          child: SlideTransition(
            position: questionContentAnimation.drive(
                Tween<Offset>(begin: Offset(0.5, 0.0), end: Offset.zero)),
            child: FadeTransition(
              opacity: questionContentAnimation,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * (0.05),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without",
                      style: TextStyle(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        fontSize: 17.0,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          transform: Matrix4.identity()..scale(scale),
          transformAlignment: Alignment.center,
          width: MediaQuery.of(context).size.width * (0.8),
          height: MediaQuery.of(context).size.height * (0.7),
          decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              borderRadius: BorderRadius.circular(25)),
        ),
      ),
    );
  }

  Widget _buildQuestion(int questionIndex) {
    if (currentQuestionIndex == questionIndex) {
      return SlideTransition(
          child: _buildQuesitonContainer(1.0, questionIndex),
          position: questionSlideAnimation.drive(
              Tween<Offset>(begin: Offset.zero, end: Offset(-1.5, 0.0))));
    } else if (questionIndex > currentQuestionIndex &&
        (questionIndex == currentQuestionIndex + 1)) {
      return AnimatedBuilder(
          animation: questionAnimationController,
          builder: (context, child) {
            double scale = 0.9 +
                questionScaleUpAnimation.value -
                questionScaleDownAnimation.value;
            return _buildQuesitonContainer(scale, questionIndex);
          });
    } else if (questionIndex > currentQuestionIndex) {
      return _buildQuesitonContainer(1.0, questionIndex);
    }
    return Container();
  }

  List<Widget> _buildQuesitons() {
    List<Widget> children = [];

    for (var i = 0; i < 3; i++) {
      children.add(_buildQuestion(i));
    }

    children = children.reversed.toList();

    return children;
  }

  Widget _buildBackgroundCard(
      double opacity, double widthPercentage, double topMarginPercentage) {
    return Center(
      child: Opacity(
        opacity: opacity,
        child: Container(
          margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * topMarginPercentage),
          width: MediaQuery.of(context).size.width * widthPercentage,
          height: MediaQuery.of(context).size.height * 0.7,
          decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              borderRadius: BorderRadius.circular(25)),
        ),
      ),
    );
  }

  Widget _buildTimerContainer() {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Stack(
          children: [
            Container(
              color: Colors.lightBlueAccent.withOpacity(0.5),
              height: 10.0,
              width: MediaQuery.of(context).size.width,
            ),
            AnimatedBuilder(
              animation: timerAnimationController,
              builder: (context, child) {
                return Container(
                  color: Colors.lightBlueAccent,
                  height: 10.0,
                  width: MediaQuery.of(context).size.width *
                      timerAnimationController.value,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildTimerContainer(),
          _buildBackgroundCard(0.85, 0.7, 0.05),
          _buildBackgroundCard(0.7, 0.6, 0.09),
          ..._buildQuesitons()
        ],
      ),
    );
  }
}
