import 'package:flutter/material.dart';

class ErrorOverlay extends StatefulWidget {
  final String errorMessage;
  ErrorOverlay({Key? key, required this.errorMessage}) : super(key: key);

  @override
  _ErrorOverlayState createState() => _ErrorOverlayState();
}

class _ErrorOverlayState extends State<ErrorOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController =
      AnimationController(vsync: this, duration: Duration(milliseconds: 500))
        ..forward();

  late Animation<double> slideAnimation = Tween<double>(begin: -0.5, end: 1.0)
      .animate(CurvedAnimation(
          parent: animationController, curve: Curves.easeInOutCirc));

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 2000), () {
      animationController.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: slideAnimation,
      builder: (context, child) {
        return Positioned(
          child: Opacity(
            opacity: slideAnimation.value < 0.0 ? 0.0 : slideAnimation.value,
            child: Material(
              type: MaterialType.transparency,
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * (0.8),
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                child: Text(
                  widget.errorMessage,
                  style: TextStyle(color: Colors.white),
                ),
                decoration: BoxDecoration(
                    color: Colors.black45,
                    borderRadius: BorderRadius.circular(25.0)),
              ),
            ),
          ),
          left: MediaQuery.of(context).size.width * (0.1),
          bottom: MediaQuery.of(context).size.height *
              (0.1) *
              (slideAnimation.value),
        );
      },
    );
  }
}
