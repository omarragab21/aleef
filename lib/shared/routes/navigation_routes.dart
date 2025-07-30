import 'package:flutter/material.dart';

class NavigationService {
  static final NavigationService _instance = NavigationService._internal();

  factory NavigationService() {
    return _instance;
  }

  NavigationService._internal();

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  /// Pushes a new widget onto the navigation stack.
  Future<T?> pushWidget<T extends Object?>(Widget widget) {
    return navigatorKey.currentState?.push(
          MaterialPageRoute(builder: (context) => widget),
        ) ??
        Future.value(null);
  }

  /// Replaces the current widget with a new one.
  Future<T?> pushReplacementWidget<T extends Object?, TO extends Object?>(
    Widget widget, {
    TO? result,
  }) {
    return navigatorKey.currentState?.pushReplacement(
          MaterialPageRoute(builder: (context) => widget),
          result: result,
        ) ??
        Future.value(null);
  }

  /// Pops the top-most route off the navigation stack.
  void pop<T extends Object?>([T? result]) {
    navigatorKey.currentState?.pop(result);
  }

  /// Pops all routes until the first one, then pushes the new widget.
  Future<T?> pushAndRemoveUntilWidget<T extends Object?>(Widget widget) {
    return navigatorKey.currentState?.pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => widget),
          (route) => false,
        ) ??
        Future.value(null);
  }
}
