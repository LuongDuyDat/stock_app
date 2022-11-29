import 'package:flutter/material.dart';

class Navigate {
  static Future pushPage(BuildContext context, Widget page,
      {bool dialog = false}) async {
    return await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return page;
        },
        fullscreenDialog: dialog,
      ),
    );
  }

  static pushPageReplacement(BuildContext context, Widget page) async {
    return await Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return page;
        },
      ),
    );
  }

  static pushPageWithFadeAnimation(BuildContext context, Widget page) async {
    return await Navigator.pushReplacement(context, FadePageRoute(page));
  }

  static popPage(BuildContext context) async {
    return Navigator.pop(context);
  }

  static popPageResult(BuildContext context, String result) async {
    return Navigator.pop(context, result);
  }
}

class FadePageRoute<T> extends PageRoute<T> {
  FadePageRoute(this.child);

  @override
  Color get barrierColor => Colors.white10;

  @override
  String? get barrierLabel => null;

  final Widget child;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 500);
}
