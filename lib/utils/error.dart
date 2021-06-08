import 'package:flutter/material.dart';
import 'package:ui_animations/ui/widgets/errorOverlay.dart';

Future<void> showErrorMessage(BuildContext context, String errorMessage) async {
  OverlayState? overlayState = Overlay.of(context);
  OverlayEntry overlayEntry = OverlayEntry(
    builder: (context) => ErrorOverlay(
      errorMessage: errorMessage,
    ),
  );

  overlayState?.insert(overlayEntry);

  await Future.delayed(Duration(seconds: 3));
  overlayEntry.remove();
}
