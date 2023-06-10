import 'package:equatable/equatable.dart';
import 'products.dart';
import 'categories.dart';

class Groceries with EquatableMixin {
  List<Products>? products;
  List<Categories>? categories;

  Groceries({
    this.products,
    this.categories,
  });

  @override
  List<Object?> get props => [products, categories];

  Groceries copyWith({
    List<Products>? products,
    List<Categories>? categories,
  }) {
    return Groceries(
      products: products ?? this.products,
      categories: categories ?? this.categories,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'products': products,
      'categories': categories,
    };
  }

  factory Groceries.fromJson(Map<String, dynamic> json) {
    return Groceries(
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => Products.fromJson(e as Map<String, dynamic>))
          .toList(),
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => Categories.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
