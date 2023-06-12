import 'package:groceries_app/models/products.dart';
import 'package:groceries_app/models/user_model.dart';

abstract class DBBase {
  Future<bool> addUser(UserModel user);
  Future<UserModel> readUser(String userID);
  Future<void> pushBasketDataToFirestore(List<Products> basketProducts);
  Future<List<Products>> getOrders();
}
