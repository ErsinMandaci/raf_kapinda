import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:groceries_app/core/routes/app_router.dart';
import 'package:groceries_app/features/auth/sign_up_page.dart';
import 'package:groceries_app/features/provider/riverpod_management.dart';
import 'package:groceries_app/model/user_model.dart';

mixin SignUpPageMixin on ConsumerState<SignUpPage> {
  final formKey = GlobalKey<FormState>();

  late final String? email;
  late final String? password;
  late final String? userName;

  Future<void> formSubmit({required WidgetRef ref}) async {
    final watchUserProvider = ref.watch(userNotifierProvider.notifier);

    if (formKey.currentState!.validate()) {
      formKey.currentState?.save();
      UserModel(userName: userName);
      try {
        await watchUserProvider
            .createUserWithEmailAndPassword(
              email ?? '',
              password ?? '',
              userName ?? '',
            )
            .then((value) => context.router.push(LogInRoute()));
      } catch (e) {
        throw Exception('createUserWithEmailAndPassword $e signUp');
      }
    }
  }
}
