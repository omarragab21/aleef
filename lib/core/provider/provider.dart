import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import '../../../modules/auth/providers.dart';
import '../../../modules/user/home/providers.dart';

final List provider = [...authProviders, ...homeProviders];
