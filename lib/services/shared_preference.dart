import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Preferances {
  static SharedPreferences? prefe;
  static const String keyPermission = "Permission";

  ///------------------SET DATA ----------------///
  static Future<void> setString(String key, value) async {
    prefe = await SharedPreferences.getInstance();
    prefe?.setString(key, jsonEncode(value));
  }

  ///------------------GET DATA ----------------///
  static Future<String?> getString(String key) async {
    prefe = await SharedPreferences.getInstance();
    if (prefe?.getString(key) != null) {
      return prefe?.getString(key);
    } else {
      return null;
    }
  }

  //bool
  static Future prefSetBool(String key, bool value) async {
    prefe = await SharedPreferences.getInstance();
    prefe!.setBool(key, value);
  }

  static Future<bool?> prefGetBool(String key, bool boolDef) async {
    prefe = await SharedPreferences.getInstance();
    if (prefe!.getBool(key) != null) {
      return prefe!.getBool(key);
    } else {
      return boolDef;
    }
  }

  static Future<String> prefGetString(String key, String strDef) async {
    prefe = await SharedPreferences.getInstance();
    if (prefe!.getString(key) != null) {
      return prefe!.getString(key) ?? '';
    } else {
      return strDef;
    }
  }

  ///------------------REMOVE STORE DATA ----------------///
  static Future removeStoredData(String key) async {
    prefe = await SharedPreferences.getInstance();
    if (prefe?.remove(key) != null) {
      return prefe?.remove(key);
    }
  }
}
