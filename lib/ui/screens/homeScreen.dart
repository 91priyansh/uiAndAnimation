import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_animations/app/routes.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> examples = [
    "Slivers",
    "Clipper",
    "CustomPainter",
    "GridViews",
    "Overlay",
    "ScrollAnimation",
    "HideShowAppBar",
    "NumberAnimation",
    "ContactAnimation"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              if (examples[index] == "Slivers") {
                Navigator.of(context).pushNamed(Routes.slivers);
              } else if (examples[index] == "Clipper") {
                Navigator.of(context).pushNamed(Routes.clipper);
              } else if (examples[index] == "CustomPainter") {
                Navigator.of(context).pushNamed(Routes.customPainter);
              } else if (examples[index] == "GridViews") {
                Navigator.of(context).pushNamed(Routes.gridViews);
              } else if (examples[index] == "Overlay") {
                Navigator.of(context).pushNamed(Routes.overlay);
              } else if (examples[index] == "ScrollAnimation") {
                Navigator.of(context).pushNamed(Routes.scrollAnimation);
              } else if (examples[index] == "HideShowAppBar") {
                Navigator.of(context).pushNamed(Routes.hideShowAppBar);
              } else if (examples[index] == "NumberAnimation") {
                Navigator.of(context).pushNamed(Routes.numberAnimation);
              } else if (examples[index] == "ContactAnimation") {
                Navigator.of(context).pushNamed(Routes.contactAnimation);
              }
            },
            title: Text(examples[index]),
          );
        },
        itemCount: examples.length,
      ),
    );
  }
}
