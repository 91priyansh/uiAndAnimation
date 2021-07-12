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
    "ContactAnimation",
    "Neumorphism",
    "SelectProfileAnimation",
    "MenuAnimation",
    "Curves",
    "InkEffect",
    "SubCategoryAndLevelAnimation",
    "Transform",
    "ImageSlider",
    "ImmersiveAnimation",
    "PageViewSideMenu",
    "ChessAnimation",
    "ImageSequenceAnimation",
    "TextSlideAnimation",
    "LoadingShapeAnimation",
    "AnimatedExpandableMenu"
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
              } else if (examples[index] == "Neumorphism") {
                Navigator.of(context).pushNamed(Routes.neumorphism);
              } else if (examples[index] == "SelectProfileAnimation") {
                Navigator.of(context).pushNamed(Routes.selectProfileAnimation);
              } else if (examples[index] == "MenuAnimation") {
                Navigator.of(context).pushNamed(Routes.menuAnimation);
              } else if (examples[index] == "Curves") {
                Navigator.of(context).pushNamed(Routes.curves);
              } //
              else if (examples[index] == "InkEffect") {
                Navigator.of(context).pushNamed(Routes.inkEffect);
              } else if (examples[index] == "SubCategoryAndLevelAnimation") {
                Navigator.of(context)
                    .pushNamed(Routes.subCategoryAndLevelAnimation);
              } else if (examples[index] == "Transform") {
                Navigator.of(context).pushNamed(Routes.transform);
              } else if (examples[index] == "ImageSlider") {
                Navigator.of(context).pushNamed(Routes.imageSlider);
              } else if (examples[index] == "ImmersiveAnimation") {
                Navigator.of(context).pushNamed(Routes.immersiveAnimation);
              } else if (examples[index] == "PageViewSideMenu") {
                Navigator.of(context).pushNamed(Routes.pageViewSideMenu);
              } else if (examples[index] == "ChessAnimation") {
                Navigator.of(context).pushNamed(Routes.chessAnimation);
              } else if (examples[index] == "ImageSequenceAnimation") {
                Navigator.of(context).pushNamed(Routes.imageSequenceAnimation);
              } else if (examples[index] == "TextSlideAnimation") {
                Navigator.of(context).pushNamed(Routes.textSlideAnimation);
              } else if (examples[index] == "LoadingShapeAnimation") {
                Navigator.of(context).pushNamed(Routes.loadingShapeAnimation);
              } else if (examples[index] == "AnimatedExpandableMenu") {
                Navigator.of(context).pushNamed(Routes.animatedExpandableMenu);
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
