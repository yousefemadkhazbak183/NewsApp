import 'package:flutter_news_app/core/constants/hive_constant.dart';
import 'package:flutter_news_app/core/model/user_model.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

class UserRepository {
  UserRepository._internal();
  static final UserRepository _instance = UserRepository._internal();
  factory UserRepository() => _instance;

  Box<UserModel>? _userBox;

  Box<UserModel> get userBox {
    if (_userBox == null) {
      throw Exception(
        "UserRepository not initialized. Call init() before accessing userBox.",
      );
    }
    return _userBox!;
  }

  Future<void> init() async {
    await Hive.initFlutter();

    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(UserModelAdapter());
    }

    _userBox = await Hive.openBox(HiveConstant.userBox);
  }

  Future<void> saveUser(UserModel user) async {
    await userBox.put(HiveConstant.currentUser, user);
  }

  getUser() => userBox.get(HiveConstant.currentUser);

  Future<void> updateUser({
    String? name,
    String? email,
    String? password,
    String? countryName,
    String? countryCode,
  }) async {
    final UserModel? user = getUser();
    if (user != null) {
      final updatedUser = user.copyWith(
        name: name,
        email: email,
        password: password,
        countryName: countryName,
        countryCode: countryCode,
      );
      await saveUser(updatedUser);
    }
  }

  deleteUser() async {
    await userBox.delete(HiveConstant.currentUser);
  }

  clearAll() async {
    await userBox.clear();
  }

  String? login(String email, String password) {
    final UserModel? user = getUser();
    if (user == null) {
      return "Not Found Account, Please Register First";
    }
    if (user.email != email || user.password != password) {
      return "Incorrect email or password";
    }
    return null;
  }

  Future<String?> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    final use = getUser();
    if (use != null) {
      return "Account already exists, Please Login";
    }
    final newUser = UserModel(name: name, email: email, password: password);
    await saveUser(newUser);
    return null;
  }
}
