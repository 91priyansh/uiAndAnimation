import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:morphable_shape/morphable_shape.dart';

class NeumorphismScreen extends StatefulWidget {
  NeumorphismScreen({Key? key}) : super(key: key);

  @override
  _NeumorphismScreenState createState() => _NeumorphismScreenState();
}

class _NeumorphismScreenState extends State<NeumorphismScreen> {
  Color primaryColor = Color(0xffF76744);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color(0xff212426),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 25.0,
            ),
            Center(
              child: Container(
                height: 100.0,
                width: 100.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Theme.of(context).scaffoldBackgroundColor,
                    /*
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.grey.shade100, Colors.grey.shade50]),
                    */
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black45,
                          blurRadius: 5.0,
                          offset: Offset(2.50, 2.50)),
                      BoxShadow(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.45),
                          blurRadius: 5.0,
                          offset: Offset(-2.5, -2.5)),
                    ]),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            DecoratedShadowedShape(
              shape: RectangleShapeBorder(
                  borderRadius: DynamicBorderRadius.all(
                      DynamicRadius.circular(100.0.toPXLength))),
              insetShadows: [
                ShapeShadow(
                    color: Theme.of(context).primaryColor.withOpacity(0.20),
                    blurRadius: 10.0,
                    offset: Offset(-10, -10)),
                ShapeShadow(
                    color: Colors.black.withOpacity(0.20),
                    blurRadius: 10.0,
                    offset: Offset(10, 10)),
              ],
              shadows: [],
              child: Container(
                padding: EdgeInsets.all(30.0),
                child: Container(
                  child: Center(
                    child: Text(
                      "Lemon\nChusle",
                      style: TextStyle(
                          color: Theme.of(context).scaffoldBackgroundColor),
                    ),
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Theme.of(context).primaryColor,
                          Colors.black45
                        ]),
                    shape: BoxShape.circle,
                  ),
                ),
                height: 200.0,
                width: 200.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
