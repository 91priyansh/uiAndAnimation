import 'package:flutter/material.dart';
import 'package:ui_animations/utils/convertNumber.dart';

class ContactAnimationScreen extends StatefulWidget {
  ContactAnimationScreen({Key? key}) : super(key: key);

  @override
  _ContactAnimationScreenState createState() => _ContactAnimationScreenState();
}

class _ContactAnimationScreenState extends State<ContactAnimationScreen>
    with TickerProviderStateMixin {
  late final ScrollController scrollController = ScrollController()
    ..addListener(scrollAnimation);

  late AnimationController animationController =
      AnimationController(vsync: this);

  late Animation<double> fadeAnimation = Tween<double>(begin: 1.0, end: 0.0)
      .animate(CurvedAnimation(
          parent: animationController, curve: Curves.easeInOut));

  void scrollAnimation() {
    double minValue = scrollController.position.maxScrollExtent * (0.025);
    double maxValue = scrollController.position.maxScrollExtent * (0.4) - 25;
    if (scrollController.offset >= minValue &&
        scrollController.offset <= maxValue) {
      double newValue = ConvertNumber.inRange(
          currentValue: scrollController.offset,
          minValue: minValue,
          maxValue: maxValue,
          newMaxValue: 1.0,
          newMinValue: 0.0);

      animationController.value = newValue;
    } else if (scrollController.offset >= maxValue) {
      if (animationController.value != 1.0) {
        animationController.value = 1.0;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          controller: scrollController,
          headerSliverBuilder: (context, isScrolled) {
            return [
              SliverToBoxAdapter(
                child: Container(
                  color: Colors.grey.shade50,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * (0.3),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FadeTransition(
                        opacity: fadeAnimation,
                        child: Text(
                          "Phone",
                          style: Theme.of(context).textTheme.headline3,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverPersistentHeader(
                delegate: MenuHeaderDelegate(fadeAnimation),
                pinned: true,
              )
            ];
          },
          body: Container(
            color: Colors.grey.shade50,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                color: Colors.white,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Container(
                      height: 100,
                      child: Card(
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        child: Center(child: Text("$index")),
                      ),
                    );
                  },
                  itemCount: 20,
                ),
              ),
            ),
          )),
    );
  }
}

class MenuHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Animation fadeAnimation;
  MenuHeaderDelegate(this.fadeAnimation);
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      alignment: Alignment.center,
      color: Colors.grey.shade50,
      height: 150.0,
      child: Row(
        children: [
          AnimatedBuilder(
            animation: fadeAnimation,
            builder: (context, child) {
              return Opacity(
                opacity: 1.0 - fadeAnimation.value,
                child: child!,
              );
            },
            child: Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: Text(
                "Phone",
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
          ),
          Spacer(),
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: Icon(Icons.add)),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 150.0;

  @override
  double get minExtent => 125.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
