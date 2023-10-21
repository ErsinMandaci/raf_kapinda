import 'package:groceries_app/core/services/product/product_service.dart';
import 'package:groceries_app/locator_manager.dart';
import 'package:groceries_app/model/groceries.dart';
import 'package:kartal/kartal.dart';

final class ProductRepository {
  final ProductService _productService = LocatorManager.productService;

  Future<List<Groceries>>? getProduct() async {
    final jsonData = await _productService.loadJson();
    if (jsonData == null) return [];
    if (jsonData.categories.isNotNullOrEmpty && jsonData.products.isNotNullOrEmpty) {
      return [jsonData];
    } else {
      return [];
    }
  }
}
