import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:groceries_app/core/services/firestore/firestore_base.dart';
import 'package:groceries_app/model/orders.dart';
import 'package:groceries_app/model/products.dart';
import 'package:groceries_app/model/user_model.dart';
import 'package:uuid/uuid.dart';

final class FirestoreRepository implements DBBase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _user = FirebaseAuth.instance.currentUser;

  @override
  Future<bool> addUser(UserModel user) async {
    final DocumentSnapshot readUser = await _firestore.doc('users/${user.userID}').get();

    if (!readUser.exists) {
      await _firestore.collection('users').doc(user.userID).set({
        'userName': user.userName,
        'email': user.email,
        'userID': user.userID,
      });
      return true;
    } else {
      debugPrint(
        'Kullanici zaten veritabanında var  (Add User FirestoreDBService))',
      );
      return false;
    }
  }

  @override
  Future<List<Orders>> getOrders() async {
    final Uuid uuid = Uuid();
    final orderCollection = _firestore.collection('orders');

    final querySnapshot = await orderCollection.where('userId', isEqualTo: _user?.uid).get();

    final orders = <Orders>[];

    for (final document in querySnapshot.docs) {
      final Map<String, dynamic>? documentData = document.data();
      if (documentData == null || documentData.isEmpty) continue;

      final dynamic productsDataDynamic = documentData['products'];
      if (productsDataDynamic is! Map<String, dynamic>) continue;
      final Map<String, dynamic> productsData = productsDataDynamic;

      final List<Products> products = [];

      productsData.forEach((key, value) {
        if (value is Map<String, dynamic>) {
          products.add(Products.fromJson(value));
        }
      });
      final int? createdAtTimestamp = documentData['createdAt'] as int?;
      final DateTime createdAt =
          (createdAtTimestamp != null) ? DateTime.fromMillisecondsSinceEpoch(createdAtTimestamp) : DateTime.now();
          
      final String? userId = document.data()['userId']?.toString();

      final order = Orders(
        orderId: document.id,
        userId: userId,
        orderNumber: uuid.v4(),
        createdAt: createdAt,
        products: products,
      );

      orders.add(order);
    }

    return orders;
  }

  @override
  Future<void> pushBasketDataToFirestore(List<Products> basketProducts) async {
    const uuid = Uuid();
    final orderCollection = _firestore.collection('orders').doc();

    final orders = Orders(
      orderId: orderCollection.id,
      userId: _user?.uid ?? '',
      orderNumber: uuid.v4(),
      products: basketProducts,
      createdAt: DateTime.now(),
    );

    await orderCollection.set(orders.toMap());
  }

  @override
  Future<UserModel> readUser(String userID) async {
    final DocumentSnapshot<Map<String, dynamic>> snapshot = await _firestore.collection('users').doc(userID).get();
    if (snapshot.data() == null) return UserModel();

    UserModel _userModel = new UserModel.fromJson(snapshot.data()!);
    return _userModel;
  }
}
