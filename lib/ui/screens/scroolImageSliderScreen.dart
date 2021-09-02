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

class _ScrollImagesliderScreenState extends State<ScrollImagesliderScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController =
      AnimationController(vsync: this, duration: Duration(seconds: 25));

  late ScrollController scrollController =
      ScrollController(initialScrollOffset: widget.screenSize.width * 1.5);
  late String text =
      "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before final copy is available";
  late TextSpan textSpan = TextSpan(
      text: text,
      style: TextStyle(
        fontSize: 18,
        color: Colors.redAccent,
        height: 1.05,
      ));

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    animationController.forward();
    super.initState();
  }

  Widget _buildOptionText() {
    TextPainter textPainter = TextPainter(
      text: textSpan,
      maxLines: 3,
      textDirection: Directionality.of(context),
    );
    textPainter.layout(
      maxWidth: MediaQuery.of(context).size.width * (0.8),
    );

    print(textPainter.didExceedMaxLines);

    return Container(
      width: MediaQuery.of(context).size.width * (0.8),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                print(animationController.value);
                animationController.forward(from: animationController.value);
              },
              icon: Icon(Icons.star))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          animationController.stop();
        },
      ),
      body: _buildOptionText(),
      /*
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
      */

      /*body: PageView(
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
