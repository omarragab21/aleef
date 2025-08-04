import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'repository/services_api_repository.dart';
import 'repository/services_repository_interface.dart';
import 'view_models/services_view_model.dart';

List<SingleChildWidget> servicesProviders = [
  Provider<ServicesRepositoryInterface>(
    create: (context) => ServicesApiRepository(),
  ),
  ChangeNotifierProvider<ServicesViewModel>(
    create: (context) => ServicesViewModel(
      context.read<ServicesRepositoryInterface>(),
    ),
  ),
]; 