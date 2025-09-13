import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'repository/animals_api_repository.dart';
import 'repository/animals_repository_interface.dart';
import 'view_models/animals_view_model.dart';
import '../../auth/view_models/auth_view_model.dart';

List<SingleChildWidget> animalsProviders = [
  Provider<AnimalsRepositoryInterface>(
    create: (context) =>
        AnimalsApiRepository(token: context.read<AuthViewModel>().token),
  ),
  ChangeNotifierProvider<AnimalsViewModel>(
    create: (context) =>
        AnimalsViewModel(context.read<AnimalsRepositoryInterface>()),
  ),
];
