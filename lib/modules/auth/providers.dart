import 'package:provider/provider.dart';
import 'repository/auth_api_repository.dart';
import 'view_models/auth_view_model.dart';

final authProviders = [
  Provider(create: (_) => AuthApiRepository()),
  ProxyProvider<AuthApiRepository, AuthViewModel>(
    update: (_, repo, __) => AuthViewModel(repo),
  ),
];
