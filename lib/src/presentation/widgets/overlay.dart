import 'package:flutter/material.dart';

class LoadingOverlay {
  static final OverlayEntry _overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: 0,
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        color: Colors.black54,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    ),
  );

  static void show(BuildContext context) {
    Overlay.of(context).insert(_overlayEntry);
  }

  static void hide() {
    _overlayEntry.remove();
  }
}


