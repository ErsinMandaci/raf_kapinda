import 'package:flutter/material.dart';
import 'package:groceries_app/features/repository/firestore_repository.dart';
import 'package:groceries_app/locator.dart';

import '../../models/products.dart';

class FirestoreNotifer extends ChangeNotifier {
  final FirestoreRepository _firestoreRepository =
      locator<FirestoreRepository>();

  Future<void> pushBasketDataToFiresore(List<Products> basketProducts) async {

    var response =
        await _firestoreRepository.pushBasketDataToFiresore(basketProducts);

        return response;
      

  }
  
}
