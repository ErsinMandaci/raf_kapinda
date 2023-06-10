import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../constants/color.dart';

class CustomTextWidget extends StatelessWidget {
  final double? fontsize;
  final FontWeight? fontWeight;
  final String text;
  const CustomTextWidget({super.key, required this.text, this.fontsize,this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
      
        fontSize: fontsize ?? context.textTheme.headlineMedium?.fontSize,
        fontWeight:fontWeight ?? FontWeight.w600,
        color: ColorConst.textColor,
      ),
    );
  }
}
