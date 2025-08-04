import 'package:flutter/material.dart';
import '../models/animal_model.dart';
import '../repository/animals_repository_interface.dart';

class AnimalsViewModel extends ChangeNotifier {
  final AnimalsRepositoryInterface _repository;
  
  AnimalsViewModel(this._repository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<AnimalModel> _animals = [];
  List<AnimalModel> get animals => _animals;

  String? _error;
  String? get error => _error;

  Future<void> loadAnimals() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      _animals = await _repository.getAnimals();
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> addAnimal(AnimalModel animal) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final newAnimal = await _repository.addAnimal(animal);
      _animals.add(newAnimal);
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> updateAnimal(AnimalModel animal) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final updatedAnimal = await _repository.updateAnimal(animal);
      final index = _animals.indexWhere((a) => a.id == animal.id);
      if (index != -1) {
        _animals[index] = updatedAnimal;
      }
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> deleteAnimal(String animalId) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await _repository.deleteAnimal(animalId);
      _animals.removeWhere((animal) => animal.id == animalId);
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
} 