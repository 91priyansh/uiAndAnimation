import 'package:flutter/material.dart';

String text =
    "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before final copy is available.";

class ReadAlongTextScreen extends StatefulWidget {
  ReadAlongTextScreen({Key? key}) : super(key: key);

  @override
  _ReadAlongTextScreenState createState() => _ReadAlongTextScreenState();
}

class _ReadAlongTextScreenState extends State<ReadAlongTextScreen> {
  late TextSpan textSpan = TextSpan(text: text);

  void getLineMatrix() {
    final textPainter =
        TextPainter(text: textSpan, textDirection: TextDirection.ltr);
    textPainter.layout(maxWidth: MediaQuery.of(context).size.width);
    textPainter.computeLineMetrics().forEach((element) {
      print(element.lineNumber);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: () {
          getLineMatrix();
        }),
        appBar: AppBar(
          title: Text("Read Along Text"),
        ),
        body: CustomPaint(
          size: Size(MediaQuery.of(context).size.width, 0.0),
          painter: CustomTextPainter(),
        ));
  }
}

class CustomTextPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final textStyle = TextStyle(
      color: Colors.black,
      fontSize: 30,
    );
    final textSpan = TextSpan(
      text: text,
      style: textStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: size.width,
    );
    final xCenter = (size.width - textPainter.width);
    final yCenter = (size.height - textPainter.height / 2);
    final offset = Offset(0, 0);
    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    throw true;
  }
}
