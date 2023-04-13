import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peto/modules/domain/router/router.dart';
import 'package:peto/modules/domain/storage/storage.dart';
import 'package:peto/utils/profile/profile_cubit.dart';
import 'package:peto/utils/theme/theme_cubit.dart';

typedef BC = BuildContext;

class KAppX {
  KAppX._();

  static BuildContext? currentContext = KRouterBox.instance.navigatorKey.currentContext;

  static Widget? currentWidget = KRouterBox.instance.navigatorKey.currentWidget;

  static KRouterBox router = KRouterBox.instance;

  static KStorage storage = KStorage();

  static KProfileCubit profile = BlocProvider.of<KProfileCubit>(currentContext!);

  static KThemeCubit theme = BlocProvider.of<KThemeCubit>(currentContext!);
}
