import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peto/utils/app_extensions.dart';
import 'package:peto/utils/theme/theme_cubit.dart';

class KScaffold extends StatelessWidget {
  final Widget? body;
  final Color? backgroundColor;
  final Widget? bottomSheet;
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? drawer;
  const KScaffold({
    super.key,
    this.drawer,
    this.backgroundColor,
    this.appBar,
    this.body,
    this.bottomSheet,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KThemeCubit, KThemeState>(
      builder: (context, state) {
        return Scaffold(
          drawer: drawer,
          backgroundColor: backgroundColor ?? KAppX.theme.current.colors.backgroundVariant,
          appBar: appBar,
          body: body,
          bottomSheet: bottomSheet,
          floatingActionButton: floatingActionButton,
          floatingActionButtonLocation: floatingActionButtonLocation,
        );
      },
    );
  }
}
