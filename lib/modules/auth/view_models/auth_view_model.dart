import 'dart:developer';

import 'package:aleef/modules/auth/models/governorates_model.dart';
import 'package:aleef/modules/auth/models/cities_model.dart';
import 'package:flutter/material.dart';

import '../models/auth_model.dart';
import '../repository/auth_repository_interface.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthRepositoryInterface repository;
  AuthModel? user;
  AuthViewModel(this.repository);

  String? token;

  Future<AuthModel?> login(String phone) async {
    user = await repository.login(phone);
    log('user: ${user?.toJson()}');
    return user;
  }

  Future<Map<String, dynamic>> register(Map<String, dynamic> data) async {
    final response = await repository.register(data);
    log('response: $response');
    return response;
  }

  Future<Map<String, dynamic>> verifyOtp(String phone, String otp) async {
    final response = await repository.verifyOtp(phone, otp);
    log('verifyOtp response: $response');
    token = response['data']['token'];
    log('token: $token');
    return response;
  }

  Future<GovernoratesResponse> getGovernorates() async {
    final response = await repository.getGovernorates();
    log('getGovernorates response: $response');
    return response;
  }

  Future<CitiesResponse> getCities(int governorateId) async {
    final response = await repository.getCities(governorateId);
    log('getCities response: $response');
    return response;
  }

  void logout() async {
    await repository.logout();
    user = null;
  }
}
