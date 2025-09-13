import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../shared/routes/api_routes.dart';
import '../models/service_model.dart';
import '../models/doctors_response_model.dart';
import '../models/products_response_model.dart';
import '../models/categories_response_model.dart';
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
}
