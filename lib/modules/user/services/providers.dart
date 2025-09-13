import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'repository/services_api_repository.dart';
import 'repository/services_repository_interface.dart';
import 'view_models/services_view_model.dart';
import 'view_models/cart_view_model.dart';
import 'repository/animal_repo.dart';
import '../../auth/view_models/auth_view_model.dart';

List<SingleChildWidget> servicesProviders = [
  Provider<ServicesRepositoryInterface>(
    create: (context) =>
        ServicesApiRepository(token: context.read<AuthViewModel>().token),
  ),
  Provider<AnimalRepo>(
    create: (context) => AnimalRepo(token: context.read<AuthViewModel>().token),
  ),
  ChangeNotifierProvider<ServicesViewModel>(
    create: (context) => ServicesViewModel(
      context.read<ServicesRepositoryInterface>(),
      context.read<AnimalRepo>(),
    ),
  ),
  ChangeNotifierProvider<CartViewModel>(create: (context) => CartViewModel()),
];
