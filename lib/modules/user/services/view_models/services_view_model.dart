import 'dart:developer';

import 'package:flutter/material.dart';
import '../models/doctor_model.dart';
import '../models/product_model.dart';
import '../models/category_model.dart';
import '../models/appointment_model.dart';
import '../repository/services_repository_interface.dart';
import '../repository/animal_repo.dart';
import '../models/pet_model.dart';

class ServicesViewModel extends ChangeNotifier {
  final ServicesRepositoryInterface _repository;
  final AnimalRepo _animalRepo;

  ServicesViewModel(this._repository, this._animalRepo);

  List<PetModel> _pets = [];
  List<PetModel> get pets => _pets;

  List<DoctorModel> _doctors = [];
  List<DoctorModel> get doctors => _doctors;

  bool _isLoadingDoctors = false;
  bool get isLoadingDoctors => _isLoadingDoctors;

  String? _doctorsError;
  String? get doctorsError => _doctorsError;

  List<ProductModel> _products = [];
  List<ProductModel> get products => _products;

  bool _isLoadingProducts = false;
  bool get isLoadingProducts => _isLoadingProducts;

  String? _productsError;
  String? get productsError => _productsError;

  List<CategoryModel> _categories = [];
  List<CategoryModel> get categories => _categories;

  bool _isLoadingCategories = false;
  bool get isLoadingCategories => _isLoadingCategories;

  String? _categoriesError;
  String? get categoriesError => _categoriesError;

  List<ProductModel> _categoryProducts = [];
  List<ProductModel> get categoryProducts => _categoryProducts;

  bool _isLoadingCategoryProducts = false;
  bool get isLoadingCategoryProducts => _isLoadingCategoryProducts;

  String? _categoryProductsError;
  String? get categoryProductsError => _categoryProductsError;

  // Available Appointments
  List<AvailableAppointmentModel> _availableAppointments = [];
  List<AvailableAppointmentModel> get availableAppointments =>
      _availableAppointments;

  bool _isLoadingAppointments = false;
  bool get isLoadingAppointments => _isLoadingAppointments;

  String? _appointmentsError;
  String? get appointmentsError => _appointmentsError;

  int? _selectedDoctorId;
  int? get selectedDoctorId => _selectedDoctorId;

  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  double? _minPrice;
  double? get minPrice => _minPrice;

  double? _maxPrice;
  double? get maxPrice => _maxPrice;

  Future<void> getPetsData() async {
    final pets = await _animalRepo.getPets();
    print(pets);
    _pets = pets.data.items;
    notifyListeners();
  }

  Future<void> getDoctors({
    int page = 1,
    int perPage = 10,
    int? governorateId,
    int? specialtyId,
    String type = 'normal',
  }) async {
    _isLoadingDoctors = true;
    _doctorsError = null;
    notifyListeners();

    try {
      final doctorsResponse = await _repository.getDoctors(
        page: page,
        perPage: perPage,
        governorateId: governorateId,
        specialtyId: specialtyId,
        type: type,
      );

      _doctors = doctorsResponse.data.items;
      _doctorsError = null;
    } catch (e) {
      _doctorsError = e.toString();
      _doctors = [];
    } finally {
      _isLoadingDoctors = false;
      notifyListeners();
    }
  }

  Future<void> getProducts({
    int page = 1,
    int perPage = 10,
    String? search,
    double? minPrice,
    double? maxPrice,
  }) async {
    _isLoadingProducts = true;
    _productsError = null;
    notifyListeners();

    try {
      final productsResponse = await _repository.getProducts(
        page: page,
        perPage: perPage,
        search: search,
        minPrice: minPrice,
        maxPrice: maxPrice,
      );

      _products = productsResponse.data;
      _productsError = null;
    } catch (e) {
      _productsError = e.toString();
      _products = [];
    } finally {
      _isLoadingProducts = false;
      notifyListeners();
    }
  }

  Future<void> searchProducts(String query) async {
    _searchQuery = query;
    if (query.isEmpty) {
      // If search is empty, get all products
      await getProducts();
    } else {
      // Search with the query
      await getProducts(search: query);
    }
  }

  Future<void> clearSearch() async {
    _searchQuery = '';
    await getProducts();
  }

  Future<void> applyPriceFilter({double? minPrice, double? maxPrice}) async {
    _minPrice = minPrice;
    _maxPrice = maxPrice;
    await getProducts(
      search: _searchQuery.isNotEmpty ? _searchQuery : null,
      minPrice: minPrice,
      maxPrice: maxPrice,
    );
  }

  Future<void> clearPriceFilter() async {
    _minPrice = null;
    _maxPrice = null;
    await getProducts(search: _searchQuery.isNotEmpty ? _searchQuery : null);
  }

  Future<void> getCategoryProducts({
    int page = 1,
    int perPage = 10,
    required int categoryId,
    String? search,
    double? minPrice,
    double? maxPrice,
  }) async {
    _isLoadingCategoryProducts = true;
    _categoryProductsError = null;
    notifyListeners();

    try {
      final productsResponse = await _repository.getProducts(
        page: page,
        perPage: perPage,
        categoryId: categoryId,
        search: search,
        minPrice: minPrice,
        maxPrice: maxPrice,
      );

      _categoryProducts = productsResponse.data;
      _categoryProductsError = null;
    } catch (e) {
      _categoryProductsError = e.toString();
      _categoryProducts = [];
    } finally {
      _isLoadingCategoryProducts = false;
      notifyListeners();
    }
  }

  Future<void> searchCategoryProducts(String query, int categoryId) async {
    _searchQuery = query;
    if (query.isEmpty) {
      // If search is empty, get all category products
      await getCategoryProducts(categoryId: categoryId);
    } else {
      // Search with the query
      await getCategoryProducts(categoryId: categoryId, search: query);
    }
  }

  Future<void> applyCategoryPriceFilter({
    required int categoryId,
    double? minPrice,
    double? maxPrice,
  }) async {
    _minPrice = minPrice;
    _maxPrice = maxPrice;
    await getCategoryProducts(
      categoryId: categoryId,
      search: _searchQuery.isNotEmpty ? _searchQuery : null,
      minPrice: minPrice,
      maxPrice: maxPrice,
    );
  }

  Future<void> clearCategoryPriceFilter(int categoryId) async {
    _minPrice = null;
    _maxPrice = null;
    await getCategoryProducts(
      categoryId: categoryId,
      search: _searchQuery.isNotEmpty ? _searchQuery : null,
    );
  }

  Future<void> getCategories({int page = 1, int perPage = 10}) async {
    _isLoadingCategories = true;
    _categoriesError = null;
    notifyListeners();

    try {
      final categoriesResponse = await _repository.getCategories(
        page: page,
        perPage: perPage,
      );

      _categories = categoriesResponse.data.items;
      _categoriesError = null;
    } catch (e) {
      _categoriesError = e.toString();
      _categories = [];
    } finally {
      _isLoadingCategories = false;
      notifyListeners();
    }
  }

  Future<void> getAvailableAppointments({
    required int doctorId,
    int page = 1,
    int perPage = 10,
  }) async {
    _isLoadingAppointments = true;
    _appointmentsError = null;
    _selectedDoctorId = doctorId;
    notifyListeners();

    try {
      final appointmentsResponse = await _repository.getAvailableAppointments(
        doctorId: doctorId,
        page: page,
        perPage: perPage,
      );
      log('appointmentsResponse: ${appointmentsResponse.toJson()}');

      _availableAppointments = appointmentsResponse.data.items;
      _appointmentsError = null;
    } catch (e) {
      _appointmentsError = e.toString();
      _availableAppointments = [];
    } finally {
      _isLoadingAppointments = false;
      notifyListeners();
    }
  }

  void clearAppointments() {
    _availableAppointments = [];
    _selectedDoctorId = null;
    _appointmentsError = null;
    notifyListeners();
  }

  // Reservation state
  bool _isCreatingReservation = false;
  String? _reservationError;

  bool get isCreatingReservation => _isCreatingReservation;
  String? get reservationError => _reservationError;

  Future<bool> createReservation({
    required int doctorId,
    required String reservationDate,
    required String reservationTime,
    required String type,
    required String paymentMethod,
    required int userPetId,
  }) async {
    _isCreatingReservation = true;
    _reservationError = null;
    notifyListeners();

    try {
      final response = await _repository.createReservation(
        doctorId: doctorId,
        reservationDate: reservationDate,
        reservationTime: reservationTime,
        type: type,
        paymentMethod: paymentMethod,
        userPetId: userPetId,
      );

      _isCreatingReservation = false;
      notifyListeners();

      // Check if the response indicates success
      if (response['status'] == 'success') {
        return true;
      } else {
        _reservationError =
            response['message'] ?? 'Failed to create reservation';
        notifyListeners();
        return false;
      }
    } catch (e) {
      _isCreatingReservation = false;
      _reservationError = e.toString();
      notifyListeners();
      return false;
    }
  }

  void clearReservationError() {
    _reservationError = null;
    notifyListeners();
  }
}
