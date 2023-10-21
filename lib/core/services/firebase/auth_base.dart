import 'package:groceries_app/model/user_model.dart';

abstract class AuthBase {
  Future<UserModel?> currentUser();
  Future<void> signOut();
  Future<UserModel> signWithEmaiAndPassword(String email, String password);
  Future<UserModel?> createUserWithEmailAndPassword(
    final String email,
    final String password,
    final String userName,
  );
}
