import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:groceries_app/core/services/firestore/firestore_service.dart';
import 'package:groceries_app/locator.dart';

import '../../models/products.dart';

class FirestoreNotifer extends ChangeNotifier {
  final FirestoreService _firestoreService = locator<FirestoreService>();

  final List<Products> orderList = [];

  Future<void> pushBasketDataToFirestore(List<Products> basketProducts) async {
    if (basketProducts.isNotEmpty) {
      await _firestoreService.pushBasketDataToFirestore(basketProducts);
    } else {
      debugPrint('Sepet boş');
    }
  }

  Future<List<Products>> getOrders() async {
    final orders = await _firestoreService.getOrders();

    if (orders.isNotEmpty) {
      orderList.addAll(orders);
    } else {
      debugPrint('Sipariş yok');
    }
    notifyListeners();
    return orderList;
  }
}
