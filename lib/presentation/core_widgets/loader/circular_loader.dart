import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:peto/utils/app_extensions.dart';

class KCircularLoader extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? color;
  const KCircularLoader({
    super.key,
    this.color,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: CircularProgressIndicator(
        color: color ?? KAppX.theme.current.colors.primary,
      ),
    );
  }
}
