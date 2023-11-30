import 'package:flutter/material.dart';

class MyIcon extends StatelessWidget {
  final Color? color;
  final double? size;
  final IconData icon;

  const MyIcon({
    Key? key,
    this.color = Colors.black87,
    this.size,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: size,
      color: color,
    );
  }
}
