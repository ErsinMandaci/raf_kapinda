import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:groceries_app/core/constants/color.dart';
import 'package:groceries_app/core/enums/image_enums.dart';

@RoutePage()
final class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

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
