import 'package:flutter/material.dart';
import 'package:groceries_app/core/constants/color.dart';
import 'package:kartal/kartal.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final Function(String?)? onSaved;
  final TextInputType? keyboardType;
  final bool? obscureText;
  const CustomTextFormField(
      {super.key,
      required this.labelText,
      required this.hintText,
      required this.onSaved,
      this.keyboardType,
      this.obscureText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText ?? false,
      onSaved: onSaved,
      style: TextStyle(
        height: 2,
        letterSpacing: 1,
        fontSize: context.textTheme.titleMedium?.fontSize,
        color: const Color(0xFF181725),
      ),
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          color: ColorConst.subTextColor,
          fontSize: 16,
        ),
        labelText: labelText,
        hintText: hintText,
      ),
    );
  }
}
