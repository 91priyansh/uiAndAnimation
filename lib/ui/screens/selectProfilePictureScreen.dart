import 'package:flutter/material.dart';

class SelectProfilePictureScreen extends StatefulWidget {
  SelectProfilePictureScreen({Key? key}) : super(key: key);

  @override
  _SelectProfilePictureScreenState createState() =>
      _SelectProfilePictureScreenState();
}

class _SelectProfilePictureScreenState
    extends State<SelectProfilePictureScreen> {
  List<Color> colors = [
    Colors.white,
    Colors.amberAccent,
    Colors.greenAccent,
    Colors.deepOrangeAccent,
    Colors.indigoAccent,
    Colors.yellowAccent,
    Colors.pinkAccent
  ];

  late ScrollController scrollController = ScrollController();
  late PageController pageController = PageController(viewportFraction: 0.5);

  int currentIndex = 0;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      scrollController.animateTo(
          scrollController.position.maxScrollExtent * (0.75),
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOutQuad);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFEEEA),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 300.0,
            child: PageView.builder(
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
                print(currentIndex);
              },
              physics: BouncingScrollPhysics(),
              controller: pageController,
              itemBuilder: (context, index) {
                return PageViewChild(
                    currentIndex: currentIndex,
                    index: index,
                    color: colors[index]);
              },
              itemCount: colors.length,
            ),
          ),
          SizedBox(
            height: 150.0,
          ),
          SizedBox(
            height: 150.0,
            child: ListView.builder(
                physics: BouncingScrollPhysics(),
                controller: scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: colors.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                        color: colors[index], shape: BoxShape.circle),
                    height: 100.0,
                    width: 100.0,
                    margin: EdgeInsets.symmetric(horizontal: 15.0),
                  );
                }),
          )
        ],
      ),
    );
  }
}

class PageViewChild extends StatefulWidget {
  final int index;
  final int currentIndex;
  final Color color;
  PageViewChild(
      {Key? key,
      required this.currentIndex,
      required this.index,
      required this.color})
      : super(key: key);

  @override
  _PageViewChildState createState() => _PageViewChildState();
}

class _PageViewChildState extends State<PageViewChild>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController =
      AnimationController(vsync: this, duration: Duration(milliseconds: 500));
  late Animation<double> animation = Tween<double>(begin: 0.8, end: 0.0)
      .animate(CurvedAnimation(
          parent: animationController, curve: Curves.easeInOutSine));
  late Animation<double> scaleAnimation = Tween<double>(begin: 0.75, end: 1.0)
      .animate(CurvedAnimation(
          parent: animationController, curve: Curves.easeInOutQuad));
  @override
  void initState() {
    super.initState();
    if (widget.index == widget.currentIndex) {
      animationController.forward();
    }
  }

  @override
  void didUpdateWidget(covariant PageViewChild oldWidget) {
    if (widget.currentIndex == widget.index) {
      animationController.forward();
    } else {
      animationController.reverse();
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (_, child) {
        return Opacity(
          opacity: 1.0 - animation.value,
          child: Transform.scale(
            scale: scaleAnimation.value,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: widget.color,
              ),
            ),
          ),
        );
      },
    );
  }
}
