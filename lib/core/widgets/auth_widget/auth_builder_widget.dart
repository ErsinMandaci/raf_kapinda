// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../../core/services/firebase/firebase_auth_service.dart';
// import '../../models/user_model.dart';
// import 'log_in.dart';

// class AuthBuilder extends StatefulWidget {
//   const AuthBuilder({super.key, required this.builder});

//   final Widget Function(BuildContext, AsyncSnapshot<UserModel?> snapshot)
//       builder;
//   @override
//   State<AuthBuilder> createState() => _AuthBuilderState();
// }

// class _AuthBuilderState extends State<AuthBuilder> {
//   @override
//   Widget build(BuildContext context) {
//     final authService = Provider.of<FirebaseAuthService>(context, listen: false);

//     return StreamBuilder(
//       stream: authService.currentUser(),
//       builder: (context, AsyncSnapshot<UserModel?> snapshot) {
//         final userData = snapshot.data;
//         if (userData != null) {
//           return MultiProvider(providers: [
//             Provider.value(value: userData),
//           ],
//           child: widget.builder(context, snapshot),
//           );
          
//         } else {
//           return LogIn();
//         }
//       },
//     );
//   }
// }
