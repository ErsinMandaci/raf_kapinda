import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:groceries_app/core/initialize/theme.dart';
import 'package:groceries_app/core/routes/route.dart' as route;
import 'package:groceries_app/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  getItLocator();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: route.controller,
      initialRoute: route.authChecker,
      debugShowCheckedModeBanner: false,
      theme: AppTheme().theme,
    );
   
  }
}
