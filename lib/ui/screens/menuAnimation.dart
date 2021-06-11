import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuAnimaiton extends StatefulWidget {
  MenuAnimaiton({Key? key}) : super(key: key);

  @override
  _MenuAnimaitonState createState() => _MenuAnimaitonState();
}

class _MenuAnimaitonState extends State<MenuAnimaiton>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController =
      AnimationController(vsync: this, duration: Duration(milliseconds: 500));

  late Animation<double> scaleAnimaiton = Tween<double>(begin: 1.0, end: 0.8)
      .animate(CurvedAnimation(
          parent: animationController, curve: Curves.easeInOutExpo));

  late Animation<double> menuAnimation = Tween<double>(begin: 0.0, end: 1.0)
      .animate(CurvedAnimation(
          parent: animationController, curve: Curves.easeInOutExpo));

  bool isMenuOpen = false;

  void toggleMenu() {
    setState(() {
      isMenuOpen = !isMenuOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          IconButton(
              onPressed: () {
                if (!animationController.isCompleted) {
                  animationController.forward().then((value) => toggleMenu());
                }
              },
              icon: Icon(CupertinoIcons.settings))
        ],
      ),
      body: Stack(
        children: [
          ScaleTransition(
            scale: scaleAnimaiton,
            child: Column(
              children: [
                SizedBox(
                  height: 50.0,
                ),
                Container(
                  height: 100.0,
                  color: Colors.amber,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  height: 200.0,
                  color: Colors.yellowAccent,
                ),
                SizedBox(
                  height: 20.0,
                ),
                CupertinoButton(
                    child: Text("Sending Request"), onPressed: () {}),
                SizedBox(
                  height: 20.0,
                ),
                CupertinoButton(
                    child: Text("Sending Request"), onPressed: () {}),
                SizedBox(
                  height: 20.0,
                ),
                CupertinoButton(
                    child: Text("Sending Request"),
                    onPressed: () {
                      print("Hello brother");
                    }),
              ],
            ),
          ),
          FadeTransition(
            opacity: menuAnimation,
            child: IgnorePointer(
              ignoring: !isMenuOpen,
              child: Container(
                color: Colors.black12,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              ),
            ),
          ),
          ScaleTransition(
            alignment: Alignment(0.85, -1.15),
            scale: menuAnimation,
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: MediaQuery.of(context).size.height * (0.6),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.white),
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * (0.1),
                  left: MediaQuery.of(context).size.width * (0.1),
                  right: MediaQuery.of(context).size.width * (0.1),
                ),
                child: Column(
                  children: [
                    ListTile(
                      title: Text("Menu 1"),
                    ),
                    ListTile(
                      title: Text("Menu 2"),
                    ),
                    ListTile(
                      title: Text("Menu 3"),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    IconButton(
                        onPressed: () {
                          animationController
                              .reverse()
                              .then((value) => toggleMenu());
                        },
                        icon: Icon(CupertinoIcons.xmark)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
