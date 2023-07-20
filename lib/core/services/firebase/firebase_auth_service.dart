import 'package:firebase_auth/firebase_auth.dart';
import 'package:groceries_app/core/services/firebase/auth_base.dart';

import 'package:groceries_app/model/user_model.dart';

class FirebaseAuthService implements AuthBase {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  UserModel _userFromFirebase(User? user) {
    return UserModel(
      email: user?.email,
      userID: user?.uid,
      userName: user?.displayName,
    );
  }

  @override
  Future<UserModel?> createUserWithEmailAndPassword(
    String email,
    String password,
    String userName,
  ) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return _userFromFirebase(userCredential.user);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<UserModel> signWithEmaiAndPassword(
    String email,
    String password,
  ) async {
    final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return _userFromFirebase(userCredential.user);
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<UserModel> currentUser() async {
    try {
      final user = _firebaseAuth.currentUser;
      return _userFromFirebase(user);
    } catch (e) {
      throw Exception('currentUser $e');
    }
  }
}
