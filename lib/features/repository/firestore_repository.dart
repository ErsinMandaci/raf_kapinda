import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:groceries_app/core/services/firestore/firestore_base.dart';
import 'package:groceries_app/model/orders.dart';
import 'package:groceries_app/model/products.dart';
import 'package:groceries_app/model/user_model.dart';
import 'package:uuid/uuid.dart';

class FirestoreRepository implements DBBase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _user = FirebaseAuth.instance.currentUser;

  @override
  Future<bool> addUser(UserModel user) async {
    final DocumentSnapshot readUser =
        await _firestore.doc('users/${user.userID}').get();

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
    const uuid = Uuid();
    final orderCollection = _firestore.collection('orders');

    final querySnapshot =
        await orderCollection.where('userId', isEqualTo: _user?.uid).get();

    final orders = <Orders>[];

    for (final document in querySnapshot.docs) {
      final productsData = document.data()['products'] as Map<String, dynamic>;

      final products = productsData.entries.map((entry) {
        final productData = entry.value as Map<String, dynamic>;
        return Products(
          id: productData['id'] as int,
          name: productData['name'] as String,
          price: productData['price'] as double,
          imageUrl: productData['imageUrl'] as String,
          quantity: productData['quantity'] as int,
        );
      }).toList();

      final createdAtTimestamp = document.data()['createdAt'];
      final createdAt =
          DateTime.fromMillisecondsSinceEpoch(createdAtTimestamp as int);

      final order = Orders(
        orderId: document.id,
        userId: document.data()['userId'] as String,
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
    final DocumentSnapshot<Map<String, dynamic>> snapshot =
        await _firestore.collection('users').doc(userID).get();
    if (snapshot.data() == null) return UserModel();

    UserModel _userModel = new UserModel.fromJson(snapshot.data()!);
    return _userModel;
  }
}
