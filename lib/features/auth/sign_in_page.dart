import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:groceries_app/core/constants/string.dart';
import 'package:groceries_app/core/enums/image_enums.dart';
import 'package:groceries_app/core/widgets/custom_text_widget.dart';


@RoutePage()
final class SignInPage extends StatelessWidget {
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
