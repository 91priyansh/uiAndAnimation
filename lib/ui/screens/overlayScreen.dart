import 'package:flutter/material.dart';
import 'package:ui_animations/utils/error.dart';

class OverLayScreen extends StatelessWidget {
  OverLayScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Overlay Screen"),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
            child: ListTile(
              title: Text("$index"),
            ),
          );
        },
        itemCount: 10,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showErrorMessage(context, "Wooo hooo mission successful!!");
        },
        child: Icon(Icons.alarm_add),
      ),
    );
  }
}
