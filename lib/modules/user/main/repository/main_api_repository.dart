import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../shared/routes/api_routes.dart';
import '../models/main_model.dart';
import 'main_repository_interface.dart';

class MainApiRepository implements MainRepositoryInterface {
  final http.Client _client;

  MainApiRepository({http.Client? client}) : _client = client ?? http.Client();

  @override
  Future<List<MainModel>> getMainData() async {
    try {
      final response = await _client.get(
        Uri.parse('${ApiRoutes.baseUrl}${ApiRoutes.mainData}'),
        headers: {
          'Content-Type': 'application/json',
          // Add authorization header if needed
          // 'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((json) => MainModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load main data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error loading main data: $e');
    }
  }
}
