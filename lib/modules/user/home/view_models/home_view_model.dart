import 'package:flutter/material.dart';
import '../models/home_model.dart';
import '../repository/home_repository_interface.dart';

class HomeViewModel extends ChangeNotifier {
  final HomeRepositoryInterface _repository;
  
  HomeViewModel(this._repository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<HomeModel> _homeData = [];
  List<HomeModel> get homeData => _homeData;

  String? _error;
  String? get error => _error;

  Future<void> loadHomeData() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      _homeData = await _repository.getHomeData();
      
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