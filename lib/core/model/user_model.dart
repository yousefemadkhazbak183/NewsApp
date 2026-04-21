import 'package:hive_ce_flutter/adapters.dart';
part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  String? name;
  @HiveField(1)
  String? email;
  @HiveField(2)
  String? password;

  @HiveField(3)
  String? countryName;
  @HiveField(4)
  String? countryCode;
  UserModel({
    required this.name,
    required this.email,
    this.password,
    this.countryName,
    this.countryCode,
  });

  factory UserModel.fromMap(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      password: json['password'],
      countryName: json['countryName'],
      countryCode: json['countryCode'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'countryName': countryName,
      'countryCode': countryCode,
    };
  }

  UserModel copyWith({
    String? name,
    String? email,
    String? password,
    String? countryName,
    String? countryCode,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      countryName: countryName ?? this.countryName,
      countryCode: countryCode ?? this.countryCode,
    );
  }
}
