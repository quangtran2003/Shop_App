import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyText extends StatelessWidget {
  String text;
  double? fontSize;
  FontWeight? fontWeight;
  FontStyle? fontStyle;
  Color? color;
  int? maxLine;
  TextDecoration? decoration;
  TextAlign? textAlign;
  MyText(
      {Key? key,
      required this.text,
      this.fontSize,
      this.textAlign = TextAlign.center,
      this.color,
      this.fontStyle,
      this.maxLine,
      this.decoration,
      this.fontWeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLine,
      textAlign: textAlign,
      style: TextStyle(
          decoration: decoration,
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
          fontStyle: fontStyle),
    );
  }
}
