import '../models/animal_model.dart';
import '../../services/models/pets_response_model.dart';

abstract class AnimalsRepositoryInterface {
  Future<List<AnimalModel>> getAnimals({int page = 1, int perPage = 10});
  Future<PetsResponse> getPets({int page = 1, int perPage = 10});
  Future<AnimalModel> addAnimal(AnimalModel animal);
  Future<AnimalModel> updateAnimal(AnimalModel animal);
  Future<void> deleteAnimal(String animalId);
}
