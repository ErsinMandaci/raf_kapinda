import 'package:groceries_app/features/repository/firestore_repository.dart';
import 'package:groceries_app/locator_manager.dart';

import 'package:groceries_app/model/orders.dart';
import 'package:groceries_app/model/products.dart';
import 'package:groceries_app/model/user_model.dart';

class FirestoreService {
  final FirestoreRepository _firestoreRepository =
      LocatorManager.firestoreRepository;

  Future<bool> addUser(UserModel user) {
    if (user.userID == null) {
      return Future.value(false);
    }
    return _firestoreRepository.addUser(user);
  }

  Future<List<Orders>> getOrders() async {
    final ordersCollection = _firestoreRepository.getOrders();

    return ordersCollection;
  }

  Future<void> pushBasketDataToFirestore(List<Products> basketProducts) {
    return _firestoreRepository.pushBasketDataToFirestore(basketProducts);
  }

  Future<UserModel> readUser(String userID) {
    if (userID.isEmpty) {
      return Future.value(UserModel());
    } else {
      return _firestoreRepository.readUser(userID);
    }
  }
}
