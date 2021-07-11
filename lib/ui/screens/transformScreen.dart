import 'package:flutter/material.dart';
import 'dart:math' as math;

class TransformScreen extends StatefulWidget {
  TransformScreen({Key? key}) : super(key: key);

  @override
  _TransformScreenState createState() => _TransformScreenState();
}

class _TransformScreenState extends State<TransformScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * (0.8),
          height: MediaQuery.of(context).size.height * (0.5),
          decoration: BoxDecoration(border: Border.all()),
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateX(1 * math.pi)
              ..scale(1.0),
            child: Container(
              child: Center(
                  child: Text(
                "Hello",
                style: Theme.of(context).textTheme.headline2,
              )),
              decoration: BoxDecoration(color: Colors.greenAccent.shade200),
            ),
          ),
        ),
      ),
    );
  }
}
