import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peto/utils/app_extensions.dart';
import 'package:peto/utils/theme/theme_cubit.dart';

class KAppBar extends StatelessWidget implements PreferredSizeWidget {
  final PreferredSizeWidget? bottom;
  final Color? backgroundColor;
  final Widget? title;
  final Widget? leading;
  final List<Widget>? actions;
  final bool? centerTitle;
  final VoidCallback? onPopCallback;
  final double? elevation;
  const KAppBar({
    Key? key,
    this.bottom,
    this.backgroundColor,
    this.title,
    this.leading,
    this.actions,
    this.centerTitle,
    this.onPopCallback,
    this.elevation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ModalRoute<dynamic>? parentRoute = ModalRoute.of(context);
    final canPop = parentRoute?.canPop ?? false;
    final useCloseButton = parentRoute is PageRoute<dynamic> && parentRoute.fullscreenDialog;

    return SafeArea(
      child: BlocBuilder<KThemeCubit, KThemeState>(
        builder: (context, state) {
          return AppBar(
            key: ObjectKey(state),
            leading: leading ??
                () {
                  if (!canPop) {
                    return null;
                  }

                  return IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      useCloseButton ? Icons.close : Icons.arrow_back,
                      color: KAppX.theme.current.colors.onBackground,
                      size: 28,
                    ),
                    onPressed: () {
                      onPopCallback?.call();

                      KAppX.router.pop();
                    },
                  );
                }(),
            backgroundColor: backgroundColor ?? KAppX.theme.current.colors.backgroundVariant,
            elevation: elevation ?? 0,
            title: title,
            centerTitle: centerTitle,
            actions: actions,
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              systemNavigationBarColor: Colors.transparent,
            ),
            bottom: bottom ??
                PreferredSize(
                  child: Container(
                    width: double.infinity,
                    color: const Color(0xffDFDFDF),
                  ),
                  preferredSize: const Size.fromHeight(1),
                ),
          );
        },
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight((55) + (bottom?.preferredSize.height ?? 1));
}
