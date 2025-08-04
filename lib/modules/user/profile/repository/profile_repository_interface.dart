import '../models/profile_model.dart';

abstract class ProfileRepositoryInterface {
  Future<ProfileModel> getProfile();
  Future<ProfileModel> updateProfile(ProfileModel profile);
  Future<ProfileModel> updateProfileImage(String imagePath);
  Future<void> logout();
}
