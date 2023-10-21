import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:groceries_app/core/constants/color.dart';
import 'package:groceries_app/core/routes/app_router.dart';
import 'package:groceries_app/core/widgets/custom_form_text.dart';
import 'package:groceries_app/core/widgets/custom_sub_text_widget.dart';
import 'package:groceries_app/core/widgets/custom_text_widget.dart';
import 'package:groceries_app/core/widgets/elevated_button.dart';
import 'package:groceries_app/features/auth/mixin/log_in_mixin.dart';
import 'package:kartal/kartal.dart';

@RoutePage()
final class LogInPage extends ConsumerStatefulWidget {
  const LogInPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LogInPageState();
}

class _LogInPageState extends ConsumerState<LogInPage> with LogInPageMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LogInLogoWidget(),
              const SizedBox(
                height: 70,
              ),
              Padding(
                padding: context.paddingNormal,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomTextWidget(text: 'Login'),
                    const Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: CustomSubTextWidget(
                        text: 'Enter your emails and password',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            CustomTextFormField(
                              validator: (value) {
                                if (value.isNullOrEmpty) return 'Email cannot be empty';
                                return null;
                              },
                              onSaved: (value) {
                                email = value ?? '';
                              },
                              labelText: 'Email',
                              hintText: 'Enter your emails',
                              keyboardType: TextInputType.emailAddress,
                            ),
                            CustomTextFormField(
                              validator: (value) {
                                if (value.isNullOrEmpty) return 'Password cannot be empty';
                                return null;
                              },
                              obscureText: true,
                              onSaved: (value) {
                                password = value ?? '';
                              },
                              labelText: 'Password',
                              hintText: 'Enter your password',
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: context.dynamicHeight(0.07),
                    ),
                    Center(
                      child: CustomElevatedButton(
                        text: 'Log In',
                        onPressed: () {
                          formSubmit();
                        },
                      ),
                    ),
                    SizedBox(height: context.dynamicHeight(0.02)),
                    _SignUpButtonWidget(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SignUpButtonWidget extends StatelessWidget {
  const _SignUpButtonWidget();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          text: 'Don’t have an account? ',
          style: const TextStyle(color: Colors.black),
          children: <TextSpan>[
            TextSpan(
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  context.router.push(SignUpRoute());
                },
              text: 'Sign Up',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: ColorConst.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LogInLogoWidget extends StatelessWidget {
  const LogInLogoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: context.onlyTopPaddingHigh.top),
        child: Image.asset(
          'assets/images/ModaKafeLogo.png',
          width: context.dynamicWidth(0.5),
          height: context.dynamicHeight(0.2),
        ),
      ),
    );
  }
}
