import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../shared/routes/api_routes.dart';
import '../models/home_model.dart';
import 'home_repository_interface.dart';

class HomeApiRepository implements HomeRepositoryInterface {
  final http.Client _client;

  HomeApiRepository({http.Client? client}) : _client = client ?? http.Client();

  @override
  Future<List<HomeModel>> getHomeData() async {
    try {
      final response = await _client.get(
        Uri.parse('${ApiRoutes.baseUrl}${ApiRoutes.homeData}'),
        headers: {
          'Content-Type': 'application/json',
          // Add authorization header if needed
          // 'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((json) => HomeModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load home data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error loading home data: $e');
    }
  }
} 