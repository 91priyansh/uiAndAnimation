import 'package:flutter/material.dart';

class RtlLayoutScreen extends StatelessWidget {
  const RtlLayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("RTL Layout"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        //mainAxisSize: MainAxisSize.min,
        child: Text(
          "Credit goes to modiji",
          //stextDirection: TextDirection.rtl,
        ),
      ),
    );
  }
}
