import 'package:flutter/material.dart';

class CurvesScreen extends StatelessWidget {
  const CurvesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomPaint(
          painter: ShapePainter(),
          size: Size(300, 300),
        ),
      ),
    );
  }
}

class ShapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.blueAccent
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(0, size.height * (0.15));
    path.quadraticBezierTo(size.width * (0.25), 0, size.width * (0.5), 0);
    path.quadraticBezierTo(size.width * (0.7), size.height * 0.65, size.width,
        size.height * (0.25));
    //path.lineTo(size.width * (0.5), size.height * 0);
    //path.lineTo(size.width, size.height * (0.25));
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
