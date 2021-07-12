import 'package:flutter/material.dart';

class AnimatedExpandableMenu extends StatefulWidget {
  AnimatedExpandableMenu({Key? key}) : super(key: key);

  @override
  _AnimatedExpandableMenuState createState() => _AnimatedExpandableMenuState();
}

class _AnimatedExpandableMenuState extends State<AnimatedExpandableMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Animated Expandable Menu"),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return AnimatedMenu(index: index);
        },
        itemCount: 10,
      ),
    );
  }
}

class AnimatedMenu extends StatefulWidget {
  final int index;
  AnimatedMenu({Key? key, required this.index}) : super(key: key);

  @override
  _AnimatedMenuState createState() => _AnimatedMenuState();
}

class _AnimatedMenuState extends State<AnimatedMenu>
    with SingleTickerProviderStateMixin {
  double visablePartHeightPercentage = 0.09;
  double afterExpandedHeight = 0.25;

  late AnimationController animationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 500,
      ));

  late Animation<double> heightBaseAnimation =
      Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
          parent: animationController, curve: Curves.easeInOutExpo));

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (animationController.isCompleted) {
            animationController.reverse();
          } else {
            animationController.forward();
          }
        });
      },
      child: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          double containerHeight = heightBaseAnimation
              .drive(Tween<double>(begin: 0.1, end: afterExpandedHeight))
              .value;
          double hiddenMenuHeight = heightBaseAnimation
              .drive(Tween<double>(
                  begin: 0.0,
                  end: (afterExpandedHeight - visablePartHeightPercentage)))
              .value;

          double menuContentOpacity = heightBaseAnimation
              .drive(Tween<double>(begin: 0.0, end: 1.0))
              .value;

          return Container(
            margin: EdgeInsets.symmetric(
              vertical: 5.0,
            ),
            alignment: Alignment.topCenter,
            height: MediaQuery.of(context).size.height * containerHeight,
            child: Card(
              color: Colors.pinkAccent.shade100,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              elevation: 2.5,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height *
                        visablePartHeightPercentage,
                    decoration: BoxDecoration(
                        color: Colors.amberAccent.shade100,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15.0),
                          topRight: Radius.circular(15.0),
                          bottomLeft: Radius.circular(
                              hiddenMenuHeight == 0 ? 15.0 : 0.0),
                          bottomRight: Radius.circular(
                              hiddenMenuHeight == 0 ? 15.0 : 0.0),
                        )),
                    child: Center(
                      child: Text("${widget.index}"),
                    ),
                  ),
                  Flexible(
                      child: Opacity(
                    opacity: menuContentOpacity,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.pinkAccent.shade100,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15.0),
                            bottomRight: Radius.circular(15.0),
                          )),
                      padding: EdgeInsets.symmetric(
                        horizontal: 15.0,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before final copy is available.",
                        style: TextStyle(color: Colors.white),
                      ),
                      height:
                          MediaQuery.of(context).size.height * hiddenMenuHeight,
                    ),
                  ))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
