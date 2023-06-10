import 'package:flutter/material.dart';
import 'package:groceries_app/core/constants/string.dart';
import 'package:groceries_app/core/widgets/custom_text_widget.dart';
import '../../core/enums/image_enums.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(ImageEnum.signInTop.toPng),
          const CustomTextWidget(text: StringConst.signInText),
        ],
      ),
    );
  }
}
