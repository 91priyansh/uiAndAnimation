import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class CustomPainterScreen extends StatefulWidget {
  CustomPainterScreen({Key? key}) : super(key: key);

  @override
  _CustomPainterScreenState createState() => _CustomPainterScreenState();
}

class _CustomPainterScreenState extends State<CustomPainterScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController =
      AnimationController(vsync: this, duration: Duration(seconds: 1))
        ..forward();
  late Animation<double> animation = Tween<double>(begin: 0.0, end: 180.0)
      .animate(CurvedAnimation(
          parent: animationController, curve: Curves.easeInOut));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text("Custom Painter"),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.greenAccent,
            height: 150,
            width: 150,
            child: CustomPaint(
              painter: LineCustomPainter(),
            ),
          ),
          Container(
            color: Colors.redAccent,
            height: 150,
            width: 150,
            child: CustomPaint(
              painter: RectCustomPainter(),
            ),
          ),
          Stack(
            children: [
              Container(
                color: Colors.lightBlueAccent,
                height: 150,
                width: 150,
                child: CustomPaint(
                  painter: CircleCustomPainter(),
                ),
              ),
              Container(
                height: 150,
                width: 150,
                child: AnimatedBuilder(
                  builder: (context, child) {
                    return CustomPaint(
                      willChange: false,
                      painter: ArcCustomPainter(sweepAngle: animation.value),
                    );
                  },
                  animation: animation,
                ),
              )
            ],
          ),
          Container(
            color: Colors.redAccent,
            height: 150,
            width: 150,
            child: CustomPaint(
              painter: TriangleCustomPainter(),
            ),
          ),
        ],
      ),
    );
  }
}

class TriangleCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Color color = Colors.greenAccent;

    Paint paint = Paint()
      ..strokeWidth = 5.0
      ..color = color
      ..style = PaintingStyle.stroke;

    Path path = Path();
    path.moveTo(size.width * (0.5), size.height * (0.25));

    //to draw triangle
    path.lineTo(size.width * (0.85), size.height * (0.75));
    path.arcToPoint(Offset(size.width * (0.15), size.height * (0.75)),
        radius: Radius.circular(75));
    //path.lineTo(size.width * (0.15), size.height * (0.75));
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    //generally it return false but when parent widget is changing
    //or animating it should return true
    return false;
  }
}

class ArcCustomPainter extends CustomPainter {
  final double sweepAngle;

  ArcCustomPainter({required this.sweepAngle});

  double _degreeToRadian() {
    return (sweepAngle * pi) / 180.0;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Color color = Colors.greenAccent;

    Paint paint = Paint()
      ..strokeWidth = 11
      ..color = color
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawArc(
        Rect.fromCircle(
            center: Offset(size.width * (0.5), size.height * (0.5)),
            radius: size.width * (0.25)),
        3 * (pi / 2),
        _degreeToRadian(),
        false,
        paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    //generally it return false but when parent widget is changing
    //or animating it should return true
    return true;
  }
}

class CircleCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width * (0.5), size.height * (0.5));
    Paint paint = Paint()
      ..strokeWidth = 10.0
      ..color = Colors.yellowAccent
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, size.width * 0.25, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    //generally it return false but when parent widget is changing
    //or animating it should return true
    return false;
  }
}

class RectCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 10.0
      ..style = PaintingStyle.stroke;

    //point a is topLeft of rect and b is bottomRight of rect
    final Offset a = Offset(size.width * (0.1), size.height * (0.1));
    final Offset b = Offset(size.width * (0.9), size.height * (0.9));
    //rect from points
    Rect rect = Rect.fromPoints(
      a,
      b,
    );

    //rect from given center point
    rect = Rect.fromCenter(
        center: Offset(size.width * (0.5), size.height * (0.5)),
        width: size.width * (0.75),
        height: size.height * (0.5));

    //drawing rounded rect
    final roundedRect = RRect.fromRectAndRadius(rect, Radius.circular(10.0));
    canvas.drawRRect(roundedRect, paint);
    //for drawing normal rect
    //canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    //generally it return false but when parent widget is changing
    //or animating it should return true
    return false;
  }
}

class LineCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 5.0
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(size.width * (0.2), size.height * (0.5)),
        Offset(size.width * (0.6), size.height * (0.5)), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    //generally it return false but when parent widget is changing
    //or animating it should return true
    return false;
  }
}
