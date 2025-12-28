import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/mixins/notify_mixin.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends ChangeNotifier with NotifyMixin {
  XFile? selectedImage;
  void pickImage(ImageSource source) async {
    selectedImage = await ImagePicker().pickImage(source: source);
    safeNotify();
  }
}
