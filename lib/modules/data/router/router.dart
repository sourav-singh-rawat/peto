import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/routes.dart';
import 'package:flutter/src/widgets/pages.dart';
import 'package:flutter/src/widgets/navigator.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:peto/modules/domain/router/router.dart';

class KRouterBoxImpl extends KRouterBox {
  @override
  Future<void> bootUp() {
    throw UnimplementedError();
  }

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
  Future<T?>? push<T extends Object?>(Widget page) {
    return navigatorKey.currentState?.push(CupertinoPageRoute(builder: (context) {
      return page;
    }));
  }

  @override
  void pop<T extends Object?>([T? result]) {
    navigatorKey.currentState?.pop();
  }
}
