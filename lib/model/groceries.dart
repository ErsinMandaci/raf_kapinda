import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:groceries_app/model/categories.dart';
import 'package:groceries_app/model/products.dart';
import 'package:json_annotation/json_annotation.dart';

part 'groceries.g.dart';

@immutable
@JsonSerializable()
final class Groceries with EquatableMixin {
  Groceries({
    this.products,
    this.categories,
  });

  factory Groceries.fromJson(Map<String, dynamic> json) => _$groceriesFromJson(json);
  final List<Products>? products;
  final List<Categories>? categories;

  Map<String, dynamic> toJson() => _$groceriesToJson(this);

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
}
