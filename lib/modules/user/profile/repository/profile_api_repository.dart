import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import '../../../../shared/routes/api_routes.dart';
import '../../../../shared/constants/app_constants.dart';
import '../models/profile_model.dart';
import '../models/profile_response_model.dart';
import '../models/reservation_model.dart';
import '../models/address_model.dart';
import 'profile_repository_interface.dart';

class ProfileApiRepository implements ProfileRepositoryInterface {
  final Dio _dio;
  final String? token;

  ProfileApiRepository({Dio? dio, this.token}) : _dio = dio ?? Dio() {
    // Configure Dio to handle redirects and other common HTTP status codes
    _dio.options.followRedirects = true;
    _dio.options.maxRedirects = 5;
    _dio.options.validateStatus = (status) {
      return status != null &&
          status < 500; // Accept all status codes below 500
    };

    // Add interceptors for better error handling
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          log('Request: ${options.method} ${options.uri}');
          handler.next(options);
        },
        onResponse: (response, handler) {
          log('Response: ${response.statusCode} ${response.statusMessage}');
          handler.next(response);
        },
        onError: (error, handler) {
          log('Error: ${error.message}');
          if (error.response?.statusCode == 302) {
            log('Redirect detected: ${error.response?.headers['location']}');
          }
          handler.next(error);
        },
      ),
    );
  }

  @override
  Future<ProfileModel> getProfile() async {
    try {
      // Get token from AppConstants if not provided
      final authToken = token ?? AppConstants.token;

      log('${ApiRoutes.baseUrlApi}${ApiRoutes.profile}');
      final response = await _dio.get(
        '${ApiRoutes.baseUrlApi}${ApiRoutes.profile}',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $authToken',
          },
        ),
      );

      log('response: ${response.data}');
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data;
        final profileResponse = ProfileResponse.fromJson(responseData);
        if (profileResponse.status == 'success') {
          return profileResponse.data;
        } else {
          throw Exception(
            'API returned error: ${profileResponse.message ?? 'Unknown error'}',
          );
        }
      } else {
        final Map<String, dynamic> errorData = response.data;
        throw Exception(
          'Failed to load profile: ${errorData['message'] ?? 'HTTP ${response.statusCode}'}',
        );
      }
    } catch (e) {
      log('error: $e');
      throw Exception('Error loading profile: $e');
    }
  }

  @override
  Future<ProfileModel> updateProfile(ProfileModel profile) async {
    try {
      // Get token from AppConstants if not provided
      final authToken = token ?? AppConstants.token;

      // Convert profile to JSON, excluding avatar field
      Map<String, dynamic> profileJson = profile.toJson();
      profileJson.remove('avatar'); // Remove avatar from JSON body

      log('profileJson: $profileJson');
      log('${ApiRoutes.baseUrlApi}${ApiRoutes.profile}');
      final response = await _dio.put(
        'https://aleef.meetsyourneed.com/api/profile',
        data: profileJson,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $authToken',
            'Accept': 'application/json',
          },
        ),
      );

      log('response: ${response.data}');
      log('status code: ${response.statusCode}');

      // Check if response is HTML (redirect page)
      final responseData = response.data;
      if (responseData is String &&
          (responseData.trim().startsWith('<!DOCTYPE html>') ||
              responseData.trim().startsWith('<html'))) {
        throw Exception(
          'API returned HTML redirect instead of JSON. This usually means the endpoint is incorrect or authentication failed. Status: ${response.statusCode}',
        );
      }

      // Handle different status codes
      if (response.statusCode == 200 || response.statusCode == 201) {
        try {
          final Map<String, dynamic> jsonData =
              responseData is Map<String, dynamic>
              ? responseData
              : json.decode(responseData.toString());
          final profileResponse = ProfileResponse.fromJson(jsonData);
          if (profileResponse.status == 'success') {
            return profileResponse.data;
          } else {
            throw Exception(
              'API returned error: ${profileResponse.message ?? 'Unknown error'}',
            );
          }
        } catch (e) {
          throw Exception(
            'Failed to parse JSON response: $e. Response: $responseData',
          );
        }
      } else if (response.statusCode == 302) {
        throw Exception(
          'Profile update failed: Server redirected the request. This might indicate authentication issues or incorrect endpoint. Status: ${response.statusCode}',
        );
      } else if (response.statusCode == 401) {
        throw Exception(
          'Profile update failed: Unauthorized. Please check your authentication token. Status: ${response.statusCode}',
        );
      } else if (response.statusCode == 422) {
        try {
          final Map<String, dynamic> errorData =
              responseData is Map<String, dynamic>
              ? responseData
              : json.decode(responseData.toString());
          throw Exception(
            'Profile update failed: Validation error. ${errorData['message'] ?? 'Please check your input data.'}',
          );
        } catch (e) {
          throw Exception(
            'Profile update failed: Validation error. Status: ${response.statusCode}. Response: $responseData',
          );
        }
      } else {
        try {
          final Map<String, dynamic> errorData =
              responseData is Map<String, dynamic>
              ? responseData
              : json.decode(responseData.toString());
          throw Exception(
            'Failed to update profile: ${errorData['message'] ?? 'HTTP ${response.statusCode}'}',
          );
        } catch (e) {
          throw Exception(
            'Failed to update profile: HTTP ${response.statusCode}. Response: $responseData',
          );
        }
      }
    } on DioException catch (dioError) {
      log('Dio error: $dioError');
      if (dioError.response?.statusCode == 302) {
        throw Exception(
          'Profile update failed: Server redirected the request. This might indicate authentication issues or incorrect endpoint. Please check your API endpoint and authentication token.',
        );
      } else if (dioError.response?.statusCode == 401) {
        throw Exception(
          'Profile update failed: Unauthorized. Please check your authentication token.',
        );
      } else if (dioError.response?.statusCode == 422) {
        throw Exception(
          'Profile update failed: Validation error. Please check your input data.',
        );
      } else {
        throw Exception(
          'Profile update failed: ${dioError.message ?? 'Network error occurred'}',
        );
      }
    } catch (e) {
      log('error: $e');
      throw Exception('Error updating profile: $e');
    }
  }

  @override
  Future<ProfileModel> updateProfileImage(String imagePath) async {
    try {
      // Get token from AppConstants if not provided
      final authToken = token ?? AppConstants.token;

      final formData = FormData.fromMap({
        'avatar': await MultipartFile.fromFile(imagePath),
      });

      log('${ApiRoutes.baseUrlApi}${ApiRoutes.profileAvatar}');
      final response = await _dio.put(
        '${ApiRoutes.baseUrlApi}${ApiRoutes.profileAvatar}',
        data: formData,
        options: Options(headers: {'Authorization': 'Bearer $authToken'}),
      );

      log('response: ${response.data}');
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data;
        final profileResponse = ProfileResponse.fromJson(responseData);
        if (profileResponse.status == 'success') {
          return profileResponse.data;
        } else {
          throw Exception(
            'API returned error: ${profileResponse.message ?? 'Unknown error'}',
          );
        }
      } else {
        final Map<String, dynamic> errorData = response.data;
        throw Exception(
          'Failed to update profile image: ${errorData['message'] ?? 'HTTP ${response.statusCode}'}',
        );
      }
    } catch (e) {
      log('error: $e');
      throw Exception('Error updating profile image: $e');
    }
  }

  @override
  Future<void> logout() async {
    try {
      // Get token from AppConstants if not provided
      final authToken = token ?? AppConstants.token;

      log('${ApiRoutes.baseUrlApi}${ApiRoutes.userLogout}');
      final response = await _dio.post(
        '${ApiRoutes.baseUrlApi}${ApiRoutes.userLogout}',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $authToken',
          },
        ),
      );

      log('response: ${response.data}');
      if (response.statusCode == 200) {
        // Clear token from AppConstants
        await AppConstants.tokenStatus(state: 'remove');
      } else {
        final Map<String, dynamic> errorData = response.data;
        throw Exception(
          'Failed to logout: ${errorData['message'] ?? 'HTTP ${response.statusCode}'}',
        );
      }
    } catch (e) {
      log('error: $e');
      throw Exception('Error logging out: $e');
    }
  }

  @override
  Future<ProfileReservationsResponse> getReservations({
    String type = 'current',
  }) async {
    try {
      final response = await _dio.get(
        '${ApiRoutes.baseUrlApi}/profile/reservations',
        queryParameters: {'type': type},
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      log('Get reservations response status: ${response.statusCode}');
      log('Get reservations response data: ${response.data}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        return ProfileReservationsResponse.fromJson(data);
      } else {
        final Map<String, dynamic> errorData = response.data;
        throw Exception(
          'Failed to get reservations: ${errorData['message'] ?? 'HTTP ${response.statusCode}'}',
        );
      }
    } catch (e) {
      log('Error getting reservations: $e');
      throw Exception('Error getting reservations: $e');
    }
  }

  @override
  Future<AddressApiResponse> getAddresses() async {
    try {
      final response = await _dio.get(
        '${ApiRoutes.baseUrlApi}${ApiRoutes.addresses}',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      log('Get addresses response status: ${response.statusCode}');
      log('Get addresses response data: ${response.data}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        return AddressApiResponse.fromJson(data);
      } else {
        final Map<String, dynamic> errorData = response.data;
        throw Exception(
          'Failed to get addresses: ${errorData['message'] ?? 'HTTP ${response.statusCode}'}',
        );
      }
    } catch (e) {
      log('Error getting addresses: $e');
      throw Exception('Error getting addresses: $e');
    }
  }

  @override
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
  }) async {
    try {
      // Get token from AppConstants if not provided
      final authToken = token ?? AppConstants.token;

      // Create JSON body
      final Map<String, dynamic> addressData = {
        'governorate_id': governorateId,
        'state': state,
        'address': address,
        'phone': phone,
        'is_default': isDefault,
      };

      // Add optional fields only if they have values
      if (name != null && name.isNotEmpty) {
        addressData['name'] = name;
      }
      if (building != null && building.isNotEmpty) {
        addressData['building'] = building;
      }
      if (floor != null && floor.isNotEmpty) {
        addressData['floor'] = floor;
      }
      if (apartment != null && apartment.isNotEmpty) {
        addressData['apartment'] = apartment;
      }
      if (landmark != null && landmark.isNotEmpty) {
        addressData['landmark'] = landmark;
      }

      log('Creating address with data: $addressData');
      log('${ApiRoutes.baseUrlApi}${ApiRoutes.addresses}');

      final response = await _dio.post(
        '${ApiRoutes.baseUrlApi}${ApiRoutes.addresses}',
        data: addressData,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );

      log('Create address response status: ${response.statusCode}');
      log('Create address response data: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> responseData = response.data;

        // Check if response has the expected structure
        if (responseData['status'] == 'success' &&
            responseData['data'] != null) {
          return AddressModel.fromJson(responseData['data']);
        } else {
          throw Exception(
            'API returned error: ${responseData['message'] ?? 'Unknown error'}',
          );
        }
      } else {
        final Map<String, dynamic> errorData = response.data;
        throw Exception(
          'Failed to create address: ${errorData['message'] ?? 'HTTP ${response.statusCode}'}',
        );
      }
    } catch (e) {
      log('Error creating address: $e');
      throw Exception('Error creating address: $e');
    }
  }
}
