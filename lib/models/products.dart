import 'package:equatable/equatable.dart';

class Products with EquatableMixin {
  int? id;
  String? name;
  double? price;
  int? stock;
  String? description;
  String? imageUrl;
  int? quantity;
  int? categoryId;
  String? weight;

  Products({
    this.id,
    this.name,
    this.price,
    this.stock,
    this.description,
    this.imageUrl,
    this.quantity,
    this.categoryId,
    this.weight,
  });

  @override
  List<Object?> get props => [
        id,
        name,
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
      price: price ?? this.price,
      stock: stock ?? this.stock,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      quantity: quantity ?? this.quantity,
      categoryId: categoryId ?? this.categoryId,
      weight: weight ?? this.weight,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'stock': stock,
      'description': description,
      'imageUrl': imageUrl,
      'quantity': quantity,
      'categoryId': categoryId,
      'weight': weight,
    };
  }

  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
      id: json['id'] as int?,
      name: json['name'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      stock: json['stock'] as int?,
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String?,
      quantity: json['quantity'] as int?,
      categoryId: json['categoryId'] as int?,
      weight: json['weight'] as String?,
    );
  }
}
