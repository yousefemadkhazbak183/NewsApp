import 'package:flutter/material.dart';

mixin NotifyMixin on ChangeNotifier {
  bool isDispose = false;

  safeNotify() {
    if (!isDispose) notifyListeners();
  }

  @override
  void dispose() {
    isDispose = true;
    super.dispose();
  }
}
