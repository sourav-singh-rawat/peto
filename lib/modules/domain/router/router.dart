import 'package:flutter/material.dart';
import 'package:peto/modules/data/router/router.dart';
import 'package:peto/modules/domain/modules.dart';

abstract class KRouterBox extends KModules<void> {
  static KRouterBox instance = KRouterBoxImpl();

  GlobalKey<NavigatorState> get navigatorKey;

  NavigatorState? get router;

  RouteObserver<PageRoute> get routeObserver;

  Future<T?>? push<T extends Object?>(Widget page, {bool fullScreenDialog = false});

  void pop<T extends Object?>([T? result]);

  Future<T?>? pushReplacement<T extends Object?, TO extends Object?>(Widget page, {bool fullScreenDialog = false});
}
