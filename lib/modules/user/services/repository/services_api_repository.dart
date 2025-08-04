import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../shared/routes/api_routes.dart';
import '../models/service_model.dart';
import 'services_repository_interface.dart';

class ServicesApiRepository implements ServicesRepositoryInterface {
  final http.Client _client;

  ServicesApiRepository({http.Client? client}) : _client = client ?? http.Client();

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
          // Add authorization header if needed
          // 'Authorization': 'Bearer $token',
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
          // Add authorization header if needed
          // 'Authorization': 'Bearer $token',
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
          // Add authorization header if needed
          // 'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode != 201) {
        throw Exception('Failed to book service: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error booking service: $e');
    }
  }
} 