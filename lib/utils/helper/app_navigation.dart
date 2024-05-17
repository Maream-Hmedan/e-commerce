import 'package:flutter/material.dart';

class AppNavigator<T> {
  final BuildContext context;
  bool rootNav = false;
  bool isAnimated;

  AppNavigator.of(
      this.context, {
        bool rootNavigator = false,
        this.isAnimated = true,
      }) {
    FocusManager.instance.primaryFocus?.unfocus();
    rootNav = rootNavigator;
  }

  final int _delay = 500;

  Future<T?> push(Widget child) {
    return Navigator.of(context, rootNavigator: rootNav).push(
      isAnimated
          ? PageRouteBuilder(
        pageBuilder: (_, __, ___) => child,
        transitionDuration: Duration(milliseconds: _delay),
        transitionsBuilder: (_, a, __, c) =>
            FadeTransition(opacity: a, child: c),
      )
          : MaterialPageRoute(builder: (_) => child),
    );
  }

  Future<T?> pushReplacement(Widget child) {
    return Navigator.of(context, rootNavigator: rootNav).pushReplacement(
      isAnimated
          ? PageRouteBuilder(
        pageBuilder: (_, __, ___) => child,
        transitionDuration: Duration(milliseconds: _delay),
        transitionsBuilder: (_, a, __, c) =>
            FadeTransition(opacity: a, child: c),
      )
          : MaterialPageRoute(builder: (_) => child),
    );
  }

  Future<T?> pushReplacementNamed(String route) {
    return Navigator.of(context, rootNavigator: rootNav)
        .pushReplacementNamed(route);
  }

  Future<T?> pushAndRemoveUntil(Widget child) {
    return Navigator.of(context, rootNavigator: rootNav).pushAndRemoveUntil(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => child,
        transitionDuration: Duration(milliseconds: _delay),
        transitionsBuilder: (_, a, __, c) =>
            FadeTransition(opacity: a, child: c),
      ),
          (route) => false,
    );
  }

  void pop([result]) {
    Navigator.of(context, rootNavigator: rootNav).pop(result);
  }

  bool canPop() {
    return Navigator.of(context, rootNavigator: rootNav).canPop();
  }

  Future<bool> maybePop([result]) async {
    return await Navigator.of(context, rootNavigator: rootNav).maybePop(result);
  }
}
