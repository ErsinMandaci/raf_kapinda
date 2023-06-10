import 'package:firebase_auth/firebase_auth.dart';
import 'package:groceries_app/core/services/firebase/auth_base.dart';
import 'package:groceries_app/models/user_model.dart';

class FirebaseAuthService implements AuthBase {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  UserModel _userFromFirebase(User? user) {
    return UserModel(
        email: user?.email, userID: user?.uid, userName: user?.displayName);
  }

  // @override
  // Stream<UserModel?> authStateChange() {
  //   return _firebaseAuth.authStateChanges().map((user) => _userFromFirebase(user));

  // }

  @override
  Future<UserModel?> createUserWithEmailAndPassword(
      String email, String password, String userName) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return _userFromFirebase(userCredential.user);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<UserModel> signWithEmaiAndPassword(
      String email, String password) async {
    UserCredential userCredential = await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);
    return _userFromFirebase(userCredential.user);
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<UserModel> currentUser() async {
    try {
      User? user = _firebaseAuth.currentUser;
      return _userFromFirebase(user);
    } catch (e) {
      throw ('currentUser $e');
    }
  }
}
