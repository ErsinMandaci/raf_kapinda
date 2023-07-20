// ignore_for_file: cascade_invocations

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:groceries_app/core/services/firebase/firebase_auth_service.dart';
import 'package:groceries_app/core/services/firestore/firestore_service.dart';
import 'package:groceries_app/core/services/product/product_service.dart';
import 'package:groceries_app/features/repository/firestore_repository.dart';
import 'package:groceries_app/features/repository/product_repository.dart';
import 'package:groceries_app/features/repository/user_repository.dart';

@immutable
final class LocatorManager {
  LocatorManager._();
  final GetIt _locator = GetIt.instance;
  static final LocatorManager _instance = LocatorManager._();
  static LocatorManager get instance => _instance;
  void _getItLocator() {
    _locator.registerLazySingleton(FirebaseAuthService.new);
    _locator.registerLazySingleton(FirestoreService.new);
    _locator.registerLazySingleton(UserRepository.new);
    _locator.registerLazySingleton(FirestoreRepository.new);
    _locator.registerLazySingleton(ProductService.new);
    _locator.registerLazySingleton(ProductRepository.new);
  }

  static void locatorSetup() {
    _instance._getItLocator();
  }

  static FirebaseAuthService get firebaseAuth => GetIt.I<FirebaseAuthService>();
  static FirestoreService get firestoreService => GetIt.I<FirestoreService>();
  static UserRepository get userRepository => GetIt.I<UserRepository>();
  static FirestoreRepository get firestoreRepository =>
      GetIt.I<FirestoreRepository>();
  static ProductService get productService => GetIt.I<ProductService>();
  static ProductRepository get productRepository =>
      GetIt.I<ProductRepository>();
}
