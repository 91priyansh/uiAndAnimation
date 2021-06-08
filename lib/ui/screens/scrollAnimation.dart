import 'package:flutter/material.dart';
import 'package:ui_animations/utils/convertNumber.dart';

class ScrollAnimation extends StatefulWidget {
  ScrollAnimation({Key? key}) : super(key: key);

  @override
  _ScrollAnimationState createState() => _ScrollAnimationState();
}

class _ScrollAnimationState extends State<ScrollAnimation>
    with TickerProviderStateMixin {
  late AnimationController colorAnimationController =
      AnimationController(vsync: this);

  late Animation<Color?> colorAnimation =
      ColorTween(begin: Colors.redAccent, end: Colors.pinkAccent).animate(
          CurvedAnimation(
              parent: colorAnimationController, curve: Curves.easeInOut));

  late ScrollController scrollController = ScrollController()
    ..addListener(scrollListener);

  void scrollListener() {
    //it will be in use when you want to animate some external widget
    //based on scroll

    //converting current scroll offset into 0 to 1 range
    //so we can chnage aniamtion controller value
    double convertedValue = ConvertNumber.inRange(
        currentValue: scrollController.offset,
        minValue: scrollController.position.minScrollExtent,
        maxValue: scrollController.position.maxScrollExtent,
        newMaxValue: 1.0,
        newMinValue: 0.0);

    //updating animation
    colorAnimationController.value = convertedValue;
  }

  @override
  void dispose() {
    //removing listener and disposing controllers
    scrollController.removeListener(scrollListener);
    colorAnimationController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          AnimatedBuilder(
              animation: colorAnimation,
              builder: (context, child) {
                return Container(
                  color: colorAnimation.value,
                );
              }),
          ListView.builder(
            controller: scrollController,
            itemBuilder: (context, index) {
              return ListItem(
                index: index,
                scrollController: scrollController,
              );
            },
            itemCount: 10,
          )
        ],
      ),
    );
  }
}

class ListItem extends StatefulWidget {
  final int index;
  final ScrollController scrollController;
  ListItem({Key? key, required this.index, required this.scrollController})
      : super(key: key);

  @override
  _ListItemState createState() => _ListItemState();
}

class _ListItemState extends State<ListItem>
    with SingleTickerProviderStateMixin {
  final heightOfChild = 150.0;

  late AnimationController fadeAnimationController =
      AnimationController(vsync: this);
  late Animation<double> fadeAnimation = Tween<double>(begin: 1.0, end: 0.4)
      .animate(CurvedAnimation(
          parent: fadeAnimationController, curve: Curves.easeInOut));

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(setOffset);
  }

  void setOffset() {
    //it will be in use when you want to animate item based on scroll
    //typically you want to perform some changes while item is going away from
    //view port
    //it is required to know height of child in advance
    //
    /*
    print("Index is 1");
    print(
        "Current offset ${widget.scrollController.offset}"); //pixels it has scrolled
    print("=================================");
    */

    //first of we will calculate difference
    //means how much it has scrolled for given child
    double difference =
        widget.index * heightOfChild - widget.scrollController.offset;
    /*
    if (difference > 0) {
      print("Opactiy will be full");
    } else*/

    //we need to animate only when difference in beetween 0 and -heightOfChild
    if (difference > -heightOfChild && difference <= 0) {
      //print("We will change the opacity");
      //print("Actual difference value is $difference");
      double convertedValue = ConvertNumber.inRange(
          currentValue: -difference,
          minValue: 0,
          maxValue: heightOfChild,
          newMaxValue: 1.0,
          newMinValue: 0.0);
      //print("Converted value $convertedValue");
      fadeAnimationController.value = convertedValue;
    } else {
      //
      //when user scroll fast sometimes you see state of animation in middle
      //to avoid that we are changing aniamtionController.value to initial or to 0
      //
      if (fadeAnimationController.value != 0.0) {
        fadeAnimationController.value = 0.0;
      }
    }
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(setOffset);
    fadeAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: fadeAnimation,
      child: SizedBox(
        height: heightOfChild,
        child: Card(
          child: Center(child: Text("${widget.index}")),
          margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        ),
      ),
    );
  }
}
