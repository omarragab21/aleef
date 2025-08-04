import '../models/animal_model.dart';

abstract class AnimalsRepositoryInterface {
  Future<List<AnimalModel>> getAnimals();
  Future<AnimalModel> addAnimal(AnimalModel animal);
  Future<AnimalModel> updateAnimal(AnimalModel animal);
  Future<void> deleteAnimal(String animalId);
} 