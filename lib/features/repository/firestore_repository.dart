import 'package:groceries_app/core/services/firestore/firestore_db_service.dart';
import 'package:groceries_app/locator.dart';

import '../../models/products.dart';

class FirestoreRepository {
  final FirestoreDBService _firestoreDBService = locator<FirestoreDBService>();

  Future<void> pushBasketDataToFiresore(List<Products> basketProducts) async {
    var response =
        await _firestoreDBService.pushBasketDataToFirestore(basketProducts);
    return response;
  }
}
