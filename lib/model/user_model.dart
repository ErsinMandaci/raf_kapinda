import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
@immutable
final class UserModel with EquatableMixin {
  UserModel({
    this.userID,
    this.email,
    this.userName,
    this.profilURL,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
final  String? userID;
final  String? email;
final  String? userName;
final  String? profilURL;

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @override
  List<Object?> get props => [userID, email, userName, profilURL];

  UserModel copyWith({
    String? userID,
    String? email,
    String? userName,
    String? profilURL,
  }) {
    return UserModel(
      userID: userID ?? this.userID,
      email: email ?? this.email,
      userName: userName ?? this.userName,
      profilURL: profilURL ?? this.profilURL,
    );
  }
}
