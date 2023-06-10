import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../constants/color.dart';

class CustomSubTextWidget extends StatelessWidget {
  final double? fontSize;
  final String text;
  final Color? color;
  final FontWeight? fontWeight;
  const CustomSubTextWidget(
      {super.key, required this.text, this.color, this.fontWeight,this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize:fontSize ?? context.textTheme.titleMedium?.fontSize,
        color: color ?? ColorConst.subTextColor,
        fontWeight: fontWeight ?? FontWeight.normal,
      ),
    );
  }
}
