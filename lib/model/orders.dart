import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:groceries_app/model/products.dart';

@immutable
final class Orders with EquatableMixin {
  final String? orderId;
  final String? userId;
  final String? orderNumber;
  final DateTime? createdAt;
  final List<Products>? products;

  Orders({
    this.orderId,
    this.userId,
    this.orderNumber,
    this.createdAt,
    this.products,
  });

  String get formattedCreatedAt {
    if (createdAt != null) {
      return '${createdAt!.day}.${createdAt!.month}.${createdAt!.year} ${createdAt!.hour}:${createdAt!.minute}';
    } else {
      return 'not available';
    }
  }

  @override
  List<Object?> get props =>
      [orderId, userId, products, createdAt, orderNumber];

  Orders copyWith({
    String? orderId,
    String? userId,
    String? orderNumber,
    DateTime? createdAt,
    List<Products>? products,
  }) {
    return Orders(
      orderId: orderId ?? this.orderId,
      userId: userId ?? this.userId,
      orderNumber: orderNumber ?? this.orderNumber,
      createdAt: createdAt ?? this.createdAt,
      products: products ?? this.products,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'orderId': orderId,
      'userId': userId,
      'orderNumber': orderNumber,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'products': products?.map((product) => product.toJson()).toList(),
    };
  }

  factory Orders.fromMap(Map<String, dynamic> map) {
    return Orders(
      orderId: map['orderId'] != null ? map['orderId'] as String : null,
      userId: map['userId'] != null ? map['userId'] as String : null,
      orderNumber:
          map['orderNumber'] != null ? map['orderNumber'] as String : null,
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int)
          : null,
      products: map['products'] != null
          ? List<Products>.from(
              (map['products'] as List<int>).map<Products?>(
                (x) => Products.fromJson(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Orders.fromJson(String source) =>
      Orders.fromMap(json.decode(source) as Map<String, dynamic>);
}
