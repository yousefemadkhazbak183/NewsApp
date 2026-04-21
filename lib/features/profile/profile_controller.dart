import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/data/user_repository.dart';
import 'package:flutter_news_app/core/mixins/notify_mixin.dart';
import 'package:flutter_news_app/core/model/user_model.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends ChangeNotifier with NotifyMixin {
  XFile? selectedImage;
  String? userName;
  String? countryName;
  String? countryCode;

  void pickImage(ImageSource source) async {
    selectedImage = await ImagePicker().pickImage(source: source);
    safeNotify();
  }

  void getUserData() {
    final UserModel? user = UserRepository().getUser();
    userName = user?.name ?? "";
    countryName = user?.countryName;
    countryCode = user?.countryCode;

    safeNotify();
  }

  Future<void> saveCountry(Country selectedCountry) async {
    await UserRepository().updateUser(
      countryName: selectedCountry.name,
      countryCode: selectedCountry.countryCode,
    );

    countryName = selectedCountry.name;
    countryCode = selectedCountry.countryCode;
    safeNotify();
  }
}
