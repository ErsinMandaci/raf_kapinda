import 'package:flutter/material.dart';
import 'package:groceries_app/core/constants/color.dart';
import 'package:kartal/kartal.dart';

final class CustomTextWidget extends StatelessWidget {
  const CustomTextWidget({
    required this.text,
    super.key,
    this.fontsize,
    this.fontWeight,
  });
  final double? fontsize;
  final FontWeight? fontWeight;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontsize ?? context.textTheme.headlineMedium?.fontSize,
        fontWeight: fontWeight ?? FontWeight.w600,
        color: ColorConst.textColor,
      ),
    );
  }
}
