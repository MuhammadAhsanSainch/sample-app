import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class CustomWillPopScope extends StatelessWidget {
  const CustomWillPopScope({Key? key,
    required this.child,
    this.onWillPop = false,
    required this.action
  }) : super(key: key);

  final Widget child;
  final bool onWillPop;
  final VoidCallback action;

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ?
    GestureDetector(
      onPanEnd: (details) {
        if (details.velocity.pixelsPerSecond.dx < 0 ||
            details.velocity.pixelsPerSecond.dx > 0) {
          if (onWillPop) {
            action();
          }
        }
      },
      child: PopScope(
        canPop: false,
        child: child,
      )
    )
    : PopScope(
      canPop: onWillPop,
      onPopInvokedWithResult: (didPop, _) {
        if(didPop) {
          return;
        }
        action();
      },
      child: child,
    );
  }
}
