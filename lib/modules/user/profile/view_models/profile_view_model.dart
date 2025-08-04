import 'package:flutter/material.dart';
import '../models/profile_model.dart';
import '../repository/profile_repository_interface.dart';

class ProfileViewModel extends ChangeNotifier {
  final ProfileRepositoryInterface _repository;
  
  ProfileViewModel(this._repository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  ProfileModel? _profile;
  ProfileModel? get profile => _profile;

  String? _error;
  String? get error => _error;

  Future<void> loadProfile() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      _profile = await _repository.getProfile();
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> updateProfile(ProfileModel profile) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      _profile = await _repository.updateProfile(profile);
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> updateProfileImage(String imagePath) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      _profile = await _repository.updateProfileImage(imagePath);
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> logout() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await _repository.logout();
      _profile = null;
      
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