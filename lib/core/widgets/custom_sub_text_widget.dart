import 'package:flutter/material.dart';
import 'package:groceries_app/core/constants/color.dart';
import 'package:kartal/kartal.dart';

class CustomSubTextWidget extends StatelessWidget {
  const CustomSubTextWidget({
    required this.text,
    super.key,
    this.color,
    this.fontWeight,
    this.fontSize,
  });
  final double? fontSize;
  final String text;
  final Color? color;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize ?? context.textTheme.titleMedium?.fontSize,
        color: color ?? ColorConst.subTextColor,
        fontWeight: fontWeight ?? FontWeight.normal,
      ),
    );
  }
}
