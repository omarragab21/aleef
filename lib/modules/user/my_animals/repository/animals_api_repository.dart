import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../../../../shared/routes/api_routes.dart';
import '../../../../shared/constants/app_constants.dart';
import '../models/animal_model.dart';
import '../../services/models/pets_response_model.dart';
import 'animals_repository_interface.dart';

class AnimalsApiRepository implements AnimalsRepositoryInterface {
  final http.Client _client;
  final String? token;

  AnimalsApiRepository({http.Client? client, this.token})
    : _client = client ?? http.Client();

  @override
  Future<List<AnimalModel>> getAnimals({int page = 1, int perPage = 10}) async {
    try {
      // Get token from parameter or AppConstants

      final uri = Uri.parse('${ApiRoutes.baseUrlApi}${ApiRoutes.pets}').replace(
        queryParameters: {
          'page': page.toString(),
          'per_page': perPage.toString(),
        },
      );
      log(uri.toString());
      final response = await _client.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      log(response.body.toString());
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        final petsResponse = PetsResponse.fromJson(jsonData);

        // Convert PetModel to AnimalModel
        return petsResponse.data.items
            .map(
              (pet) => AnimalModel(
                id: pet.id.toString(),
                name: pet.name,
                type: pet.type,
                breed: pet.breed,
                age: pet.age.toString(),
                weight: pet.weight.toString(),
                imageUrl: pet.imageUrl,
                createdAt: pet.createdAt,
                updatedAt: pet.updatedAt,
              ),
            )
            .toList();
      } else {
        throw Exception('Failed to load animals: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error loading animals: $e');
    }
  }

  @override
  Future<PetsResponse> getPets({int page = 1, int perPage = 10}) async {
    try {
      // Get token from parameter or AppConstants
      final authToken = token ?? AppConstants.token;

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
          'Authorization': 'Bearer $authToken',
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

  @override
  Future<AnimalModel> addAnimal(AnimalModel animal) async {
    try {
      // Get token from parameter or AppConstants
      final authToken = token ?? AppConstants.token;

      final response = await _client.post(
        Uri.parse('${ApiRoutes.baseUrlApi}${ApiRoutes.animals}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken',
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
      // Get token from parameter or AppConstants
      final authToken = token ?? AppConstants.token;

      final response = await _client.put(
        Uri.parse('${ApiRoutes.baseUrlApi}${ApiRoutes.animals}/${animal.id}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken',
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
      // Get token from parameter or AppConstants
      final authToken = token ?? AppConstants.token;

      final response = await _client.delete(
        Uri.parse('${ApiRoutes.baseUrlApi}${ApiRoutes.animals}/$animalId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken',
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
