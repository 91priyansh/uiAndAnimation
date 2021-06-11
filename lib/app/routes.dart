import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_animations/ui/screens/clipperScreen.dart';
import 'package:ui_animations/ui/screens/contactAnimationScreen.dart';
import 'package:ui_animations/ui/screens/customPainerScreen.dart';
import 'package:ui_animations/ui/screens/gridViewsScreen.dart';
import 'package:ui_animations/ui/screens/hideShowAppbar.dart';
import 'package:ui_animations/ui/screens/homeScreen.dart';
import 'package:ui_animations/ui/screens/menuAnimation.dart';
import 'package:ui_animations/ui/screens/neumorphismScreen.dart';
import 'package:ui_animations/ui/screens/numberAnimation.dart';
import 'package:ui_animations/ui/screens/overlayScreen.dart';
import 'package:ui_animations/ui/screens/scrollAnimation.dart';
import 'package:ui_animations/ui/screens/selectProfilePictureScreen.dart';
import 'package:ui_animations/ui/screens/slivers/sliverAppbarScreen.dart';
import 'package:ui_animations/ui/screens/slivers/sliverScreen.dart';

class Routes {
  static const String home = "/";
  static const String slivers = "/slivers";
  static const String sliverAppbar = "/sliverappbar";
  static const String scrollAnimation = "/scrollanimation";
  static const String clipper = "/clipper";
  static const String customPainter = "/custompainter";
  static const String gridViews = "/gridViews";
  static const String overlay = "/overlay";
  static const String hideShowAppBar = "/hideshowappbar";

  static const String numberAnimation = "/numberanimation";
  static const String contactAnimation = "/contactanimation";
  static const String neumorphism = "/neumorphismScreen";
  static const String selectProfileAnimation = "/selectProfileAnimation";
  static const String menuAnimation = "/menuAnimation";

  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case home:
        return CupertinoPageRoute(builder: (context) => HomeScreen());
      case slivers:
        return CupertinoPageRoute(builder: (context) => SliverScreen());
      case sliverAppbar:
        return CupertinoPageRoute(builder: (context) => SliverAppBarScreen());
      case clipper:
        return CupertinoPageRoute(builder: (context) => ClipperScreen());
      case customPainter:
        return CupertinoPageRoute(builder: (context) => CustomPainterScreen());
      case gridViews:
        return CupertinoPageRoute(builder: (context) => GridViewsScreen());
      case overlay:
        return CupertinoPageRoute(builder: (context) => OverLayScreen());
      case scrollAnimation:
        return CupertinoPageRoute(builder: (context) => ScrollAnimation());
      case hideShowAppBar:
        return CupertinoPageRoute(builder: (context) => HideShowAppBar());
      case numberAnimation:
        return CupertinoPageRoute(builder: (context) => NumberAnimation());
      case contactAnimation:
        return CupertinoPageRoute(builder: (_) => ContactAnimationScreen());
      case neumorphism:
        return CupertinoPageRoute(builder: (_) => NeumorphismScreen());
      case selectProfileAnimation:
        return CupertinoPageRoute(builder: (_) => SelectProfilePictureScreen());
      case menuAnimation:
        return CupertinoPageRoute(builder: (_) => MenuAnimaiton());

      default:
        return CupertinoPageRoute(builder: (context) => HomeScreen());
    }
  }
}
