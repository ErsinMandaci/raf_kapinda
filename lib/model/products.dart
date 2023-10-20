import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'products.g.dart';

@JsonSerializable()
@immutable
final class Products with EquatableMixin {
  Products({
    this.id,
    this.name,
    this.isFavorite,
    this.price,
    this.stock,
    this.description,
    this.imageUrl,
    this.quantity,
    this.categoryId,
    this.weight,
  });

  factory Products.fromJson(Map<String, dynamic> json) =>
      _$ProductsFromJson(json);
final int? id;
final String? name;
final bool? isFavorite;
final double? price;
final int? stock;
final String? description;
final String? imageUrl;
final int? quantity;
final int? categoryId;
final String? weight;

  Map<String, dynamic> toJson() => _$ProductsToJson(this);

  @override
  List<Object?> get props => [
        id,
        name,
        isFavorite,
        price,
        stock,
        description,
        imageUrl,
        quantity,
        categoryId,
        weight
      ];

  Products copyWith({
    int? id,
    String? name,
    bool? isFavorite,
    double? price,
    int? stock,
    String? description,
    String? imageUrl,
    int? quantity,
    int? categoryId,
    String? weight,
  }) {
    return Products(
      id: id ?? this.id,
      name: name ?? this.name,
      isFavorite: isFavorite ?? this.isFavorite,
      price: price ?? this.price,
      stock: stock ?? this.stock,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      quantity: quantity ?? this.quantity,
      categoryId: categoryId ?? this.categoryId,
      weight: weight ?? this.weight,
    );
  }
}
