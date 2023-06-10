import 'package:flutter/material.dart';
import 'package:groceries_app/core/constants/color.dart';
import 'package:groceries_app/core/enums/image_enums.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConst.primaryColor,
      appBar: AppBar(elevation: 0),
      body: Center(
        child: Image.asset(ImageEnum.splash.toPng),
      ),
    );
  }
}
