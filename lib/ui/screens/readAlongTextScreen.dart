import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

String text =
    "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before final copy is available.";

class ReadAlongTextScreen extends StatefulWidget {
  ReadAlongTextScreen({Key? key}) : super(key: key);

  @override
  _ReadAlongTextScreenState createState() => _ReadAlongTextScreenState();
}

class _ReadAlongTextScreenState extends State<ReadAlongTextScreen> {
  late TextSpan textSpan = TextSpan(text: text);

  void getLineMatrix() {
    final textPainter =
        TextPainter(text: textSpan, textDirection: TextDirection.ltr);
    textPainter.layout(maxWidth: MediaQuery.of(context).size.width);
    textPainter.computeLineMetrics().forEach((element) {
      print(element.lineNumber);
    });
  }

  late String html = '''<!DOCTYPE html>
<html lang="en">
<body>
 <h1>This is a Heading</h1>
 <p>This is a paragraph.</p>
 <p>This is another paragraph.</p>
</body>
</html>
''';

  late WebViewController webViewController;

  Future<String> getHTML() async {
    await Future.delayed(Duration(seconds: 5));
    return html;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      floatingActionButton: FloatingActionButton(onPressed: () {
        showModalBottomSheet(
            isDismissible: false,
            isScrollControlled: true,
            elevation: 5.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0),
              topRight: Radius.circular(15.0),
            )),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            context: context,
            builder: (context) {
              return Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * (0.05),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text("Name"),
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    TextField(
                      decoration: InputDecoration(hintText: "Enter your name"),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * (0.05),
                    ),
                  ],
                ),
              );
            });
      }),
      appBar: AppBar(
        title: Text("Read Along Text"),
      ),
      /*
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return WebView(
            initialUrl: Uri.dataFromString(snapshot.data.toString(),
                    mimeType: 'text/html',
                    encoding: Encoding.getByName('utf-8'))
                .toString(),
            onWebViewCreated: (controller) {
              webViewController = controller;
            },
          );
        },
        future: getHTML(),
      )
      ,
      */
    );
  }
}

/*
Center(
          child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              image: AssetImage(
                "assets/02.png",
              ),
              fit: BoxFit.contain),
        ),
        width: MediaQuery.of(context).size.width * (0.4),
        height: MediaQuery.of(context).size.width * (0.4),
      )),

 */

class LoadingIndicatorContainer extends StatefulWidget {
  LoadingIndicatorContainer({Key? key}) : super(key: key);

  @override
  _LoadingIndicatorContainerState createState() =>
      _LoadingIndicatorContainerState();
}

class _LoadingIndicatorContainerState extends State<LoadingIndicatorContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController =
      AnimationController(vsync: this, duration: Duration(seconds: 1))
        ..addStatusListener(animationStatusListener)
        ..forward();

  late Animation<double> animation = Tween<double>(begin: 0.0, end: 360.0)
      .animate(CurvedAnimation(
          parent: animationController, curve: Curves.easeInOut));

  void animationStatusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      Future.delayed(Duration(milliseconds: 250), () {
        if (mounted) {
          animationController.forward(from: 0.0);
        }
      });
    }
  }

  @override
  void dispose() {
    animationController.removeStatusListener(animationStatusListener);
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all()),
      child: Image.asset("assets/agnes.png"),
    );
  }
}

class CustomTextPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final textStyle = TextStyle(
      color: Colors.black,
      fontSize: 30,
    );
    final textSpan = TextSpan(
      text: text,
      style: textStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: size.width,
    );
    final xCenter = (size.width - textPainter.width);
    final yCenter = (size.height - textPainter.height / 2);
    final offset = Offset(0, 0);
    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    throw true;
  }
}
