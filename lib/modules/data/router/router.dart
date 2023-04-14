import 'package:flutter/cupertino.dart';
import 'package:peto/modules/domain/router/router.dart';

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
  RouteObserver<PageRoute> get routeObserver => _routeObserver;

  @override
  NavigatorState? get router => _navigatorKey.currentState;

  @override
  Future<T?>? push<T extends Object?>(Widget page, {bool fullScreenDialog = false}) {
    return navigatorKey.currentState?.push(
      CupertinoPageRoute(
        builder: (context) {
          return page;
        },
        fullscreenDialog: fullScreenDialog,
      ),
    );
  }

  @override
  void pop<T extends Object?>([T? result]) {
    navigatorKey.currentState?.pop();
  }

  @override
  Future<T?>? pushReplacement<T extends Object?, TO extends Object?>(Widget page, {bool fullScreenDialog = false}) {
    return navigatorKey.currentState?.pushReplacement(
      CupertinoPageRoute(
        builder: (context) {
          return page;
        },
        fullscreenDialog: fullScreenDialog,
      ),
    );
  }
}
