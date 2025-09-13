import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'auth_repository_interface.dart';
import '../models/auth_model.dart';
import '../models/governorates_model.dart';
import '../models/cities_model.dart';
import '../../../shared/constants/app_constants.dart';
import '../../../shared/routes/api_routes.dart';

class AuthApiRepository implements AuthRepositoryInterface {
  @override
  Future<Map<String, dynamic>> register(Map<String, dynamic> data) async {
    try {
      log('${AppConstants.baseUrl}${ApiRoutes.userRegister}');
      http.Response response;

      if (data.containsKey('image') &&
          data['image'] != null &&
          data['image'].toString().isNotEmpty) {
        // If image is present, use multipart request
        var uri = Uri.parse('${AppConstants.baseUrl}${ApiRoutes.userRegister}');
        var request = http.MultipartRequest('POST', uri);

        // Use another data map for fields except image
        Map<String, dynamic> anotherData = Map.from(data);
        anotherData.remove('image');
        anotherData.forEach((key, value) {
          request.fields[key] = value.toString();
        });

        // Add image file
        var imagePath = data['image'];
        request.files.add(
          await http.MultipartFile.fromPath('image', imagePath),
        );

        // Send the request
        var streamedResponse = await request.send();
        response = await http.Response.fromStream(streamedResponse);
      } else {
        // No image, send as JSON
        response = await http.post(
          Uri.parse('${AppConstants.baseUrl}${ApiRoutes.userRegister}'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(data),
        );
      }

      log('response: ${response.body}');
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        return responseData;
      } else {
        final Map<String, dynamic> errorData = jsonDecode(response.body);
        return {
          'status': 'error',
          'message': errorData['message'] ?? 'Registration failed',
        };
      }
    } catch (e) {
      log('error: $e');
      return {'status': 'error', 'message': 'Network error: ${e.toString()}'};
    }
  }

  @override
  Future<AuthModel?> login(String phone) async {
    try {
      log('${AppConstants.baseUrl}${ApiRoutes.userLogin}');
      final response = await http.post(
        Uri.parse('${AppConstants.baseUrl}${ApiRoutes.userLogin}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'phone': phone}),
      );
      log('response: ${response.body}');
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        return AuthModel.fromJson(responseData);
      } else {
        // Handle error response
        final Map<String, dynamic> errorData = jsonDecode(response.body);
        return AuthModel(
          status: 'error',
          message: errorData['message'] ?? 'Login failed',
        );
      }
    } catch (e) {
      return AuthModel(
        status: 'error',
        message: 'Network error: ${e.toString()}',
      );
    }
  }

  @override
  Future<Map<String, dynamic>> verifyOtp(String phone, String otp) async {
    try {
      log('${AppConstants.baseUrl}${ApiRoutes.userVerifyOtp}');
      final response = await http.post(
        Uri.parse('${AppConstants.baseUrl}${ApiRoutes.userVerifyOtp}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'phone': phone, 'otp': otp}),
      );

      log('response: ${response.body}');
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        return responseData;
      } else {
        final Map<String, dynamic> errorData = jsonDecode(response.body);
        return {
          'status': 'error',
          'message': errorData['message'] ?? 'OTP verification failed',
        };
      }
    } catch (e) {
      log('error: $e');
      return {'status': 'error', 'message': 'Network error: ${e.toString()}'};
    }
  }

  @override
  Future<GovernoratesResponse> getGovernorates() async {
    try {
      log('${AppConstants.baseUrl}${ApiRoutes.governorates}');
      final response = await http.get(
        Uri.parse('${AppConstants.baseUrl}${ApiRoutes.governorates}'),
        headers: {'Content-Type': 'application/json'},
      );

      log('response: ${response.body}');
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        return GovernoratesResponse.fromJson(responseData);
      } else {
        final Map<String, dynamic> errorData = jsonDecode(response.body);
        return GovernoratesResponse(
          status: 'error',
          message: errorData['message'] ?? 'Failed to fetch governorates',
          data: [],
        );
      }
    } catch (e) {
      log('error: $e');
      return GovernoratesResponse(
        status: 'error',
        message: 'Network error: ${e.toString()}',
        data: [],
      );
    }
  }

  @override
  Future<CitiesResponse> getCities(int governorateId) async {
    try {
      final url =
          '${AppConstants.baseUrl}${ApiRoutes.cities}?governorate_id=$governorateId';
      log(url);
      final response = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      );

      log('response: ${response.body}');
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        return CitiesResponse.fromJson(responseData);
      } else {
        final Map<String, dynamic> errorData = jsonDecode(response.body);
        return CitiesResponse(
          status: 'error',
          message: errorData['message'] ?? 'Failed to fetch cities',
          data: [],
        );
      }
    } catch (e) {
      log('error: $e');
      return CitiesResponse(
        status: 'error',
        message: 'Network error: ${e.toString()}',
        data: [],
      );
    }
  }

  @override
  Future<void> logout() async {}
}
