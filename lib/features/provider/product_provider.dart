import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:groceries_app/features/repository/product_repository.dart';
import 'package:groceries_app/locator_manager.dart';
import 'package:groceries_app/model/categories.dart';
import 'package:groceries_app/model/products.dart';
import 'package:kartal/kartal.dart';

final class ProductNotifier extends StateNotifier<ProductState> {
  ProductNotifier() : super(ProductState());

  final ProductRepository _productRepository = LocatorManager.productRepository;

  Future<void> allProduct() async {
    final groceriesData = await _productRepository.getProduct();
    if (groceriesData.isNullOrEmpty) return;

    state = state.copyWith(
      productList: groceriesData?[0].products,
      categoryList: groceriesData?[0].categories,
    );
  }

  // Returns the selected product from the product list.
  // If the selected product is not found in the list, returns an empty [Products] object.
  void selectedItem(Products selected) {
    final selectedProducts = state.productList?.where((element) => element.id == selected.id).toList();
    if (selectedProducts.isNullOrEmpty) return;
    state = state.copyWith(selectedProduct: selectedProducts?.first);
  }

  // Filters the product list by the given category and returns the filtered list.
  // If the product list is null, an empty list is returned.
  void filterCategory(Categories categories) {
    final filterProduct = state.productList?.where((element) => element.categoryId == categories.id).toSet().toList();
    state = state.copyWith(filteredFavoriteList: filterProduct);
  }

  // Returns a list of favorite products from the [state.productList].
  // If the [state.productList] is null, an empty list is returned.
  List<Products> getFavoriteProducts() {
    return state.productList?.where((element) => element.isFavorite == true).toList() ?? [];
  }

  // Changes the favorite status of a product and updates the product list in the state accordingly.
  void changeFavoriteCard(Products products) {
    final updateProductList = List<Products>.from(state.productList ?? []);
    final index = updateProductList.indexWhere((element) => element.id == products.id);
    updateProductList[index] = products.copyWith(isFavorite: !products.isFavorite!);
    state = state.copyWith(productList: updateProductList);
  }

  // Adds a [Products] object to the basket list in the current [state].
  // If the basket list is null, it creates a new list and adds the product to it.
  // Otherwise, it creates a copy of the existing list and adds the product to the copy.
  // Finally, it updates the state with the new basket list.
  void addProductBasket(Products products) {
    final updateBasketList = List<Products>.from(state.basketList ?? []);
    updateBasketList.add(products);
    state = state.copyWith(basketList: updateBasketList);
  }

  // Removes the given [products] from the basket list in the current state.
  void removeProductBasket(Products products) {
    final updateBasketList = List<Products>.from(state.basketList ?? []);
    updateBasketList.remove(products);
    state = state.copyWith(basketList: updateBasketList);
  }

  // Increments the quantity of the given [product] in the [state]'s [productList].
  // Returns nothing.
  void incrementProductQuantity(Products product) {
    final updatedQuantity = (product.quantity ?? 0) + 1;
    state = state.copyWith(productQuantity: updatedQuantity);
  }

  void decrementProductQuantity(Products product) {
    if ((product.quantity ?? 0) > 0) {
      final updatedQuantity = (product.quantity ?? 0) - 1;
      state = state.copyWith(productQuantity: updatedQuantity);
    }
  }

  void searchProducts(String query) {
    if (state.productList.isNullOrEmpty) return;
    final searchResults =
        state.productList!.where((product) => product.name!.toLowerCase().contains(query.toLowerCase())).toList();
    state = state.copyWith(searchResults: searchResults);
  }

  void calculateTotalBasketPrice() {
    final basketList = state.basketList;
    if (basketList != null && basketList.isNotEmpty) {
      double total = 0.0;
      for (var product in basketList) {
        total += (product.price ?? 0.0) * (product.quantity ?? 1);
      }
      state = state.copyWith(totalBasketPrice: total);
    } else {
      state = state.copyWith(totalBasketPrice: 0.0);
    }
  }
}

final class ProductState extends Equatable {
  // The list of products
  final List<Products>? productList;
  // The list of categories
  final List<Categories>? categoryList;
  // The list of products in the basket
  final List<Products>? basketList;
  // The favorite status of the product
  final bool isFavorite;
  // The quantity of the product
  final int productQuantity;
  // The list of favorite products
  final List<Products>? filteredFavoriteList;
  // The selected product
  final Products? selectedProduct;
  // The total price of the products in the basket
  final double totalBasketPrice;
  // The list of products that match the search query
  final List<Products>? searchResults;

  ProductState({
    this.productList,
    this.categoryList,
    this.basketList,
    this.isFavorite = false,
    this.productQuantity = 1,
    this.filteredFavoriteList,
    this.totalBasketPrice = 0,
    this.searchResults,
    this.selectedProduct,
  });

  ProductState copyWith({
    List<Products>? productList,
    List<Categories>? categoryList,
    List<Products>? basketList,
    bool? isFavorite,
    int? productQuantity,
    List<Products>? filteredFavoriteList,
    double? totalBasketPrice,
    List<Products>? searchResults,
    Products? selectedProduct,
  }) {
    return ProductState(
      productList: productList ?? this.productList,
      categoryList: categoryList ?? this.categoryList,
      basketList: basketList ?? this.basketList,
      isFavorite: isFavorite ?? this.isFavorite,
      productQuantity: productQuantity ?? this.productQuantity,
      filteredFavoriteList: filteredFavoriteList ?? this.filteredFavoriteList,
      totalBasketPrice: totalBasketPrice ?? this.totalBasketPrice,
      searchResults: searchResults ?? this.searchResults,
      selectedProduct: selectedProduct ?? this.selectedProduct,
    );
  }

  @override
  List<Object?> get props => [
        productList,
        categoryList,
        basketList,
        isFavorite,
        productQuantity,
        filteredFavoriteList,
        totalBasketPrice,
        searchResults,
        selectedProduct,
      ];
}
