import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'categories.g.dart';

@JsonSerializable()
@immutable
final class Categories with EquatableMixin {
  Categories({
    this.id,
    this.name,
    this.categoryImage,
  });

  factory Categories.fromJson(Map<String, dynamic> json) =>
      _$CategoriesFromJson(json);
final int? id;
final String? name;
final String? categoryImage;

  Map<String, dynamic> toJson() => _$CategoriesToJson(this);

  @override
  List<Object?> get props => [id, name, categoryImage];

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
}
