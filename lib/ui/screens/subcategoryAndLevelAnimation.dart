import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SubCategoryAndLevelAnimation extends StatefulWidget {
  SubCategoryAndLevelAnimation({Key? key}) : super(key: key);

  @override
  _SubCategoryAndLevelAnimationState createState() =>
      _SubCategoryAndLevelAnimationState();
}

class _SubCategoryAndLevelAnimationState
    extends State<SubCategoryAndLevelAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController =
      AnimationController(vsync: this, duration: Duration(milliseconds: 650))
        ..forward();

  late Animation<double> _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0)
      .animate(CurvedAnimation(
          parent: _animationController, curve: Curves.easeInOutQuad));

  int currentIndex = 0;
  bool submitted = false;

  void incrementCurrentIndex() {
    setState(() {
      currentIndex++;
      submitted = false;
    });
    _animationController.forward(from: 0.0);
  }

  void changeQuestion() async {
    incrementCurrentIndex();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          incrementCurrentIndex();
        },
        child: Icon(Icons.add),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Opacity(
              opacity: _fadeAnimation.value,
              child: Transform.translate(
                offset: _fadeAnimation
                    .drive<Offset>(Tween<Offset>(
                        begin: Offset(0.0, -25.0), end: Offset(0.0, 0.0)))
                    .value,
                child: QuestionContainer(
                  changeFunction: changeQuestion,
                  index: currentIndex,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class QuestionContainer extends StatefulWidget {
  final int index;
  final Function changeFunction;

  QuestionContainer(
      {Key? key, required this.changeFunction, required this.index})
      : super(key: key);

  @override
  _QuestionContainerState createState() => _QuestionContainerState();
}

class _QuestionContainerState extends State<QuestionContainer> {
  bool submitted = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 250.0,
        ),
        Center(
          child: Text(
            "What is capital of india? ${widget.index}",
            style: TextStyle(fontSize: 20.0),
          ),
        ),
        SizedBox(
          height: 50.0,
        ),
        CupertinoButton(
            color: submitted
                ? widget.index % 2 == 0
                    ? Colors.green
                    : Colors.tealAccent
                : Colors.tealAccent,
            child: Text("Option1 ${widget.index}"),
            onPressed: () async {
              setState(() {
                submitted = true;
              });
              await Future.delayed(Duration(milliseconds: 1000));
              setState(() {
                submitted = false;
              });
              widget.changeFunction();
            }),
        SizedBox(
          height: 50.0,
        ),
        CupertinoButton(
            color: Colors.yellow,
            child: Text("Option3 ${widget.index}"),
            onPressed: () {}),
        SizedBox(
          height: 50.0,
        ),
        AnimatedContainer(
          padding: EdgeInsets.all(25.0),
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInCubic,
          color: submitted
              ? widget.index % 2 != 0
                  ? Colors.redAccent
                  : Colors.tealAccent
              : Colors.tealAccent,
          child: Text("Option2 ${widget.index}"),
        ),
      ],
    );
  }
}
