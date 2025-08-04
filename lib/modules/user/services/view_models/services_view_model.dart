import 'package:flutter/material.dart';
import '../models/service_model.dart';
import '../repository/services_repository_interface.dart';

class ServicesViewModel extends ChangeNotifier {
  final ServicesRepositoryInterface _repository;
  
  ServicesViewModel(this._repository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<ServiceModel> _services = [];
  List<ServiceModel> get services => _services;

  String? _selectedCategory;
  String? get selectedCategory => _selectedCategory;

  String? _error;
  String? get error => _error;

  Future<void> loadServices({String? category}) async {
    try {
      _isLoading = true;
      _error = null;
      _selectedCategory = category;
      notifyListeners();

      _services = await _repository.getServices(category: category);
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> searchServices(String query) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      _services = await _repository.searchServices(query);
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> bookService(String serviceId) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await _repository.bookService(serviceId);
      
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

  void clearCategory() {
    _selectedCategory = null;
    notifyListeners();
  }
} 