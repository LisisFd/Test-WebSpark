import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:regexed_validator/regexed_validator.dart';

/// Controller for homeScreen with [TextField]
class HomeScreenController extends GetxController {
  /// Controller [TextField] in homeScreen
  final textController = TextEditingController();

  /// Taken from the [textController]
  RxString url = RxString('');

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }

  /// Сhecking [url] for validation
  Future<bool> checkUrl() async {
    return validator.url(url.value);
  }
}
