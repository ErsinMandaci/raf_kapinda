import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:groceries_app/core/constants/color.dart';
import 'package:groceries_app/core/widgets/bottom_page_builder.dart';
import 'package:groceries_app/features/auth/log_in_page.dart';
import 'package:groceries_app/features/provider/riverpod_management.dart';

@RoutePage()
final class LandingPage extends ConsumerWidget {
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
              color: ColorConst.primaryColor,
            );
          } else {
            if (snapshot.hasData) {
              return const BottomPageBuilder();
            }
            return LogInPage();
          }
        },
      ),
    );
  }
}
