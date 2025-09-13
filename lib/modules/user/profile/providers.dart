import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'repository/profile_api_repository.dart';
import 'repository/profile_repository_interface.dart';
import 'view_models/profile_view_model.dart';
import '../../auth/view_models/auth_view_model.dart';

List<SingleChildWidget> profileProviders = [
  Provider<ProfileRepositoryInterface>(
    create: (context) =>
        ProfileApiRepository(token: context.read<AuthViewModel>().token),
  ),
  ChangeNotifierProvider<ProfileViewModel>(
    create: (context) =>
        ProfileViewModel(context.read<ProfileRepositoryInterface>()),
  ),
];
