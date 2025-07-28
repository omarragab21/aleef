import '../models/auth_model.dart';

abstract class AuthRepositoryInterface {
  Future<AuthModel?> login(String email, String password);
  Future<void> logout();
}
