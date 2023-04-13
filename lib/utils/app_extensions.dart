import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peto/modules/domain/storage/storage.dart';
import 'package:peto/utils/profile/profile_cubit.dart';
import 'package:peto/utils/theme/theme_cubit.dart';

typedef BC = BuildContext;

class KAppX {
  KAppX._();

  static BuildContext? currentContext = KNavigationService.navigatorKey.currentContext;

  static Widget? currentWidget = KNavigationService.navigatorKey.currentWidget;

  static NavigatorState? router = KNavigationService.navigatorKey.currentState;

  static KStorage storage = KStorage();

  static KProfileCubit profile = BlocProvider.of<KProfileCubit>(currentContext!);

  static KThemeCubit theme = BlocProvider.of<KThemeCubit>(currentContext!);
}

class KNavigationService {
  KNavigationService._();

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
