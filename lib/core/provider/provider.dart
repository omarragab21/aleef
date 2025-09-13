import '../../../modules/auth/providers.dart';
import '../../../modules/user/home/providers.dart';
import '../../../modules/user/my_animals/providers.dart';
import '../../../modules/user/profile/providers.dart';
import '../../../modules/user/services/providers.dart';
import '../../../modules/user/main/providers.dart';

final List provider = [
  ...authProviders,
  ...homeProviders,
  ...animalsProviders,
  ...servicesProviders,
  ...mainProviders,
  ...profileProviders,
];
