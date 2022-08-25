import 'package:flutter/material.dart';

class CustomPageRoute extends PageRouteBuilder {
  CustomPageRoute({required this.child})
      : super(
            transitionDuration: Duration(milliseconds: 400),
            pageBuilder: (context, animation, secondaryAnimation) => child);
  final Widget child;
  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return AnimatedOpacity(
      duration: Duration(seconds: 1),
      opacity: animation.value,
      child: ScaleTransition(
        // alignment: Alignment.bottomLeft,
        scale: animation,
        child: child,
      ),
    );
  }
}
