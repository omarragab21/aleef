import '../models/main_model.dart';

abstract class MainRepositoryInterface {
  Future<List<MainModel>> getMainData();
} 