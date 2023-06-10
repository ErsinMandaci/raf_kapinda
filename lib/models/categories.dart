import 'package:equatable/equatable.dart';

class Categories with EquatableMixin {
  int? id;
  String? name;
  String? categoryImage;

  Categories({
    this.id,
    this.name,
    this.categoryImage
  });

  @override
  List<Object?> get props => [id, name,categoryImage];

  Categories copyWith({
    int? id,
    String? name,
    String? categoryImage,
  }) {
    return Categories(
      id: id ?? this.id,
      name: name ?? this.name,
      categoryImage: categoryImage ?? this.categoryImage,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'categoryImage': categoryImage,
    };
  }

  factory Categories.fromJson(Map<String, dynamic> json) {
    return Categories(
      id: json['id'] as int?,
      name: json['name'] as String?,
      categoryImage: json['categoryImage'] as String?,
    );
  }
}
