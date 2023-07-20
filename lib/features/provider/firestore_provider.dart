import 'package:flutter/material.dart';
import 'package:groceries_app/core/services/firestore/firestore_service.dart';
import 'package:groceries_app/locator_manager.dart';

import 'package:groceries_app/model/orders.dart';
import 'package:groceries_app/model/products.dart';

class FirestoreNotifer extends ChangeNotifier {
  final FirestoreService _firestoreService = LocatorManager.firestoreService;

  final List<Orders> orderList = [];

  Future<void> pushBasketDataToFirestore(List<Products> basketProducts) async {
    if (basketProducts.isNotEmpty) {
      await _firestoreService.pushBasketDataToFirestore(basketProducts);
    } else {
      debugPrint('Sepet boş');
    }
  }

  Future<List<Orders>> getOrders() async {
    final orders = await _firestoreService.getOrders();
    orderList.clear();

    if (orders.isNotEmpty) {
      orderList.addAll(orders);
      orderList.sort(
        (a, b) => b.createdAt?.compareTo(a.createdAt ?? DateTime.now()) ?? 0,
      );
    } else {
      debugPrint('Sipariş yok');
    }

    notifyListeners();

    return orderList;
  }
}
