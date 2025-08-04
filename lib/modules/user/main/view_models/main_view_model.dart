import 'package:flutter/material.dart';
import '../models/main_model.dart';
import '../repository/main_repository_interface.dart';

class MainViewModel extends ChangeNotifier {
  final MainRepositoryInterface _repository;
  
  MainViewModel(this._repository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<MainModel> _mainData = [];
  List<MainModel> get mainData => _mainData;

  String? _error;
  String? get error => _error;

  Future<void> loadMainData() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      _mainData = await _repository.getMainData();
      
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