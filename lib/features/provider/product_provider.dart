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

  // final updatedProductList = state.productList?.map((element) {
  //   if (element.id == product.id) {
  //     final updatedQuantity = (element.quantity ?? 0) + 1;
  //     final updatedProduct = element.copyWith(quantity: updatedQuantity);
  //     return updatedProduct;
  //   }
  //   return element;
  // }).toList();
  // state = state.copyWith(productQuantity: product.quantity ?? 0, productList: updatedProductList);

  // Decrements the quantity of the given [product] in the [state]'s [productList].
  // If the quantity of the product is already 0, the function does nothing.
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



// class ProductNotifier extends ChangeNotifier {
//   final ProductRepository _productRepository = LocatorManager.productRepository;

//   final List<Products> products = [];
//   final List<Categories> categories = [];
//   final List<Products> selectedProducts = [];
//   final List<Products> basketProducts = [];
//   final List<Products> filterCategory = [];
//   final List<Products> searchProducts = [];

//   Set<String> favoriteIds = {};
//   bool? isLoading = false;
//   bool? dataloading = false;
//   double total = 0;
//   int counter = 1;
//   double totalCardPrice = 0;

//   Future<void> fetchAndLoad() async {
//     await allProduct();

//     notifyListeners();
//   }

//   List<Products> onCategorySelected(Categories category) {
//     filterCategory.clear();
//     final filterProduct = products
//         .where((element) => element.categoryId == category.id)
//         .toSet()
//         .toList();
//     filterCategory.addAll(filterProduct);
//     return filterCategory;
//   }

//   Future<List<Groceries>> allProduct() async {
//     final groceries = await _productRepository.getProduct();

//     if (groceries != null) {
//       if (products.isEmpty && categories.isEmpty) {
//         products.addAll(groceries[0].products as List<Products>);
//         categories.addAll(groceries[0].categories as List<Categories>);
//       }
//     }
//     return [];
//   }

//   void setFavoriteCard(Products products) {
//     if (favoriteIds.contains(products.id.toString())) {
//       favoriteIds.remove(products.id.toString());
//     } else {
//       favoriteIds.add(products.id.toString());
//     }
//     notifyListeners();
//   }

//   List<Products> getFavoriteProducts() {
//     return products
//         .where((element) => favoriteIds.contains(element.id.toString()))
//         .toList();
//   }

//   double basketTotalPrice(Products product) {
//     total = (product.price ?? 0) * (product.quantity ?? 0);
//     notifyListeners();
//     return total;
//   }

//   int increaseQuantity(Products product) {
//     notifyListeners();
//     return (product.quantity ?? 0) + 1;
    
//   }

//   int decreaseQuantity(Products product) {
//     notifyListeners();
//     return (product.quantity ?? 0) - 1;
//   }

//   void counterIncrement(Products product) {
//     if (product.quantity != null && product.quantity! < 15) {
//       increaseQuantity(product);
//       basketTotalPrice(product);
//     }
//     notifyListeners();
//   }

//   void counterDecrement(Products product) {
//     if (product.quantity != null && product.quantity! > 1) {
//       decreaseQuantity(product);
//       basketTotalPrice(product);
//     }
//     notifyListeners();
//   }

//   int getNewQuantity(Products product) {
//     if (product.quantity == null) {
//       return 1;
//     }
//     return product.quantity! + 1;
//   }

//   List<Products> addBasket() {
//     isLoading = true;
//     notifyListeners();

//     if (selectedProducts.isNotEmpty) {
//       final existingProductIndex =
//           basketProducts.indexWhere((p) => p.id == selectedProducts.first.id);

//       if (existingProductIndex != -1) {
//         int newQuantity = getNewQuantity(selectedProducts.first);
//         Products updatedProduct = Products(
//           id: basketProducts[existingProductIndex].id,
//           name: basketProducts[existingProductIndex].name,
//           price: basketProducts[existingProductIndex].price,
//           quantity: newQuantity,
//         );
//         basketProducts[existingProductIndex] = updatedProduct;
//       } else {
//         basketProducts.addAll(selectedProducts);
//       }

//       notifyListeners();
//     }

//     Future.delayed(const Duration(seconds: 4), () {
//       isLoading = false;
//       notifyListeners();
//     });

//     return [];
//   }

//   void removeBasket(Products product) {
//     basketProducts.removeWhere((element) => element.id == product.id);
//     notifyListeners();
//   }

//   double cardPrice() {
//     if (basketProducts.isNotEmpty) {
//       totalCardPrice = basketProducts
//           .map((e) => e.price! * e.quantity!)
//           .reduce((value, element) => value + element);
//       return totalCardPrice;
//     }
//     notifyListeners();
//     return 0;
//   }

//   double getBasketPrice(Products product) {
//     final priceBasket = product.price! * product.quantity!;
//     return priceBasket;
//   }

//   Future<Products> selectedItem(Products selected) async {
//     selectedProducts.clear();
//     counter = 1;
//     if (products.isNotEmpty) {
//       selectedProducts.addAll(
//         products.where(
//           (element) => element.id.toString() == selected.id.toString(),
//         ),
//       );
//       notifyListeners();
//     }
//     basketTotalPrice(selected);
//     return selectedProducts.first;
//   }

//   void searchList(String value) {
//     searchProducts.clear();

//     if (value.isNotEmpty) {
//       searchProducts.addAll(
//         products.where(
//           (element) =>
//               element.name!.toLowerCase().contains(value.toLowerCase()),
//         ),
//       );
//     }

//     notifyListeners();
//   }
// }
