import 'package:flutter/material.dart';

class BeansWidget extends StatelessWidget {
  const BeansWidget({
    Key? key,
    required this.color,
    required this.child,
    required this.padding,
  }) : super(key: key);

  final Color color;
  final Widget child;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(12)),
      child: Padding(padding: padding, child: child),
    );
  }
}
