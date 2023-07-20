import 'package:groceries_app/model/orders.dart';
import 'package:groceries_app/model/products.dart';
import 'package:groceries_app/model/user_model.dart';

abstract class DBBase {
  Future<bool> addUser(UserModel user);
  Future<UserModel> readUser(String userID);
  Future<void> pushBasketDataToFirestore(List<Products> basketProducts);
  Future<List<Orders>> getOrders();
}
