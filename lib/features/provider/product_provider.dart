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

    final updatedSelectedProduct = selectedProducts!.first;
    final updatedTotalPrice = (updatedSelectedProduct.price ?? 0.0) * (updatedSelectedProduct.quantity ?? 0);

    state = state.copyWith(selectedProduct: updatedSelectedProduct, totalPrice: updatedTotalPrice);
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
    final updatedProductList = state.productList?.map((element) {
      if (element.id == product.id) {
        final updatedQuantity = (element.quantity ?? 0) + 1;
        final updatedProduct = element.copyWith(quantity: updatedQuantity);
        if (state.selectedProduct?.id == product.id) {
          state = state.copyWith(selectedProduct: updatedProduct);
        }
        return updatedProduct;
      }
      return element;
    }).toList();
    state = state.copyWith(productList: updatedProductList);
    calculateProductTotalPrice();
  }

  // Decrements the quantity of the given [product] in the [state]'s [productList].
  void decrementProductQuantity(Products product) {
    final updatedProductList = state.productList?.map((element) {
      if (element.id == product.id && (element.quantity ?? 0) > 0) {
        final updatedQuantity = (element.quantity ?? 0) - 1;
        final updatedProduct = element.copyWith(quantity: updatedQuantity);
        if (state.selectedProduct?.id == product.id) {
          state = state.copyWith(selectedProduct: updatedProduct);
        }
        return updatedProduct;
      }
      return element;
    }).toList();
    state = state.copyWith(productList: updatedProductList);
    calculateProductTotalPrice();
  }

  // total product quantity
  int getProductQuantity(String productId) {
    final product =
        state.productList?.firstWhere((p) => p.id.toString() == productId.toString(), orElse: () => Products());
    return product?.quantity ?? 0;
  }

  /// Searches the product list for products whose name contains the given query string.
  /// If the query string is empty or null, the search results will be empty.
  void searchProducts(String query) {
    if (state.productList.isNullOrEmpty) return;
    final searchResults = state.productList!
        .where((product) => product.name!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    state = state.copyWith(searchResults: searchResults);
  }

  /// Calculates the total price of the product.
  void calculateProductTotalPrice() {
    final totalPrice = (state.selectedProduct?.price ?? 0.0) * (state.selectedProduct?.quantity ?? 0);
    state = state.copyWith(totalPrice: totalPrice);
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
  // The list of favorite products
  final List<Products>? filteredFavoriteList;
  // The selected product
  final Products? selectedProduct;
  // The total price of the products in the basket
  final double totalBasketPrice;
  // The list of products that match the search query
  final List<Products>? searchResults;
  // The total price of the product
  final double productTotalPrice;

  //

  ProductState({
    this.productList,
    this.categoryList,
    this.basketList,
    this.isFavorite = false,
    this.filteredFavoriteList,
    this.totalBasketPrice = 0,
    this.searchResults,
    this.selectedProduct,
    this.productTotalPrice = 0,
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
    double? totalPrice,
  }) {
    return ProductState(
      productList: productList ?? this.productList,
      categoryList: categoryList ?? this.categoryList,
      basketList: basketList ?? this.basketList,
      isFavorite: isFavorite ?? this.isFavorite,
      filteredFavoriteList: filteredFavoriteList ?? this.filteredFavoriteList,
      totalBasketPrice: totalBasketPrice ?? this.totalBasketPrice,
      searchResults: searchResults ?? this.searchResults,
      selectedProduct: selectedProduct ?? this.selectedProduct,
      productTotalPrice: totalPrice ?? this.productTotalPrice,
    );
  }

  @override
  List<Object?> get props => [
        productList,
        categoryList,
        basketList,
        isFavorite,
        filteredFavoriteList,
        totalBasketPrice,
        searchResults,
        selectedProduct,
        productTotalPrice,
      ];
}
