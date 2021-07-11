import 'package:flutter/material.dart';

class ImageSliderScreen extends StatefulWidget {
  ImageSliderScreen({Key? key}) : super(key: key);

  @override
  _ImageSliderScreenState createState() => _ImageSliderScreenState();
}

class _ImageSliderScreenState extends State<ImageSliderScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController =
      AnimationController(vsync: this, duration: Duration(milliseconds: 750));
  late Animation<double> clipPathAnimation = Tween<double>(begin: 0.4, end: 1.0)
      .animate(CurvedAnimation(
          parent: animationController, curve: Curves.easeInOut));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: 0,
            top: 100,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * (0.5),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/01.jpg"), fit: BoxFit.cover)),
            ),
          ),
          Positioned(
            left: 0,
            top: 100,
            child: AnimatedBuilder(
              animation: clipPathAnimation,
              builder: (context, child) {
                return ClipPath(
                  child: child,
                  clipper: ImageClipper(clipPathAnimation.value),
                );
              },
              child: Opacity(
                opacity: 0.8,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.amberAccent,
                    image: DecorationImage(
                        image: AssetImage("assets/02.jpg"), fit: BoxFit.cover),
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * (0.5),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: IconButton(
              onPressed: () {
                if (animationController.isCompleted) {
                  animationController.reverse();
                } else {
                  animationController.forward();
                }
              },
              icon: Icon(Icons.ac_unit),
            ),
          ),
        ],
      ),
    );
  }
}

class ImageClipper extends CustomClipper<Path> {
  final double widthPercentage;

  ImageClipper(this.widthPercentage);
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width * widthPercentage, 0);
    path.lineTo(size.width * widthPercentage, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
