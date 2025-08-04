import 'package:aleef/shared/assets/app_color.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract final class AppConstants {
  const AppConstants._();
  static final GlobalKey<NavigatorState> navState = GlobalKey<NavigatorState>();

  // API Constants
  static const String baseUrl = 'https://aleef.meetsyourneed.com/api';

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

  // Widget for a simple loading screen
  static Widget loadingScreen({String? message}) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(child: CircularProgressIndicator(color: AppColor.primary)),
    );
  }
}
