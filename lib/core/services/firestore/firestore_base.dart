

import '../../../model/orders.dart';
import '../../../model/products.dart';
import '../../../model/user_model.dart';

abstract class DBBase {
  Future<bool> addUser(UserModel user);
  Future<UserModel> readUser(String userID);
  Future<void> pushBasketDataToFirestore(List<Products> basketProducts);
  Future<List<Orders>> getOrders();
}
