import 'package:groceries_app/core/services/firebase/auth_base.dart';
import 'package:groceries_app/core/services/firebase/firebase_auth_service.dart';
import 'package:groceries_app/locator.dart';

import '../../core/services/firestore/firestore_service.dart';
import '../../model/user_model.dart';

class UserRepository implements AuthBase {
  final FirebaseAuthService _firebaseAuth = locator<FirebaseAuthService>();
  final FirestoreService _firestoreDB = locator<FirestoreService>();

  @override
  Future<UserModel?> createUserWithEmailAndPassword(
      String email, String password, String userName) async {
    UserModel? user = await _firebaseAuth.createUserWithEmailAndPassword(
        email, password, userName);
    user?.userName = userName;
    bool response = await _firestoreDB.addUser(user ?? UserModel());

    if (response) {
      return await _firestoreDB.readUser(user?.userID ?? '');
    } else {
      return null;
    }
     
  }

  @override
  Future<UserModel> currentUser() async {
    UserModel user = await _firebaseAuth.currentUser();
    if (user.userID != null) {
      return await _firestoreDB.readUser(user.userID ?? '');
    } else {
      return UserModel();
    }
  }

  
  @override
  Future<UserModel> signWithEmaiAndPassword(
      String email, String password) async {
    UserModel user =
        await _firebaseAuth.signWithEmaiAndPassword(email, password);

    return await _firestoreDB.readUser(user.userID ?? '');
  }

  // @override
  // Stream<UserModel?> authStateChange() {
  //   Stream<UserModel?> user = _firebaseAuth.authStateChange();

  //   return user;
  // }

  @override
  Future<void> signOut() {
    throw UnimplementedError();
  }
}
