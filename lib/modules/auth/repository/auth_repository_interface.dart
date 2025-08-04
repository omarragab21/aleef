import '../models/auth_model.dart';

abstract class AuthRepositoryInterface {
  Future<Map<String, dynamic>> register(Map<String, dynamic> data);
  Future<AuthModel?> login(String phone);
  Future<void> logout();
}
