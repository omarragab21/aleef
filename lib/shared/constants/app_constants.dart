import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract final class AppConstants {
  const AppConstants._();
  static final GlobalKey<NavigatorState> navState = GlobalKey<NavigatorState>();

  // API Constants
  static const String baseUrl = '';

  static late String token;

  static Future<void> tokenStatus({
    String tokenSave = '',
    String state = 'get',
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String tokenKey = 'auth_token';
    switch (state) {
      case "save":
        await prefs.setString(tokenKey, tokenSave);
        token = tokenSave;
        break;
      case "get":
        token = prefs.getString(tokenKey) ?? '';
        break;
      case "remove":
        await prefs.remove(tokenKey);
        token = '';
        break;
      default:
    }
  }
}
