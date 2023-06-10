import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:groceries_app/features/provider/firestore_provider.dart';
import 'package:groceries_app/features/provider/product_provider.dart';
import 'package:groceries_app/features/provider/user_provider.dart';

final firebaseInstance = Provider((ref) => FirebaseAuth.instance);

final userProvider = ChangeNotifierProvider<UserNotifier>((ref) {
  return UserNotifier();
});


final productProvider = ChangeNotifierProvider<ProductNotifier>((ref) {
  return ProductNotifier();
});


final  firestoreProvider = ChangeNotifierProvider<FirestoreNotifer>((ref) {
  return FirestoreNotifer();
});