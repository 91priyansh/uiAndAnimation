import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class GridViewsScreen extends StatefulWidget {
  GridViewsScreen({Key? key}) : super(key: key);

  @override
  _GridViewsScreenState createState() => _GridViewsScreenState();
}

class _GridViewsScreenState extends State<GridViewsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController = TabController(length: 3, vsync: this);

  Widget _buildStaggredGridView() {
    //
    return StaggeredGridView.countBuilder(
        itemCount: 20,
        crossAxisCount: 2,
        mainAxisSpacing: 5.0,
        crossAxisSpacing: 5.0,
        itemBuilder: (context, index) => Container(
              alignment: Alignment.center,
              child: Text("$index"),
              height: Random.secure().nextDouble() * 100 + 100.0,
              color: index.isEven ? Colors.greenAccent : Colors.redAccent,
            ),
        staggeredTileBuilder: (index) {
          //it will allow child to take it's own height rather than fixing height of every child

          //crossAxisCellCount means how many bloc child should allow to take in horizontal way
          //try to keep your crossAxiscount % crossAxisCellCount = 0
          //until you have some complex ui to build
          return StaggeredTile.fit(1); //crossAxisCellCount
        });
  }

  Widget _buildSimpleGridView() {
    return StaggeredGridView.countBuilder(
        itemCount: 20,
        crossAxisCount: 2,
        mainAxisSpacing: 5.0,
        crossAxisSpacing: 5.0,
        itemBuilder: (context, index) => Container(
              alignment: Alignment.center,
              child: Text("$index"),
              color: index.isEven ? Colors.greenAccent : Colors.redAccent,
            ),
        staggeredTileBuilder: (index) {
          //crossAxis count is the amount of bloc in horizontal way grid child allow to take
          //mainAxis count is the number of bloc in vertical way grid child allow to take

          //try to keep your crossAxiscount % crossAxisCellCount = 0
          //until you have some complex ui to build
          return StaggeredTile.count(
              1, 1); //(crossAxisCellCount,mainAxisCellCount)
        });
  }

  Widget _buildExtentGridView() {
    //where you can define width and height of grid child
    //it this type of grid view you have more control over size of the child
    return StaggeredGridView.extentBuilder(
        maxCrossAxisExtent: MediaQuery.of(context).size.width * (0.35),
        itemCount: 20,
        crossAxisSpacing: 5.0,
        mainAxisSpacing: 5.0,
        itemBuilder: (context, index) {
          return Container(
            color: Colors.deepOrangeAccent,
          );
        },
        //to have fixed height and width use StaggredTile.extent
        staggeredTileBuilder: (context) => StaggeredTile.extent(1, 150));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Grid view"),
        bottom: TabBar(
          tabs: [
            Tab(
              text: "Simple",
            ),
            Tab(
              text: "Staggered",
            ),
            Tab(
              text: "Fixed Height",
            ),
          ],
          controller: _tabController,
        ),
      ),
      body: TabBarView(
        children: [
          _buildSimpleGridView(),
          _buildStaggredGridView(),
          _buildExtentGridView()
        ],
        controller: _tabController,
      ),
    );
  }
}
