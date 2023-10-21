import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Riverpod paketini içe aktardık
import 'package:groceries_app/core/services/firebase/auth_base.dart';
import 'package:groceries_app/core/services/firebase/firebase_auth_service.dart';
import 'package:groceries_app/features/repository/user_repository.dart';
import 'package:groceries_app/locator_manager.dart';
import 'package:groceries_app/model/user_model.dart';

enum ViewState { idle, busy }

class UserNotifier extends StateNotifier<UserState> implements AuthBase {
  final UserRepository _userRepository = LocatorManager.userRepository;
  final FirebaseAuthService _firebaseService = LocatorManager.firebaseAuth;

  UserNotifier() : super(UserState(viewState: ViewState.idle));

  UserModel? get user => state.user;
  ViewState get viewState => state.viewState;

  @override
  Future<UserModel?> createUserWithEmailAndPassword(
    String email,
    String password,
    String userName,
  ) async {
    try {
      state = state.copyWith(viewState: ViewState.busy);
      final user = await _userRepository.createUserWithEmailAndPassword(
        email,
        password,
        userName,
      );
      state = state.copyWith(user: user, viewState: ViewState.idle);
      return user;
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      state = state.copyWith(viewState: ViewState.idle);
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      state = state.copyWith(viewState: ViewState.busy);
      await _firebaseService.signOut();
    } catch (e) {
      // ... hata işleme
    } finally {
      state = state.copyWith(viewState: ViewState.idle);
    }
  }

  @override
  Future<UserModel?> currentUser() async {
    try {
      state = state.copyWith(viewState: ViewState.busy);
      final user = await _firebaseService.currentUser();
      state = state.copyWith(user: user, viewState: ViewState.idle);
      return user;
    } catch (e) {
    } finally {
      state = state.copyWith(viewState: ViewState.idle);
    }
    return null;
  }

  @override
  Future<UserModel> signWithEmaiAndPassword(String email, String password) async {
    try {
      state = state.copyWith(viewState: ViewState.busy);
      final user = await _firebaseService.signWithEmaiAndPassword(email, password);
      state = state.copyWith(user: user, viewState: ViewState.idle);
      return user;
    } catch (e) {
      // ... hata işleme
    } finally {
      state = state.copyWith(viewState: ViewState.idle);
    }
    return Future.value(UserModel());
  }
}

// UserState sınıfını tanımladık
class UserState extends Equatable {
  final UserModel? user;
  final ViewState viewState;

  UserState({this.user, required this.viewState});

  UserState copyWith({
    UserModel? user,
    ViewState? viewState,
  }) {
    return UserState(
      user: user ?? this.user,
      viewState: viewState ?? this.viewState,
    );
  }

  @override
  List<Object?> get props => [user, viewState];
}
