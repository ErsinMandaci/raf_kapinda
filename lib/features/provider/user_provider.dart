import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:groceries_app/core/services/firebase/firebase_auth_service.dart';
import 'package:groceries_app/features/repository/user_repository.dart';
import 'package:groceries_app/locator.dart';
import 'package:groceries_app/models/user_model.dart';
import '../../core/services/firebase/auth_base.dart';

enum ViewState { idle, busy }

class UserNotifier extends ChangeNotifier implements AuthBase {
  final UserRepository _userRepository = locator<UserRepository>();
  final FirebaseAuthService _firebaseService = locator<FirebaseAuthService>();
  // final List<UserModel> _userList = [];

  UserModel? _user;

  UserModel? get user => _user;

  ViewState _state = ViewState.idle;
  ViewState get state => _state;

  setViewState(ViewState value) {
    _state = value;
    notifyListeners();
  }





  @override
  Future<UserModel?> createUserWithEmailAndPassword(
      String email, String password, String userName) async {
    try {
      setViewState(ViewState.busy);
      _user = await _userRepository.createUserWithEmailAndPassword(
          email, password, userName);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw ('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw ('The account already exists for that email.');
      }
    } finally {
      setViewState(ViewState.idle);
    }
    return null;
  }

  @override
  Future<UserModel?> currentUser() async {
    try {
      _state = ViewState.busy;
      _user = await _userRepository.currentUser();

      if (_user != null) {
        return _user;
      } else {
        return null;
      }
    } catch (e) {
      throw ('currentUser $e');
    } finally {
      _state = ViewState.idle;
    }
  }

  @override
  Future<UserModel> signWithEmaiAndPassword(
      String email, String password) async {
    try {
      setViewState(ViewState.busy);
      _user = await _userRepository.signWithEmaiAndPassword(email, password);

      return _user ?? UserModel();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw ('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw ('Wrong password provided for that user.');
      }
    } finally {
      setViewState(ViewState.idle);
    }
    throw ('signWithEmaiAndPassword');
  }

  @override
  Future<void> signOut() {
    try {
      setViewState(ViewState.busy);
      return _firebaseService.signOut();
    } catch (e) {
      throw ('signOut $e');
    } finally {
      setViewState(ViewState.idle);
    }
  }
}
