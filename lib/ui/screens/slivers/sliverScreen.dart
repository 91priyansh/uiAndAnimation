import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SliverScreen extends StatelessWidget {
  SliverScreen({Key? key}) : super(key: key);

  final List<String> sliverExample = ["SliverAppBar"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sliver"),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          String title = sliverExample[index];
          return ListTile(
            onTap: () {
              Navigator.of(context).pushNamed("/${title.toLowerCase()}");
            },
            title: Text(title),
          );
        },
        itemCount: sliverExample.length,
      ),
    );
  }
}
