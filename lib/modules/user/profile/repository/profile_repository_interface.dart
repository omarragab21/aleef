import '../models/profile_model.dart';
import '../models/reservation_model.dart';
import '../models/address_model.dart';

abstract class ProfileRepositoryInterface {
  Future<ProfileModel> getProfile();
  Future<ProfileModel> updateProfile(ProfileModel profile);
  Future<ProfileModel> updateProfileImage(String imagePath);
  Future<void> logout();
  Future<ProfileReservationsResponse> getReservations({
    String type = 'current',
  });
  Future<AddressApiResponse> getAddresses();
  Future<AddressModel> createAddress({
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
  });
}
