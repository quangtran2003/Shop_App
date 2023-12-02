// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class MyContainer extends StatelessWidget {
  double? height;
  double? width;
  double? boder;
  Color? color;
  String? image;
  Widget? child;
  MyContainer({
    Key? key,
    this.image,
    this.height,
    this.child,
    this.width,
    this.boder,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          image: image != null
              ? DecorationImage(image: AssetImage(image!), fit: BoxFit.cover)
              : null,
          color: color,
          borderRadius: BorderRadius.circular(boder ?? 0)),
      child: child,
    );
  }
}
