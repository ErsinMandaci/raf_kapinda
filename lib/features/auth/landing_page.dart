import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:groceries_app/core/constants/color.dart';

import '../home/home_page.dart';
import '../provider/riverpod_management.dart';
import 'log_in_page.dart';

class LandingPage extends ConsumerWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authUser = ref.watch(firebaseInstance).authStateChanges();

    return Scaffold(
      body: StreamBuilder(
        stream: authUser,
        builder: (context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(
                color: ColorConst.primaryColor);
          } else {
            if (snapshot.hasData) {
              return const HomePage();
            }
            return LogInPage();
          }
        },
      ),
    );
  }
}
