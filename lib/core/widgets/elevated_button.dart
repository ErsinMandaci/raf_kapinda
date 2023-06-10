import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../constants/color.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  const CustomElevatedButton(
      {super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.dynamicWidth(0.8),
      height: context.dynamicHeight(0.07),
      child: ElevatedButton(
        onPressed: () => onPressed(),
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorConst.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
              fontSize: context.textTheme.titleMedium?.fontSize,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
