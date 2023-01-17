import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class CommonFunctions {
  static void toast(String info) {
    Fluttertoast.showToast(
      timeInSecForIosWeb: 1,
      msg: info,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_LONG,
    );
  }

  static Future<bool> checkConnectivity() async {
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        CommonFunctions.toast(
            "please check you mobile data or wifi connection!");
        return false;
      } else {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          return true;
        } else {
          CommonFunctions.toast(
              "please check you mobile data or wifi connection!");
          return false;
        }
      }
    } on SocketException catch (_) {
      CommonFunctions.toast("please check you mobile data or wifi connection!");
      return false;
    }
  }
}
