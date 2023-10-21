import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:groceries_app/core/routes/app_router.dart';
import 'package:groceries_app/features/auth/log_in_page.dart';
import 'package:groceries_app/features/provider/riverpod_management.dart';

mixin LogInPageMixin on ConsumerState<LogInPage> {
  final formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  Future<void> formSubmit() async {
    final checkUser = ref.read(userNotifierProvider.notifier);

    if (formKey.currentState!.validate()) {
      formKey.currentState?.save();
      try {
        final user = await checkUser.signWithEmaiAndPassword(email, password);
        if (user.userID != null) {
          context.router.push(BottomRouteBuilder());
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Giriş başarısız, lütfen tekrar deneyin.')));
        }
      } on FirebaseAuthException catch (e) {
        String errorMessage;
        switch (e.code) {
          case 'user-not-found':
            errorMessage = 'Bu email ile bir kullanıcı bulunamadı.';
            break;
          case 'wrong-password':
            errorMessage = 'Yanlış şifre girildi.';
            break;
          default:
            errorMessage = 'Bir hata oluştu, lütfen tekrar deneyin.';
        }
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMessage)));
      } catch (e) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Bir hata oluştu, lütfen tekrar deneyin.')));
      }
    }
  }
}
