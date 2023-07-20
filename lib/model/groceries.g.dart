// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'groceries.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Groceries _$groceriesFromJson(Map<String, dynamic> json) => Groceries(
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => Products.fromJson(e as Map<String, dynamic>))
          .toList(),
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => Categories.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$groceriesToJson(Groceries instance) => <String, dynamic>{
      'products': instance.products,
      'categories': instance.categories,
    };
