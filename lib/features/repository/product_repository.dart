import 'package:groceries_app/models/groceries.dart';

import '../../core/services/product/product_service.dart';
import '../../locator.dart';
import '../../models/categories.dart';
import '../../models/products.dart';

class ProductRepository {
  final ProductService _productService = locator<ProductService>();

  Future<List<Groceries>>? getProduct() async {
    final Map<String, dynamic> data = await _productService.fetchProduct();

    if (data.isNotEmpty) {
      final List<dynamic> products = data['products'];
      final List<dynamic> categories = data['categories'];

      return [
        Groceries(
          products: products.map((e) => Products.fromJson(e)).toList(),
          categories: categories.map((e) => Categories.fromJson(e)).toList(),
        ),
      ];
    } else {
      return [];
    }
  }
}
