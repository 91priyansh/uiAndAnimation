import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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
      /*
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('fa', 'IR'),
      ],
      locale: Locale('fa', 'IR'),
      */
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.home,
      onGenerateRoute: Routes.onGenerateRoute,
    );
  }
}
