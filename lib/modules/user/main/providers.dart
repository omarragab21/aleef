import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'repository/main_api_repository.dart';
import 'repository/main_repository_interface.dart';
import 'view_models/main_view_model.dart';

List<SingleChildWidget> mainProviders = [
  Provider<MainRepositoryInterface>(
    create: (context) => MainApiRepository(),
  ),
  ChangeNotifierProvider<MainViewModel>(
    create: (context) => MainViewModel(
      context.read<MainRepositoryInterface>(),
    ),
  ),
]; 