import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({
    Key? key,
    required this.height,
    required this.color,
    required this.padding,
    required this.text,
  }) : super(key: key);

  final double height;
  final Color color;
  final EdgeInsets padding;
  final Text text;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: (){},
      height: height,
      color: color,
      padding: padding,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: text,
    );
  }

}