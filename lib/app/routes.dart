import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_animations/ui/screens/CollidingCirclesAnimationScreen.dart';
import 'package:ui_animations/ui/screens/animatedExpandableMenu.dart';
import 'package:ui_animations/ui/screens/carRentalUx.dart';
import 'package:ui_animations/ui/screens/chessAnimation.dart';
import 'package:ui_animations/ui/screens/clipperScreen.dart';
import 'package:ui_animations/ui/screens/contactAnimationScreen.dart';
import 'package:ui_animations/ui/screens/curvesScreen.dart';
import 'package:ui_animations/ui/screens/customPainerScreen.dart';
import 'package:ui_animations/ui/screens/gridViewsScreen.dart';
import 'package:ui_animations/ui/screens/hideShowAppbar.dart';
import 'package:ui_animations/ui/screens/homeScreen.dart';
import 'package:ui_animations/ui/screens/imageSequenceAnimation.dart';
import 'package:ui_animations/ui/screens/imageSliderScreen.dart';
import 'package:ui_animations/ui/screens/immersiveAnimation.dart';
import 'package:ui_animations/ui/screens/inkEffectScreen.dart';
import 'package:ui_animations/ui/screens/loadingShapeAnimation.dart';
import 'package:ui_animations/ui/screens/mapImageAnimationScreen.dart';
import 'package:ui_animations/ui/screens/menuAnimation.dart';
import 'package:ui_animations/ui/screens/neumorphismScreen.dart';
import 'package:ui_animations/ui/screens/numberAnimation.dart';
import 'package:ui_animations/ui/screens/overlayScreen.dart';
import 'package:ui_animations/ui/screens/pageViewSideMenuScreen.dart';
import 'package:ui_animations/ui/screens/quizPlayAreaScreen.dart';
import 'package:ui_animations/ui/screens/scrollAnimation.dart';
import 'package:ui_animations/ui/screens/selectProfilePictureScreen.dart';
import 'package:ui_animations/ui/screens/selectWordAnimation.dart';
import 'package:ui_animations/ui/screens/slivers/sliverAppbarScreen.dart';
import 'package:ui_animations/ui/screens/slivers/sliverScreen.dart';
import 'package:ui_animations/ui/screens/subcategoryAndLevelAnimation.dart';
import 'package:ui_animations/ui/screens/tapAnimationScreen.dart';
import 'package:ui_animations/ui/screens/textSlideAnimation.dart';
import 'package:ui_animations/ui/screens/transformScreen.dart';

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
  static const String curves = "/curves";
  static const String inkEffect = "/inkEffect";
  static const String subCategoryAndLevelAnimation =
      "/subCategoryAndLevelAnimation";

  static const String transform = "/transform";

  static const String imageSlider = "/imageSlider";

  static const String immersiveAnimation = "/immersiveAnimation";

  static const String pageViewSideMenu = "/pageViewSideMenu";

  static const String chessAnimation = "/chessAnimation";

  static const String imageSequenceAnimation = "/imageSequenceAnimation";

  static const String textSlideAnimation = "/textSlideAnimation";

  static const String loadingShapeAnimation = "/loadingShapeAnimation";

  static const String animatedExpandableMenu = "/animatedExpandableMenu";

  static const String carRentalUx = "/carRentalUx";

  static const String quiaPlayArea = "/quizPlayArea";

  static const String selectWordAnimation = "/selectWordAnimation";

  static const String mapImageAnimation = "/mapImageAnimation";

  static const String tapAnimation = "/tapAnimation";

  static const String collidingCircles = "/collidingCircles";

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
      case curves:
        return CupertinoPageRoute(builder: (_) => CurvesScreen());
      case inkEffect:
        return InkEffectScreen.route(routeSettings);
      case subCategoryAndLevelAnimation:
        return CupertinoPageRoute(
            builder: (context) => SubCategoryAndLevelAnimation());
      case transform:
        return CupertinoPageRoute(builder: (context) => TransformScreen());
      case imageSlider:
        return CupertinoPageRoute(builder: (context) => ImageSliderScreen());

      case immersiveAnimation:
        return CupertinoPageRoute(builder: (context) => ImmersiveAnimation());

      case pageViewSideMenu:
        return CupertinoPageRoute(
            builder: (context) => PageViewSideMenuScreen());

      case chessAnimation:
        return CupertinoPageRoute(builder: (context) => ChessAnimationScreen());

      case imageSequenceAnimation:
        return CupertinoPageRoute(
            builder: (context) => ImageSequenceAnimationScreen());
      case textSlideAnimation:
        return CupertinoPageRoute(builder: (context) => TextSlideAnimation());
      case loadingShapeAnimation:
        return CupertinoPageRoute(
            builder: (context) => LoadingShapeAnimation());
      case animatedExpandableMenu:
        return CupertinoPageRoute(
            builder: (context) => AnimatedExpandableMenu());

      case carRentalUx:
        return CupertinoPageRoute(builder: (context) => CarRental());

      case quiaPlayArea:
        return CupertinoPageRoute(builder: (context) => QuizPlayAreaScreen());

      case selectWordAnimation:
        return CupertinoPageRoute(
            builder: (context) => SelectWordAnimationScreen());

      case mapImageAnimation:
        return CupertinoPageRoute(
            builder: (context) => MapImageAnimationScreen());

      case tapAnimation:
        return CupertinoPageRoute(builder: (context) => TapAnimationScreen());

      case collidingCircles:
        return CupertinoPageRoute(
            builder: (context) => CollidingCirclesAnimationScreen());

      default:
        return CupertinoPageRoute(
            builder: (context) => LoadingShapeAnimation());
    }
  }
}
