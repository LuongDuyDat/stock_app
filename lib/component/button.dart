import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({
    Key? key,
    this.height,
    this.width,
    required this.color,
    this.padding,
    required this.child,
    this.onPressed,
  }) : super(key: key);

  final double? height;
  final double? width;
  final Color color;
  final EdgeInsets? padding;
  final Widget child;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      height: height,
      minWidth: width,
      color: color,
      padding: padding,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: child,
    );
  }

}