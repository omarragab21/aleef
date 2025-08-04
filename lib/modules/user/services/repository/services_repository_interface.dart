import '../models/service_model.dart';

abstract class ServicesRepositoryInterface {
  Future<List<ServiceModel>> getServices({String? category});
  Future<List<ServiceModel>> searchServices(String query);
  Future<void> bookService(String serviceId);
} 