import 'package:flutter/material.dart';
import '../models/profile_model.dart';
import '../models/reservation_model.dart';
import '../models/address_model.dart';
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

  // Reservations state
  List<ProfileReservationModel> _reservations = [];
  List<ProfileReservationModel> get reservations => _reservations;

  bool _isLoadingReservations = false;
  bool get isLoadingReservations => _isLoadingReservations;

  String? _reservationsError;
  String? get reservationsError => _reservationsError;

  // Addresses state
  List<AddressModel> _addresses = [];
  List<AddressModel> get addresses => _addresses;

  bool _isLoadingAddresses = false;
  bool get isLoadingAddresses => _isLoadingAddresses;

  String? _addressesError;
  String? get addressesError => _addressesError;

  AddressPaginationModel? _addressPagination;
  AddressPaginationModel? get addressPagination => _addressPagination;

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

  Future<void> getReservations({String type = 'current'}) async {
    try {
      _isLoadingReservations = true;
      _reservationsError = null;
      notifyListeners();

      final response = await _repository.getReservations(type: type);
      _reservations = response.data;

      _isLoadingReservations = false;
      notifyListeners();
    } catch (e) {
      _isLoadingReservations = false;
      _reservationsError = e.toString();
      notifyListeners();
    }
  }

  void clearReservationsError() {
    _reservationsError = null;
    notifyListeners();
  }

  void clearReservations() {
    _reservations = [];
    _reservationsError = null;
    notifyListeners();
  }

  Future<void> getAddresses() async {
    try {
      _isLoadingAddresses = true;
      _addressesError = null;
      notifyListeners();

      final response = await _repository.getAddresses();
      _addresses = response.data.items;
      _addressPagination = response.data.pagination;

      _isLoadingAddresses = false;
      notifyListeners();
    } catch (e) {
      _isLoadingAddresses = false;
      _addressesError = e.toString();
      notifyListeners();
    }
  }

  void clearAddressesError() {
    _addressesError = null;
    notifyListeners();
  }

  void clearAddresses() {
    _addresses = [];
    _addressPagination = null;
    _addressesError = null;
    notifyListeners();
  }

  AddressModel? getDefaultAddress() {
    try {
      return _addresses.firstWhere((address) => address.isDefault);
    } catch (e) {
      return _addresses.isNotEmpty ? _addresses.first : null;
    }
  }

  Future<void> createAddress({
    required int governorateId,
    required String state,
    required String address,
    required String phone,
    String? name,
    String? building,
    String? floor,
    String? apartment,
    String? landmark,
    bool isDefault = false,
  }) async {
    try {
      _isLoadingAddresses = true;
      _addressesError = null;
      notifyListeners();

      final newAddress = await _repository.createAddress(
        governorateId: governorateId,
        state: state,
        address: address,
        phone: phone,
        name: name,
        building: building,
        floor: floor,
        apartment: apartment,
        landmark: landmark,
        isDefault: isDefault,
      );

      // Add the new address to the list
      _addresses.add(newAddress);

      _isLoadingAddresses = false;
      notifyListeners();
    } catch (e) {
      _isLoadingAddresses = false;
      _addressesError = e.toString();
      notifyListeners();
    }
  }

  Future<void> refreshAddresses() async {
    await getAddresses();
  }
}
