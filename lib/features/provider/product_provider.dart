import 'package:flutter/material.dart';
import 'package:groceries_app/features/repository/product_repository.dart';
import 'package:groceries_app/locator_manager.dart';
import 'package:groceries_app/model/categories.dart';
import 'package:groceries_app/model/groceries.dart';
import 'package:groceries_app/model/products.dart';

class ProductNotifier extends ChangeNotifier {
  final ProductRepository _productRepository = LocatorManager.productRepository;

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
    final filterProduct = products
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

  void setFavoriteCard(Products products) {
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

  double basketTotalPrice(Products product) {
    total = (product.price ?? 0) * (product.quantity ?? 0);
    notifyListeners();
    return total;
  }

  int increaseQuantity(Products product) {
    notifyListeners();
    return (product.quantity ?? 0) + 1;
    
  }

  int decreaseQuantity(Products product) {
    notifyListeners();
    return (product.quantity ?? 0) - 1;
  }

  void counterIncrement(Products product) {
    if (product.quantity != null && product.quantity! < 15) {
      increaseQuantity(product);
      basketTotalPrice(product);
    }
    notifyListeners();
  }

  void counterDecrement(Products product) {
    if (product.quantity != null && product.quantity! > 1) {
      decreaseQuantity(product);
      basketTotalPrice(product);
    }
    notifyListeners();
  }

  int getNewQuantity(Products product) {
    if (product.quantity == null) {
      return 1;
    }
    return product.quantity! + 1;
  }

  List<Products> addBasket() {
    isLoading = true;
    notifyListeners();

    if (selectedProducts.isNotEmpty) {
      final existingProductIndex =
          basketProducts.indexWhere((p) => p.id == selectedProducts.first.id);

      if (existingProductIndex != -1) {
        int newQuantity = getNewQuantity(selectedProducts.first);
        Products updatedProduct = Products(
          id: basketProducts[existingProductIndex].id,
          name: basketProducts[existingProductIndex].name,
          price: basketProducts[existingProductIndex].price,
          quantity: newQuantity,
        );
        basketProducts[existingProductIndex] = updatedProduct;
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
    final priceBasket = product.price! * product.quantity!;
    return priceBasket;
  }

  Future<Products> selectedItem(Products selected) async {
    selectedProducts.clear();
    counter = 1;
    if (products.isNotEmpty) {
      selectedProducts.addAll(
        products.where(
          (element) => element.id.toString() == selected.id.toString(),
        ),
      );
      notifyListeners();
    }
    basketTotalPrice(selected);
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
