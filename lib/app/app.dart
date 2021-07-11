import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_animations/app/routes.dart';

Widget initializeApp() {
  return App();
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage("assets/01.jpg"), context);

    precacheImage(AssetImage("assets/02.jpg"), context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.home,
      onGenerateRoute: Routes.onGenerateRoute,
    );
  }
}
