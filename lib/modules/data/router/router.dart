import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:peto/modules/domain/router/router.dart';

part 'observer.dart';

class KRouterBoxImpl extends KRouterBox {
  @override
  Future<void> bootUp() async {}

  @override
  void bootDown() {}

  @override
  void onBootUp() {}

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  final RouteObserver<PageRoute> _routeObserver = RouteObserver<PageRoute>();

  @override
  NavigatorObserver get observer => _KNavigatorObserver();

  @override
  NavigatorState? get router => _navigatorKey.currentState;

  @override
  Future<T?>? push<T extends Object?>({
    required String path,
    required Widget page,
    bool fullScreenDialog = false,
    Object? arguments,
  }) {
    return navigatorKey.currentState?.push(
      CupertinoPageRoute(
        builder: (context) {
          return page;
        },
        fullscreenDialog: fullScreenDialog,
        settings: RouteSettings(
          arguments: arguments,
          name: path,
        ),
      ),
    );
  }

  @override
  void pop<T extends Object?>([T? result]) {
    navigatorKey.currentState?.pop();
  }

  @override
  Future<T?>? pushReplacement<T extends Object?, TO extends Object?>({
    required String path,
    required Widget page,
    bool fullScreenDialog = false,
    Object? arguments,
  }) {
    return navigatorKey.currentState?.pushReplacement(
      CupertinoPageRoute(
        builder: (context) {
          return page;
        },
        fullscreenDialog: fullScreenDialog,
        settings: RouteSettings(
          arguments: arguments,
          name: path,
        ),
      ),
    );
  }
}
