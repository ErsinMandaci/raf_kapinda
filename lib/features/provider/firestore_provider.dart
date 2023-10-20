import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:groceries_app/core/services/firestore/firestore_service.dart';
import 'package:groceries_app/locator_manager.dart';

import 'package:groceries_app/model/orders.dart';
import 'package:groceries_app/model/products.dart';

final class FirestoreNotifier extends StateNotifier<FirestoreState> {
  FirestoreNotifier() : super(FirestoreState([], []));

  final FirestoreService _firestoreService = LocatorManager.firestoreService;

  Future<void> pushBasketDataToFirestore(List<Products> basketProducts) async {
    if (basketProducts.isNotEmpty) {
      await _firestoreService.pushBasketDataToFirestore(basketProducts);
      state = state.copyWith(productList: basketProducts);
    } else {
      return;
    }
  }

  Future<List<Orders>> getOrders() async {
    final orders = await _firestoreService.getOrders();
    if (orders.isNotEmpty) {
      state = state.copyWith(orderList: orders);
    } else {
      return [];
    }

    return orders;
  }
}

final class FirestoreState extends Equatable {
  final List<Products>? productList;
  final List<Orders>? orderList;

  FirestoreState(this.productList, this.orderList);

  FirestoreState copyWith({
    List<Products>? productList,
    List<Orders>? orderList,
  }) {
    return FirestoreState(
      productList ?? this.productList,
      orderList ?? this.orderList,
    );
  }

  @override
  List<Object?> get props => [productList, orderList];
}

