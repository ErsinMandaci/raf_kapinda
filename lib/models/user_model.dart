import 'package:equatable/equatable.dart';

class UserModel with EquatableMixin {
  String? userID;
  String? email;
  String? userName;
  String? profilURL;
  UserModel({
     this.userID,
     this.email,
    this.userName,
    this.profilURL,
  });

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

  @override
  List<Object?> get props => [userID, email, userName, profilURL];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userID': userID,
      'email': email,
      'userName': userName,
      'profilURL': profilURL,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userID: map['userID'] != null ? map['userID'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      userName: map['userName'] != null ? map['userName'] as String : null,
      profilURL: map['profilURL'] != null ? map['profilURL'] as String : null,
    );
  }
}
