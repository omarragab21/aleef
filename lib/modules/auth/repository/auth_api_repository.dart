import 'auth_repository_interface.dart';
import '../models/auth_model.dart';

class AuthApiRepository implements AuthRepositoryInterface {
  @override
  Future<AuthModel?> login(String email, String password) async {
    // TODO: Implement API call
    return AuthModel(id: '1', email: email);
  }

  @override
  Future<void> logout() async {
    // TODO: Implement logout logic
  }
}
