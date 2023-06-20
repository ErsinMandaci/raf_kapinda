import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:groceries_app/core/constants/color.dart';
import 'package:groceries_app/core/widgets/custom_sub_text_widget.dart';
import 'package:groceries_app/core/widgets/custom_form_text.dart';
import 'package:groceries_app/core/widgets/custom_text_widget.dart';
import 'package:groceries_app/core/widgets/elevated_button.dart';
import 'package:kartal/kartal.dart';

import '../provider/user_provider.dart';

final _userProvider = ChangeNotifierProvider<UserNotifier>((ref) {
  return UserNotifier();
});

class LogInPage extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();
  LogInPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String? email;
    String? password;

    final watch = ref.read(_userProvider);

    formSubmit() async {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState?.save();
        await watch.signWithEmaiAndPassword(email ?? '', password ?? '').then(
              (value) => Navigator.pushNamed(context, 'bottomPageBuilder'),
            );
      }
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: context.onlyTopPaddingHigh.top),
                  child: Image.asset(
                    'assets/images/ModaKafeLogo.png',
                    width: context.dynamicWidth(0.5),
                    height: context.dynamicHeight(0.2),
                  ),
                ),
              ),
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
                          color: null, text: 'Enter your emails and password'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            CustomTextFormField(
                              onSaved: (value) {
                                email = value;
                              },
                              labelText: 'Email',
                              hintText: 'Enter your emails',
                              keyboardType: TextInputType.emailAddress,
                            ),
                            CustomTextFormField(
                              obscureText: true,
                              onSaved: (value) {
                                password = value;
                              },
                              labelText: 'Password',
                              hintText: 'Enter your password',
                              keyboardType: null,
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
                          }),
                    ),
                    SizedBox(height: context.dynamicHeight(0.02)),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          text: 'Don’t have an account? ',
                          style: const TextStyle(color: Colors.black),
                          children: <TextSpan>[
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushNamed(context, 'signUp');
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
                    ),
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
