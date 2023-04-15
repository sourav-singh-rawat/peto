import 'package:flutter/cupertino.dart';
import 'package:peto/utils/app_extensions.dart';

class KPill extends StatelessWidget {
  final Color? backgroundColor;
  final BorderSide? borderSide;
  final Widget child;
  final double? height;
  final EdgeInsets? padding;
  const KPill({
    Key? key,
    this.backgroundColor,
    this.borderSide,
    required this.child,
    this.height,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      constraints: const BoxConstraints(
        minHeight: 20,
      ),
      padding: padding ??
          const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 4,
          ),
      decoration: ShapeDecoration(
        color: backgroundColor ?? KAppX.theme.current.colors.background,
        shape: const StadiumBorder().copyWith(
          side: borderSide,
        ),
      ),
      child: child,
    );
  }
}
