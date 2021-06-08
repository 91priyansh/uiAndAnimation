import 'package:flutter/material.dart';

class NumberAnimation extends StatefulWidget {
  NumberAnimation({Key? key}) : super(key: key);

  @override
  _NumberAnimationState createState() => _NumberAnimationState();
}

class _NumberAnimationState extends State<NumberAnimation>
    with SingleTickerProviderStateMixin {
  int value = 0;
  bool increment = true;
  late AnimationController animationController =
      AnimationController(vsync: this, duration: Duration(milliseconds: 500))
        ..forward();
  late Animation<double> animation = Tween<double>(begin: 0.0, end: 1.0)
      .animate(CurvedAnimation(
          parent: animationController, curve: Curves.easeInOutQuad));
  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  value--;
                  increment = false;
                });
                animationController.forward(from: 0.0);
              },
              icon: Icon(Icons.remove))
        ],
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: animationController,
          builder: (_, child) {
            return Opacity(
                opacity: animation.value,
                child: Transform.translate(
                  offset: animation
                      .drive<Offset>(Tween<Offset>(
                          begin: Offset(0.0, increment ? -50.0 : 50.0),
                          end: Offset(0.0, 0.0)))
                      .value,
                  child: Text(
                    "$value",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              value++;
              increment = true;
            });
            animationController.forward(from: 0.0);
          },
          child: Icon(Icons.plus_one)),
    );
  }
}


/*
ZoomIn(
            controller: (controller) => animationController = controller,
            duration: Duration(milliseconds: 500),
            manualTrigger: true,
            child: Text(
              "$value",
              style: Theme.of(context).textTheme.headline1,
            ))



TweenAnimationBuilder<int>(
          tween: IntTween(begin: 0, end: value),
          duration: Duration(milliseconds: 1000),
          builder: (context, value, child) {
            return Text(
              "$value",
              style: Theme.of(context).textTheme.headline1,
            );
          },
        )


 */