// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Products _$ProductsFromJson(Map<String, dynamic> json) => Products(
      id: json['id'] as int?,
      name: json['name'] as String?,
      isFavorite: json['isFavorite'] as bool?,
      price: (json['price'] as num?)?.toDouble(),
      stock: json['stock'] as int?,
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String?,
      quantity: json['quantity'] as int?,
      categoryId: json['categoryId'] as int?,
      weight: json['weight'] as String?,
    );

Map<String, dynamic> _$ProductsToJson(Products instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'isFavorite': instance.isFavorite,
      'price': instance.price,
      'stock': instance.stock,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'quantity': instance.quantity,
      'categoryId': instance.categoryId,
      'weight': instance.weight,
    };
