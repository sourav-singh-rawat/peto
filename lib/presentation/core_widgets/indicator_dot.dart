import 'package:flutter/material.dart';

class KIndicatorDot extends StatelessWidget {
  final bool isActive;
  final double? width;
  final double? height;
  final Color? activeColor;
  const KIndicatorDot({
    Key? key,
    this.isActive = false,
    this.width,
    this.height,
    this.activeColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _activeColor = activeColor ?? Colors.white;

    return Container(
      width: width ?? 12,
      height: height ?? 12,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: _activeColor,
        ),
        color: isActive ? _activeColor : Colors.transparent,
      ),
    );
  }
}
