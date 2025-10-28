import '../models/service_model.dart';
import '../models/doctors_response_model.dart';
import '../models/products_response_model.dart';
import '../models/categories_response_model.dart';
import '../models/appointment_model.dart';

abstract class ServicesRepositoryInterface {
  Future<List<ServiceModel>> getServices({String? category});
  Future<List<ServiceModel>> searchServices(String query);
  Future<void> bookService(String serviceId);
  Future<DoctorsResponse> getDoctors({
    int page = 1,
    int perPage = 10,
    int? governorateId,
    int? specialtyId,
    String type = 'normal',
  });
  Future<ProductsResponse> getProducts({
    int page = 1,
    int perPage = 10,
    int? categoryId,
    String? search,
    double? minPrice,
    double? maxPrice,
  });
  Future<CategoriesResponse> getCategories({int page = 1, int perPage = 10});
  Future<AvailableAppointmentsResponse> getAvailableAppointments({
    required int doctorId,
    int page = 1,
    int perPage = 10,
  });
  Future<Map<String, dynamic>> createReservation({
    required int doctorId,
    required String reservationDate,
    required String reservationTime,
    required String type,
    required String paymentMethod,
    required int userPetId,
  });
}
