// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      userID: json['userID'] as String?,
      email: json['email'] as String?,
      userName: json['userName'] as String?,
      profilURL: json['profilURL'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'userID': instance.userID,
      'email': instance.email,
      'userName': instance.userName,
      'profilURL': instance.profilURL,
    };
