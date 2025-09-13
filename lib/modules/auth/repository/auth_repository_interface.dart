import '../models/auth_model.dart';
import '../models/governorates_model.dart';
import '../models/cities_model.dart';

abstract class AuthRepositoryInterface {
  Future<Map<String, dynamic>> register(Map<String, dynamic> data);
  Future<AuthModel?> login(String phone);
  Future<Map<String, dynamic>> verifyOtp(String phone, String otp);
  Future<GovernoratesResponse> getGovernorates();
  Future<CitiesResponse> getCities(int governorateId);
  Future<void> logout();
}
