import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showToast({required String title, bool status = false}) {
  Get.showSnackbar(GetSnackBar(
    duration: Duration(seconds: 3),
    message: title,
    backgroundColor: status ? Colors.green : Colors.red,
  ));
}