import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:groceries_app/core/services/firestore/firestore_base.dart';
import 'package:groceries_app/models/user_model.dart';

import '../../models/products.dart';

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
 Future<List<Products>> getOrders() async {
  CollectionReference<Map<String, dynamic>> orderCollection =
      _firestore.collection('orders');
  User? user = FirebaseAuth.instance.currentUser;
  
  QuerySnapshot<Map<String, dynamic>> querySnapshot = await orderCollection
      .where('userID', isEqualTo: user?.uid)
      .get();

  List<Products> products = [];
  if (querySnapshot.docs.isNotEmpty) {
    for (QueryDocumentSnapshot<Map<String, dynamic>> doc
        in querySnapshot.docs) {
      List<dynamic> productsData = doc['products'];
      for (dynamic productData in productsData) {
        Products product = Products(
          id: productData['productId'],
          name: productData['name'],
          price: productData['price'],
          imageUrl: productData['image'],
          quantity: productData['quantity'],
        );
        products.add(product);
      }
    }
  }

  return products;
}


  @override
  Future<void> pushBasketDataToFirestore(List<Products> basketProducts) async {
    CollectionReference<Map<String, dynamic>> orderCollection =
        _firestore.collection('orders');
    User? user = FirebaseAuth.instance.currentUser;
    DocumentReference<Map<String, dynamic>> newOrderDocument =
        orderCollection.doc();

    Map<String, dynamic> orderData = {
      'userID': user?.uid,
      'products': basketProducts
          .map((product) => {
                'productId': product.id,
                'name': product.name,
                'price': product.price,
                'image': product.imageUrl,
                'quantity': product.quantity,
              })
          .toList(),
    };

    await newOrderDocument.set(orderData);
  }

  @override
  Future<UserModel> readUser(String userID) async {
    DocumentSnapshot snapshot =
        await _firestore.collection('users').doc(userID).get();

    if (snapshot.exists) {
      Map<String, dynamic> userMap = snapshot.data() as Map<String, dynamic>;
      UserModel user = UserModel.fromMap(userMap);
      return user;
    } else {
      debugPrint('Kullanici veritabanında yok (Read User FirestoreDBService)');
      return UserModel();
    }
  }
}
