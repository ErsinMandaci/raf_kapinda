import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:groceries_app/core/services/firestore/firestore_base.dart';
import 'package:uuid/uuid.dart';

import '../../model/orders.dart';
import '../../model/products.dart';
import '../../model/user_model.dart';

class FirestoreRepository implements DBBase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _user = FirebaseAuth.instance.currentUser;

  @override
  Future<bool> addUser(UserModel user) async {
    DocumentSnapshot readUser =
        await _firestore.doc("users/${user.userID}").get();

    if (!readUser.exists) {
      await _firestore.collection("users").doc(user.userID).set({
        'userName': user.userName,
        'email': user.email,
        'userID': user.userID,
      });
      return true;
    } else {
      debugPrint(
          'Kullanici zaten veritabanında var  (Add User FirestoreDBService))');
      return false;
    }
  }

  @override
  Future<List<Orders>> getOrders() async {
    var uuid = const Uuid();
    CollectionReference<Map<String, dynamic>> orderCollection =
        _firestore.collection('orders');

    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await orderCollection.where('userId', isEqualTo: _user?.uid).get();

    List<Orders> orders = [];

    for (var document in querySnapshot.docs) {
      List<dynamic> productsData = document.data()['products'];
   

      List<Products> products = productsData.map((productData) {
        return Products(
          id: productData['id'],
          name: productData['name'],
          price: productData['price'],
          imageUrl: productData['imageUrl'],
          quantity: productData['quantity'],
        );
      }).toList();
      var createdAtTimestamp = document.data()['createdAt'];
      DateTime createdAt =
          DateTime.fromMillisecondsSinceEpoch(createdAtTimestamp);




      Orders order = Orders(
        orderId: document.id,
        userId: document.data()['userId'],
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
       var uuid = const Uuid();
    DocumentReference<Map<String, dynamic>> orderCollection =
        _firestore.collection('orders').doc();

    Orders orders = Orders(
      orderId: orderCollection.id,
      userId: _user?.uid ?? '',
      orderNumber: uuid.v4(),
      products: basketProducts,
      createdAt: DateTime.now(),
    );

    await orderCollection.set(orders.toMap());
  }

  @override
  @override
  Future<UserModel> readUser(String userID) async {
    DocumentSnapshot snapshot =
        await _firestore.collection('users').doc(userID).get();
    return snapshot.exists
        ? UserModel.fromMap(snapshot.data() as Map<String, dynamic>)
        : UserModel();
  }
}
