import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:groceries_app/core/widgets/bottom_page_builder.dart';
import 'package:groceries_app/features/auth/log_in_page.dart';

import 'package:groceries_app/features/provider/riverpod_management.dart';

final class AuthChecker extends ConsumerWidget {
  const AuthChecker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(firebaseInstance).currentUser;

    if (currentUser != null) {
      return const BottomPageBuilder();
    } else {
      return LogInPage();
    }
  }
}

