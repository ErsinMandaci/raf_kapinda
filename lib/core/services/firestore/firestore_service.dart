import 'package:groceries_app/features/repository/firestore_repository.dart';
import 'package:groceries_app/locator.dart';

import '../../../model/orders.dart';
import '../../../model/products.dart';
import '../../../model/user_model.dart';


class FirestoreService {
  final FirestoreRepository _firestoreRepository =
      locator<FirestoreRepository>();

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
