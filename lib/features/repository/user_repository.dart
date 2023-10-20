import 'package:groceries_app/core/services/firebase/auth_base.dart';
import 'package:groceries_app/core/services/firebase/firebase_auth_service.dart';
import 'package:groceries_app/core/services/firestore/firestore_service.dart';
import 'package:groceries_app/locator_manager.dart';
import 'package:groceries_app/model/user_model.dart';

final class UserRepository implements AuthBase {
  final FirebaseAuthService _firebaseAuth = LocatorManager.firebaseAuth;
  final FirestoreService _firestoreDB = LocatorManager.firestoreService;
  @override
  Future<UserModel?> createUserWithEmailAndPassword(
    String email,
    String password,
    String userName,
  ) async {
    final user = await _firebaseAuth.createUserWithEmailAndPassword(
      email,
      password,
      userName,
    );
    
    final response = await _firestoreDB.addUser(user ?? UserModel());

    if (response) {
      return _firestoreDB.readUser(user?.userID ?? '');
    } else {
      return null;
    }
  }

  @override
  Future<UserModel> currentUser() async {
    final user = await _firebaseAuth.currentUser();
    if (user.userID != null) {
      return _firestoreDB.readUser(user.userID ?? '');
    } else {
      return UserModel();
    }
  }

  @override
  Future<UserModel> signWithEmaiAndPassword(
    String email,
    String password,
  ) async {
    final user = await _firebaseAuth.signWithEmaiAndPassword(email, password);

    return _firestoreDB.readUser(user.userID ?? '');
  }


  @override
  Future<void> signOut() {
    throw UnimplementedError();
  }
}
