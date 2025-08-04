import 'dart:developer';

import 'package:flutter/material.dart';

import '../models/auth_model.dart';
import '../repository/auth_repository_interface.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthRepositoryInterface repository;
  AuthModel? user;

  AuthViewModel(this.repository);

  Future<void> login(String phone) async {
    user = await repository.login(phone);
    log('user: ${user?.toJson()}');
  }

  Future<Map<String, dynamic>> register(Map<String, dynamic> data) async {
    final response = await repository.register(data);
    log('response: $response');
    return response;
  }

  void logout() async {
    await repository.logout();
    user = null;
  }
}
