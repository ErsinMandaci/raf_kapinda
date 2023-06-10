import 'package:groceries_app/models/user_model.dart';

abstract class AuthBase {


  Future<UserModel?> currentUser();
  Future<void> signOut();
  Future<UserModel> signWithEmaiAndPassword(String email, String password);
  Future<UserModel?> createUserWithEmailAndPassword(String email, String password,String userName);
}