import 'package:flutter/material.dart';
import 'package:groceries_app/features/repository/product_repository.dart';
import 'package:groceries_app/locator.dart';

import '../../model/categories.dart';
import '../../model/groceries.dart';
import '../../model/products.dart';

class ProductNotifier extends ChangeNotifier {
  final ProductRepository _productRepository = locator<ProductRepository>();
  // final FirestoreRepository _firestoreRepository = locator<FirestoreRepository>();

  final List<Products> products = [];
  final List<Categories> categories = [];
  final List<Products> selectedProducts = [];
  final List<Products> basketProducts = [];
  final List<Products> filterCategory = [];
  final List<Products> searchProducts = [];

  Set<String> favoriteIds = {};
  bool? isLoading = false;
  bool? dataloading = false;
  double total = 0;
  int counter = 1;
  double totalCardPrice = 0;

  Future<void> fetchAndLoad() async {
    await allProduct();

    notifyListeners();
  }

  List<Products> onCategorySelected(Categories category) {
    filterCategory.clear();
    List<Products> filterProduct = products
        .where((element) => element.categoryId == category.id)
        .toSet()
        .toList();
    filterCategory.addAll(filterProduct);
    return filterCategory;
  }

  Future<List<Groceries>> allProduct() async {
    final groceries = await _productRepository.getProduct();

    if (groceries != null) {
      if (products.isEmpty && categories.isEmpty) {
        products.addAll(groceries[0].products as List<Products>);
        categories.addAll(groceries[0].categories as List<Categories>);
      }
    }
    return [];
  }

  setFavorite(Products products) {
    if (favoriteIds.contains(products.id.toString())) {
      favoriteIds.remove(products.id.toString());
    } else {
      favoriteIds.add(products.id.toString());
    }
    notifyListeners();
  }

  List<Products> getFavoriteProducts() {
    return products
        .where((element) => favoriteIds.contains(element.id.toString()))
        .toList();
  }

  String totalPrice(Products product) {
    total = product.price! * product.quantity!;
    notifyListeners();
    return total.toStringAsFixed(2);
  }

  void counterIncrement(Products product) {
    if (product.quantity != null && product.quantity! < 15) {
      product.quantity = (product.quantity! + counter).clamp(0, 15);
      totalPrice(product);
    }
    notifyListeners();
  }

  void counterDecrement(Products product) {
    if (product.quantity != null && product.quantity! > 1) {
      product.quantity = (product.quantity! - counter).clamp(1, 15);
      totalPrice(product);
    }
    notifyListeners();
  }
  

  List<Products> addBasket() {
    isLoading = true;

    notifyListeners();
    if (selectedProducts.isNotEmpty) {
      int existingProductIndex =
          basketProducts.indexWhere((p) => p.id == selectedProducts.first.id);

      if (existingProductIndex != -1) {
        basketProducts[existingProductIndex].quantity =
            selectedProducts.first.quantity!;
      } else {
        basketProducts.addAll(selectedProducts);
      }

      notifyListeners();
    }
    Future.delayed(const Duration(seconds: 4), () {
      isLoading = false;
   
      notifyListeners();
    });

    return [];
  }

  void removeBasket(Products product) {
    basketProducts.removeWhere((element) => element.id == product.id);
    notifyListeners();
  }

  double cardPrice() {
    if (basketProducts.isNotEmpty) {
      totalCardPrice = basketProducts
          .map((e) => e.price! * e.quantity!)
          .reduce((value, element) => value + element);
      return totalCardPrice;
    }
    notifyListeners();
    return 0;
  }

  double getBasketPrice(Products product) {
    double priceBasket = product.price! * product.quantity!;
    return priceBasket;
  }

  Future<Products> selectedItem(Products selected) async {
    selectedProducts.clear();
    counter = 1;
    if (products.isNotEmpty) {
      selectedProducts.addAll(products
          .where((element) => element.id.toString() == selected.id.toString()));
      notifyListeners();
    }
    totalPrice(selected);
    return selectedProducts.first;
  }

  void searchList(String value) {
    searchProducts.clear();

    if (value.isNotEmpty) {
      searchProducts.addAll(
        products.where(
          (element) =>
              element.name!.toLowerCase().contains(value.toLowerCase()),
        ),
      );
    }

    notifyListeners();
  }
}
