import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:peto/utils/app_extensions.dart';

class KScaffold extends StatelessWidget {
  final Widget? body;
  final Color? backgroundColor;
  final Widget? bottomSheet;
  final PreferredSizeWidget? appBar;
  const KScaffold({
    super.key,
    this.backgroundColor,
    this.appBar,
    this.body,
    this.bottomSheet,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? KAppX.theme.current.colors.backgroundVariant,
      appBar: appBar,
      body: body,
      bottomSheet: bottomSheet,
    );
  }
}
