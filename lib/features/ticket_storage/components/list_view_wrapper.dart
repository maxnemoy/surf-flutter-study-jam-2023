import 'package:flutter/material.dart';

class ScrollWrapper extends StatelessWidget {
  final Widget child;
  final VoidCallback? onEndPosition;
  final VoidCallback? onStarPosition;
  const ScrollWrapper({
    super.key,
    required this.child,
    this.onEndPosition,
    this.onStarPosition,
  });

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollUpdateNotification>(
        onNotification: (ScrollUpdateNotification notification) {
          if (notification.metrics.pixels > 0 && notification.metrics.atEdge) {
            onEndPosition?.call();
          }
          if (notification.metrics.pixels == 0 && notification.metrics.atEdge) {
            onStarPosition?.call();
          }

          return true;
        },
        child: child);
  }
}
