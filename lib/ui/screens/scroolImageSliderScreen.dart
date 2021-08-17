import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScrollImagesliderScreen extends StatefulWidget {
  final Size screenSize;
  ScrollImagesliderScreen({Key? key, required this.screenSize})
      : super(key: key);

  @override
  _ScrollImagesliderScreenState createState() =>
      _ScrollImagesliderScreenState();

  static Route<ScrollImagesliderScreen> route(RouteSettings routeSettings) {
    return CupertinoPageRoute(
        builder: (_) => ScrollImagesliderScreen(
            screenSize: routeSettings.arguments as Size));
  }
}

class _ScrollImagesliderScreenState extends State<ScrollImagesliderScreen> {
  late ScrollController scrollController =
      ScrollController(initialScrollOffset: widget.screenSize.width * 1.5);

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * (1.5),
              height: MediaQuery.of(context).size.height,
              child: Image.asset(
                "assets/lion.jpg",
                fit: BoxFit.fitHeight,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * (1.5),
              height: MediaQuery.of(context).size.height,
              child: Image.asset(
                "assets/tiger.jpg",
                fit: BoxFit.fitHeight,
              ),
            ),
          ],
        ),
      ),
      /*
      body: PageView(
        children: [
          PageViewChildContainer(
            image: "assets/lion.jpg",
            index: 1,
          ),
          PageViewChildContainer(
            image: "assets/tiger.jpg",
            index: 2,
          ),
          
        ],
      ),
      */
    );
  }
}

class PageViewChildContainer extends StatefulWidget {
  final String image;
  final int index;
  PageViewChildContainer({Key? key, required this.image, required this.index})
      : super(key: key);

  @override
  _PageViewChildContainerState createState() => _PageViewChildContainerState();
}

class _PageViewChildContainerState extends State<PageViewChildContainer> {
  late ScrollController scrollController = ScrollController()
    ..addListener(scrollListener);

  void scrollListener() {
    if (scrollController.offset == scrollController.position.maxScrollExtent) {
      setState(() {
        igonring = true;
      });
    } else {
      setState(() {
        igonring = false;
      });
    }
  }

  late bool igonring = false;

  @override
  void dispose() {
    scrollController.removeListener(scrollListener);
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: igonring,
      child: SingleChildScrollView(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        child: Container(
          width: MediaQuery.of(context).size.width * (2.0),
          height: MediaQuery.of(context).size.height,
          child: Image.asset(
            widget.image,
            fit: BoxFit.fitHeight,
          ),
        ),
      ),
    );
  }
}
