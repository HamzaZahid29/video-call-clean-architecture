import 'package:flutter/material.dart';

class LoggingNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    debugPrint(
        'Navigated to: ${route.settings.name ?? route.settings.arguments}');
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    debugPrint(
        'Popped to: ${previousRoute?.settings.name ?? previousRoute?.settings.arguments}');
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    debugPrint(
        'Replaced ${oldRoute?.settings.name} with ${newRoute?.settings.name}');
  }
}