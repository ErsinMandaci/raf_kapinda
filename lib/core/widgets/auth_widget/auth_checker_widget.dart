import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:groceries_app/core/widgets/bottom_page_builder.dart';
import 'package:groceries_app/features/auth/log_in_page.dart';

import 'package:groceries_app/features/provider/riverpod_management.dart';

class AuthChecker extends ConsumerWidget {
  const AuthChecker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final authState = ref.watch(userProvider).authStateChange();
    final currentUser = ref.watch(firebaseInstance).currentUser;

    if (currentUser != null) {
      return const BottomPageBuilder();
    } else {
      return LogInPage();
    }
  }
}



// class ErrorScreen extends StatelessWidget {
//   final Object e;
//   final StackTrace trace;
//   const ErrorScreen({super.key, required this.e, required this.trace});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Text(
//           'Error: $e',
//           style: Theme.of(context).textTheme.titleLarge,
//         ),
//       ),
//     );
//   }
// }
