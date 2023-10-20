import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:groceries_app/core/constants/color.dart';
import 'package:groceries_app/core/constants/string.dart';
import 'package:groceries_app/core/enums/image_enums.dart';
import 'package:groceries_app/core/routes/app_router.dart';
import 'package:groceries_app/core/widgets/elevated_button.dart';
import 'package:kartal/kartal.dart';

@RoutePage()
final class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            ImageEnum.onboarding.toPng,
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Positioned(
            top: context.mediaQuery.size.height * 0.62,
            left: context.mediaQuery.size.width * 0.1,
            right: context.mediaQuery.size.width * 0.1,
            child: Text(
              StringConst.welcomeText,
              textAlign: TextAlign.center,
              style: GoogleFonts.questrial(
                fontSize: context.textTheme.displaySmall?.fontSize,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            top: context.mediaQuery.size.height * 0.73,
            left: context.mediaQuery.size.width * 0.2,
            right: context.mediaQuery.size.width * 0.1,
            child: const Text(
              StringConst.welcomeSubText,
              style: TextStyle(color: ColorConst.subTextColor, fontSize: 14),
            ),
          ),
          Positioned(
            top: 750,
            left: context.mediaQuery.size.width * 0.15,
            right: context.mediaQuery.size.width * 0.15,
            child: SizedBox(
              width: context.dynamicWidth(0.7),
              height: context.dynamicHeight(0.06),
              child: CustomElevatedButton(
                onPressed: () => context.router.push(SignInRoute()),
                text: 'Get Started',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
