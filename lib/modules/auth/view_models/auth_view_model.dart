import '../models/auth_model.dart';
import '../repository/auth_repository_interface.dart';

class AuthViewModel {
  final AuthRepositoryInterface repository;
  AuthModel? user;

  AuthViewModel(this.repository);

  Future<void> login(String email, String password) async {
    user = await repository.login(email, password);
  }

  void logout() async {
    await repository.logout();
    user = null;
  }
}
