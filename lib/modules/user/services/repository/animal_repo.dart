import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../../../../shared/routes/api_routes.dart';
import '../models/pets_response_model.dart';

class AnimalRepo {
  final http.Client _client;
  final String? _token;

  AnimalRepo({http.Client? client, String? token})
    : _client = client ?? http.Client(),
      _token = token;

  Future<PetsResponse> getPets({int page = 1, int perPage = 10}) async {
    try {
      log('${ApiRoutes.baseUrlApi}${ApiRoutes.pets}');
      final uri = Uri.parse('${ApiRoutes.baseUrlApi}${ApiRoutes.pets}').replace(
        queryParameters: {
          'page': page.toString(),
          'per_page': perPage.toString(),
        },
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
        return PetsResponse.fromJson(jsonData);
      } else {
        throw Exception('Failed to load pets: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error loading pets: $e');
    }
  }

  /// Get pets with custom query parameters
  ///
  /// [queryParams] - Map of query parameters to include in the request
  Future<PetsResponse> getPetsWithParams(
    Map<String, String> queryParams,
  ) async {
    try {
      final uri = Uri.parse(
        '${ApiRoutes.baseUrlApi}${ApiRoutes.pets}',
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
        return PetsResponse.fromJson(jsonData);
      } else {
        throw Exception('Failed to load pets: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error loading pets: $e');
    }
  }
}
