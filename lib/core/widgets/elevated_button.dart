import 'package:flutter/material.dart';
import 'package:groceries_app/core/constants/color.dart';
import 'package:kartal/kartal.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    required this.text,
    required this.onPressed,
    super.key,
  });
  final String text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.dynamicWidth(0.8),
      height: context.dynamicHeight(0.07),
      child: ElevatedButton(
        onPressed: () => onPressed,
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
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
