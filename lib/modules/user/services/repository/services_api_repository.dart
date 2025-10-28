import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../../../../shared/routes/api_routes.dart';
import '../models/service_model.dart';
import '../models/doctors_response_model.dart';
import '../models/products_response_model.dart';
import '../models/categories_response_model.dart';
import '../models/appointment_model.dart';
import 'services_repository_interface.dart';

class ServicesApiRepository implements ServicesRepositoryInterface {
  final http.Client _client;
  final String? _token;

  ServicesApiRepository({http.Client? client, String? token})
    : _client = client ?? http.Client(),
      _token = token;

  @override
  Future<List<ServiceModel>> getServices({String? category}) async {
    try {
      String url = '${ApiRoutes.baseUrl}${ApiRoutes.services}';
      if (category != null) {
        url += '?category=$category';
      }

      final response = await _client.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          if (_token != null) 'Authorization': 'Bearer $_token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((json) => ServiceModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load services: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error loading services: $e');
    }
  }

  @override
  Future<List<ServiceModel>> searchServices(String query) async {
    try {
      final response = await _client.get(
        Uri.parse('${ApiRoutes.baseUrl}${ApiRoutes.services}/search?q=$query'),
        headers: {
          'Content-Type': 'application/json',
          if (_token != null) 'Authorization': 'Bearer $_token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((json) => ServiceModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to search services: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error searching services: $e');
    }
  }

  @override
  Future<void> bookService(String serviceId) async {
    try {
      final response = await _client.post(
        Uri.parse('${ApiRoutes.baseUrl}${ApiRoutes.services}/$serviceId/book'),
        headers: {
          'Content-Type': 'application/json',
          if (_token != null) 'Authorization': 'Bearer $_token',
        },
      );

      if (response.statusCode != 201) {
        throw Exception('Failed to book service: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error booking service: $e');
    }
  }

  @override
  Future<DoctorsResponse> getDoctors({
    int page = 1,
    int perPage = 10,
    int? governorateId,
    int? specialtyId,
    String type = 'normal',
  }) async {
    try {
      final Map<String, String> queryParams = {
        'page': page.toString(),
        'per_page': perPage.toString(),
        'type': type,
      };

      if (governorateId != null) {
        queryParams['governorate_id'] = governorateId.toString();
      }

      if (specialtyId != null) {
        queryParams['specialty_id'] = specialtyId.toString();
      }

      final uri = Uri.parse(
        '${ApiRoutes.baseUrlApi}${ApiRoutes.doctors}',
      ).replace(queryParameters: queryParams);

      final response = await _client.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          if (_token != null) 'Authorization': 'Bearer $_token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        return DoctorsResponse.fromJson(jsonData);
      } else {
        throw Exception('Failed to load doctors: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error loading doctors: $e');
    }
  }

  @override
  Future<ProductsResponse> getProducts({
    int page = 1,
    int perPage = 10,
    int? categoryId,
    String? search,
    double? minPrice,
    double? maxPrice,
  }) async {
    try {
      final Map<String, String> queryParams = {
        'page': page.toString(),
        'per_page': perPage.toString(),
      };

      if (categoryId != null) {
        queryParams['category_id'] = categoryId.toString();
      }

      if (search != null && search.isNotEmpty) {
        queryParams['search'] = search;
      }

      if (minPrice != null) {
        queryParams['min_price'] = minPrice.toString();
      }

      if (maxPrice != null) {
        queryParams['max_price'] = maxPrice.toString();
      }

      final uri = Uri.parse(
        '${ApiRoutes.baseUrlApi}${ApiRoutes.products}',
      ).replace(queryParameters: queryParams);

      final response = await _client.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          if (_token != null) 'Authorization': 'Bearer $_token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        return ProductsResponse.fromJson(jsonData);
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error loading products: $e');
    }
  }

  @override
  Future<CategoriesResponse> getCategories({
    int page = 1,
    int perPage = 10,
  }) async {
    try {
      final Map<String, String> queryParams = {
        'page': page.toString(),
        'per_page': perPage.toString(),
      };

      final uri = Uri.parse(
        '${ApiRoutes.baseUrlApi}${ApiRoutes.categories}',
      ).replace(queryParameters: queryParams);

      final response = await _client.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          if (_token != null) 'Authorization': 'Bearer $_token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        return CategoriesResponse.fromJson(jsonData);
      } else {
        throw Exception('Failed to load categories: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error loading categories: $e');
    }
  }

  @override
  Future<AvailableAppointmentsResponse> getAvailableAppointments({
    required int doctorId,
    int page = 1,
    int perPage = 10,
  }) async {
    try {
      final uri = Uri.parse(
        '${ApiRoutes.baseUrlApi}/doctors/available-appointments?doctor_id=$doctorId&page=$page&per_page=$perPage',
      );

      final response = await _client.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          if (_token != null) 'Authorization': 'Bearer $_token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);

        return AvailableAppointmentsResponse.fromJson(jsonData);
      } else {
        throw Exception(
          'Failed to load available appointments: ${response.statusCode}',
        );
      }
    } catch (e) {
      log('Error loading available appointments: $e');
      throw Exception('Error loading available appointments: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> createReservation({
    required int doctorId,
    required String reservationDate,
    required String reservationTime,
    required String type,
    required String paymentMethod,
    required int userPetId,
  }) async {
    try {
      // Try the API endpoint first
      final uri = Uri.parse('${ApiRoutes.baseUrlApi}/reservations');
      log('Attempting reservation with URL: $uri');

      // Prepare JSON body
      final Map<String, dynamic> requestBody = {
        'doctor_id': '$doctorId',
        'reservation_date': '$reservationDate',
        'reservation_time': '$reservationTime',
        'type': type.toString(),
        'payment_method': paymentMethod.toString(),
        'user_pet_id': '$userPetId',
      };

      log('Creating reservation with data: $requestBody');
      log('Reservation time being sent: $reservationTime');
      log('Reservation date being sent: $reservationDate');
      log(
        'Using token: ${_token != null ? 'Token present (${_token.substring(0, 10)}...)' : 'No token'}',
      );

      final response = await _client.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $_token',
        },
        body: json.encode(requestBody),
      );

      log('Reservation response status: ${response.statusCode}');
      log('Reservation response body: ${response.body}');
      log('Reservation response headers: ${response.headers}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        try {
          final Map<String, dynamic> data = json.decode(response.body);
          return data;
        } catch (e) {
          log('Error parsing JSON response: $e');
          throw Exception('Invalid JSON response from server');
        }
      } else if (response.statusCode == 302) {
        log('Received 302 redirect. Trying alternative endpoint...');

        // Try with the other base URL as fallback
        try {
          final fallbackUri = Uri.parse('${ApiRoutes.baseUrl}/reservations');
          log('Trying fallback URL: $fallbackUri');

          final fallbackResponse = await _client.post(
            fallbackUri,
            headers: {
              'Content-Type': 'application/json',
              if (_token != null) 'Authorization': 'Bearer $_token',
            },
            body: json.encode(requestBody),
          );

          log('Fallback response status: ${fallbackResponse.statusCode}');
          log('Fallback response body: ${fallbackResponse.body}');

          if (fallbackResponse.statusCode == 200 ||
              fallbackResponse.statusCode == 201) {
            final Map<String, dynamic> data = json.decode(
              fallbackResponse.body,
            );
            return data;
          } else {
            throw Exception(
              'Both endpoints failed. Original: 302, Fallback: ${fallbackResponse.statusCode}',
            );
          }
        } catch (fallbackError) {
          log('Fallback also failed: $fallbackError');
          throw Exception(
            'Authentication failed or invalid endpoint. Please check your login status.',
          );
        }
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized. Please login again.');
      } else if (response.statusCode == 422) {
        try {
          final Map<String, dynamic> errorData = json.decode(response.body);
          final String errorMessage =
              errorData['message'] ?? 'Validation error';
          throw Exception('Validation error: $errorMessage');
        } catch (e) {
          throw Exception('Validation error: ${response.body}');
        }
      } else {
        throw Exception(
          'Failed to create reservation: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      log('Error creating reservation: $e');
      throw Exception('Error creating reservation: $e');
    }
  }
}
