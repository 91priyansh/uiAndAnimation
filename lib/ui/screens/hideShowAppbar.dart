import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HideShowAppBar extends StatefulWidget {
  HideShowAppBar({Key? key}) : super(key: key);

  @override
  _HideShowAppBarState createState() => _HideShowAppBarState();
}

class _HideShowAppBarState extends State<HideShowAppBar>
    with SingleTickerProviderStateMixin {
  late AnimationController hideShowAppBarAnimationController =
      AnimationController(vsync: this, duration: Duration(milliseconds: 250));

  late Animation<Offset> slideAnimation =
      Tween<Offset>(begin: Offset(0.0, 0.0), end: Offset(0.0, -1.0)).animate(
          CurvedAnimation(
              parent: hideShowAppBarAnimationController,
              curve: Curves.easeInOutSine));

  late ScrollController scrollController = ScrollController()
    ..addListener(hideShowAppBar);

  void hideShowAppBar() {
    if (scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      if (hideShowAppBarAnimationController.value != 1.0) {
        hideShowAppBarAnimationController.forward();
      }
    } else {
      hideShowAppBarAnimationController.reverse();
    }
  }

  @override
  void dispose() {
    hideShowAppBarAnimationController.dispose();
    scrollController.removeListener(hideShowAppBar);
    super.dispose();
  }

  Widget _buildAppBar() {
    AppBar appbar = AppBar();
    return SlideTransition(
      position: slideAnimation,
      child: SizedBox(
        height:
            appbar.preferredSize.height + MediaQuery.of(context).padding.top,
        child: appbar,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: ListView.builder(
              padding: EdgeInsets.only(top: kToolbarHeight),
              controller: scrollController,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text("$index"),
                );
              },
              itemCount: 20,
            ),
          ),
          _buildAppBar(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (hideShowAppBarAnimationController.isCompleted) {
            hideShowAppBarAnimationController.reverse();
          } else {
            hideShowAppBarAnimationController.forward();
          }
        },
        child: Icon(Icons.restaurant),
      ),
    );
  }
}
