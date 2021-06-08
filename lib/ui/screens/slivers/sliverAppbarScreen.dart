import 'package:flutter/material.dart';

class SliverAppBarScreen extends StatefulWidget {
  SliverAppBarScreen({Key? key}) : super(key: key);

  @override
  _SliverAppBarScreenState createState() => _SliverAppBarScreenState();
}

class _SliverAppBarScreenState extends State<SliverAppBarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            //floating: true, //will float when use scholl down app bar will shown
            //snap: true, //will perform animation
            flexibleSpace: FlexibleSpaceBar(
              title: Text("Agnes"),
              centerTitle: true,
              background: Image.asset(
                "assets/agnes.png",
                fit: BoxFit.cover,
              ),
            ),
            expandedHeight: MediaQuery.of(context).size.height * (0.2),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
            return Card(
              child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(vertical: 5.0),
                  height: 100,
                  child: Text("card $index")),
            );
          }, childCount: 10)),
          SliverPersistentHeader(
            delegate: ContainerHeaderDelegate(),
            pinned: true,
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
            return Card(
              child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(vertical: 5.0),
                  height: 100,
                  child: Text("card ${index * 10}")),
            );
          }, childCount: 10)),
        ],
      ),
    );
  }
}

class ContainerHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.redAccent,
      alignment: Alignment.center,
      child: Text(
        "Monday",
        style: TextStyle(color: Colors.white),
      ),
      height: 200,
    );
  }

  @override
  double get maxExtent => 200;

  @override
  double get minExtent => 100;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
