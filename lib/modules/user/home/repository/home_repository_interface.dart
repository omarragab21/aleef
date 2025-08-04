import '../models/home_model.dart';

abstract class HomeRepositoryInterface {
  Future<List<HomeModel>> getHomeData();
} 