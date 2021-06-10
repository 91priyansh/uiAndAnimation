import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      backgroundColor: Color(0xffEAF4FE),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Agnes is lub",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 50.0,
                      shadows: [
                        BoxShadow(
                            blurRadius: 1.0,
                            offset: Offset(0.0, 2.5),
                            color: Color(0xff0061F2).withOpacity(0.15))
                      ]),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xff0061F2).withOpacity(0.15),
                          blurRadius: 10.0)
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25.0)),
                padding: EdgeInsetsDirectional.all(5.0),
                child: Container(
                  padding: EdgeInsets.all(50.0),
                  decoration: BoxDecoration(
                      color: Color(0xffEAF4FE),
                      borderRadius: BorderRadius.circular(25.0)),
                  child: Image.asset("assets/agnes.png"),
                ),
              ),
              SizedBox(
                height: 25.0,
              ),
              /*
              PhysicalModel(
                color: Colors.white,
                elevation: 2.5,
                shadowColor: Color(0xff0061F2).withOpacity(0.5),
                child: Container(
                  height: 100.0,
                  width: 100.0,
                ),
              ),
              */
              Container(
                height: 100.0,
                width: 100.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.grey.shade100, Colors.grey.shade50]),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade300,
                          spreadRadius: 0.0,
                          blurRadius: 5.0,
                          offset: Offset(3.0, 3.0)),
                      BoxShadow(
                          color: Colors.grey.shade400,
                          spreadRadius: 0.0,
                          blurRadius: 5.0 / 2.0,
                          offset: Offset(3.0, 3.0)),
                      BoxShadow(
                          color: Colors.grey.shade100,
                          spreadRadius: 1.0,
                          blurRadius: 5.0,
                          offset: Offset(-3.0, -3.0)),
                      BoxShadow(
                          color: Colors.grey.shade50,
                          spreadRadius: 1.0,
                          blurRadius: 5.0 / 2,
                          offset: Offset(-3.0, -3.0)),
                    ]),
              )
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(CupertinoIcons.airplane, color: primaryColor),
                  Icon(
                    CupertinoIcons.add_circled,
                    color: Colors.blueGrey.shade200,
                  ),
                  Icon(
                    CupertinoIcons.bag,
                    color: Colors.blueGrey.shade200,
                  )
                ],
              ),
              height: 100.0,
              decoration: BoxDecoration(color: Color(0xffEAF4FE), boxShadow: [
                BoxShadow(
                    color: Colors.black12, blurRadius: 7.5, spreadRadius: 1.0)
              ]),
            ),
          )
        ],
      ),
    );
  }
}
