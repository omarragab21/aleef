import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../shared/routes/api_routes.dart';
import '../models/animal_model.dart';
import 'animals_repository_interface.dart';

class AnimalsApiRepository implements AnimalsRepositoryInterface {
  final http.Client _client;

  AnimalsApiRepository({http.Client? client}) : _client = client ?? http.Client();

  @override
  Future<List<AnimalModel>> getAnimals() async {
    try {
      final response = await _client.get(
        Uri.parse('${ApiRoutes.baseUrl}${ApiRoutes.animals}'),
        headers: {
          'Content-Type': 'application/json',
          // Add authorization header if needed
          // 'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((json) => AnimalModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load animals: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error loading animals: $e');
    }
  }

  @override
  Future<AnimalModel> addAnimal(AnimalModel animal) async {
    try {
      final response = await _client.post(
        Uri.parse('${ApiRoutes.baseUrl}${ApiRoutes.animals}'),
        headers: {
          'Content-Type': 'application/json',
          // Add authorization header if needed
          // 'Authorization': 'Bearer $token',
        },
        body: json.encode(animal.toJson()),
      );

      if (response.statusCode == 201) {
        return AnimalModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to add animal: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error adding animal: $e');
    }
  }

  @override
  Future<AnimalModel> updateAnimal(AnimalModel animal) async {
    try {
      final response = await _client.put(
        Uri.parse('${ApiRoutes.baseUrl}${ApiRoutes.animals}/${animal.id}'),
        headers: {
          'Content-Type': 'application/json',
          // Add authorization header if needed
          // 'Authorization': 'Bearer $token',
        },
        body: json.encode(animal.toJson()),
      );

      if (response.statusCode == 200) {
        return AnimalModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to update animal: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error updating animal: $e');
    }
  }

  @override
  Future<void> deleteAnimal(String animalId) async {
    try {
      final response = await _client.delete(
        Uri.parse('${ApiRoutes.baseUrl}${ApiRoutes.animals}/$animalId'),
        headers: {
          'Content-Type': 'application/json',
          // Add authorization header if needed
          // 'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode != 204) {
        throw Exception('Failed to delete animal: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error deleting animal: $e');
    }
  }
} 