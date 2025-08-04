import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'repository/home_api_repository.dart';
import 'repository/home_repository_interface.dart';
import 'view_models/home_view_model.dart';

List<SingleChildWidget> homeProviders = [
  Provider<HomeRepositoryInterface>(
    create: (context) => HomeApiRepository(),
  ),
  ChangeNotifierProvider<HomeViewModel>(
    create: (context) => HomeViewModel(
      context.read<HomeRepositoryInterface>(),
    ),
  ),
]; 