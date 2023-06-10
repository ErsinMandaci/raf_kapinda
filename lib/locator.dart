import 'package:get_it/get_it.dart';
import 'package:groceries_app/core/services/firestore/firestore_db_service.dart';
import 'package:groceries_app/core/services/product/product_service.dart';
import 'package:groceries_app/features/repository/firestore_repository.dart';
import 'package:groceries_app/features/repository/product_repository.dart';
import 'package:groceries_app/features/repository/user_repository.dart';

import 'core/services/firebase/firebase_auth_service.dart';

GetIt locator = GetIt.instance;

void getItLocator() {
  locator.registerLazySingleton(() => FirebaseAuthService());
  locator.registerLazySingleton(() => FirestoreDBService());
  locator.registerLazySingleton(() => UserRepository());
  locator.registerLazySingleton(() => FirestoreRepository());
  locator.registerLazySingleton(() => ProductService());
  locator.registerLazySingleton(() => ProductRepository());
}
