
import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:groceries_app/core/constants/color.dart';
import 'package:groceries_app/core/enums/image_enums.dart';
import 'package:groceries_app/core/widgets/custom_form_text.dart';
import 'package:groceries_app/core/widgets/custom_sub_text_widget.dart';
import 'package:groceries_app/core/widgets/custom_text_widget.dart';
import 'package:groceries_app/core/widgets/elevated_button.dart';
import 'package:groceries_app/features/auth/mixin/sign_up_mixin.dart';
import 'package:kartal/kartal.dart';

@RoutePage()
class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> with SignUpPageMixin {
  @override
  Widget build(BuildContext context) {
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
                    ImageEnum.havuc.toPng,
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
                    const CustomTextWidget(text: 'SignUp'),
                    const Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: CustomSubTextWidget(
                        text: 'Enter your credentials to continue',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            CustomTextFormField(
                              labelText: 'Username',
                              hintText: 'Enter your username',
                              onSaved: (value) {
                                userName = value;
                              },
                            ),
                            CustomTextFormField(
                              labelText: 'Email',
                              hintText: 'Enter your emails',
                              keyboardType: TextInputType.emailAddress,
                              onSaved: (value) {
                                email = value;
                              },
                            ),
                            CustomTextFormField(
                              obscureText: true,
                              labelText: 'Password',
                              hintText: 'Enter your password',
                              onSaved: (value) {
                                password = value;
                              },
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
                        text: 'Sing Up',
                        onPressed: () {
                          formSubmit(ref: ref);
                        },
                      ),
                    ),
                    SizedBox(height: context.dynamicHeight(0.02)),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          text: 'Already have an account? ',
                          style: const TextStyle(color: Colors.black),
                          children: <TextSpan>[
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.popAndPushNamed(context, 'login');
                                },
                              text: 'Sign In',
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

// @RoutePage()
// class SignUpPage extends ConsumerWidget {
//   SignUpPage({super.key});

//   final _formKey = GlobalKey<FormState>();

//   String? _email;
//   String? _password;
//   String? _userName;

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final watchUserProvider = ref.watch(userProvider);

//     Future<void> formSubmit() async {
//       if (_formKey.currentState!.validate()) {
//         _formKey.currentState?.save();
//         UserModel(userName: _userName);
//         try {
//           await watchUserProvider
//               .createUserWithEmailAndPassword(
//                 _email ?? '',
//                 _password ?? '',
//                 _userName ?? '',
//               )
//               .then((value) => Navigator.pushNamed(context, 'login'));
//         } catch (e) {
//           throw Exception('createUserWithEmailAndPassword $e signUp');
//         }
//       }
//     }

//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           physics: const ScrollPhysics(),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Center(
//                 child: Padding(
//                   padding: EdgeInsets.only(top: context.onlyTopPaddingHigh.top),
//                   child: Image.asset(
//                     ImageEnum.havuc.toPng,
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 70,
//               ),
//               Padding(
//                 padding: context.paddingNormal,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const CustomTextWidget(text: 'SignUp'),
//                     const Padding(
//                       padding: EdgeInsets.only(top: 10),
//                       child: CustomSubTextWidget(
//                         text: 'Enter your credentials to continue',
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 15),
//                       child: Form(
//                         key: _formKey,
//                         child: Column(
//                           children: [
//                             CustomTextFormField(
//                               labelText: 'Username',
//                               hintText: 'Enter your username',
//                               onSaved: (value) {
//                                 _userName = value;
//                               },
//                             ),
//                             CustomTextFormField(
//                               labelText: 'Email',
//                               hintText: 'Enter your emails',
//                               keyboardType: TextInputType.emailAddress,
//                               onSaved: (value) {
//                                 _email = value;
//                               },
//                             ),
//                             CustomTextFormField(
//                               obscureText: true,
//                               labelText: 'Password',
//                               hintText: 'Enter your password',
//                               onSaved: (value) {
//                                 _password = value;
//                               },
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: context.dynamicHeight(0.07),
//                     ),
//                     Center(
//                       child: CustomElevatedButton(
//                         text: 'Sing Up',
//                         onPressed: () {
//                           formSubmit();
//                         },
//                       ),
//                     ),
//                     SizedBox(height: context.dynamicHeight(0.02)),
//                     Center(
//                       child: RichText(
//                         text: TextSpan(
//                           text: 'Already have an account? ',
//                           style: const TextStyle(color: Colors.black),
//                           children: <TextSpan>[
//                             TextSpan(
//                               recognizer: TapGestureRecognizer()
//                                 ..onTap = () {
//                                   Navigator.popAndPushNamed(context, 'login');
//                                 },
//                               text: 'Sign In',
//                               style: const TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 color: ColorConst.primaryColor,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
