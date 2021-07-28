import 'package:flutter/material.dart';

class MapImageAnimationScreen extends StatefulWidget {
  MapImageAnimationScreen({Key? key}) : super(key: key);

  @override
  _MapImageAnimationScreenState createState() =>
      _MapImageAnimationScreenState();
}

class _MapImageAnimationScreenState extends State<MapImageAnimationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(
        "assets/map_finding.png",
        fit: BoxFit.cover,
      ),
    );
  }
}
