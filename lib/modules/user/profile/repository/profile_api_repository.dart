import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import '../../../../shared/routes/api_routes.dart';
import '../../../../shared/constants/app_constants.dart';
import '../models/profile_model.dart';
import '../models/profile_response_model.dart';
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

      // Build FormData for multipart request
      final formData = FormData();

      // Add all available text fields
      if (profile.firstName != null && profile.firstName!.isNotEmpty) {
        formData.fields.add(MapEntry('first_name', profile.firstName!));
      }
      if (profile.lastName != null && profile.lastName!.isNotEmpty) {
        formData.fields.add(MapEntry('last_name', profile.lastName!));
      }
      if (profile.phone != null && profile.phone!.isNotEmpty) {
        formData.fields.add(MapEntry('phone', profile.phone!));
      }
      if (profile.email != null && profile.email!.isNotEmpty) {
        formData.fields.add(MapEntry('email', profile.email!));
      }
      if (profile.gender != null && profile.gender!.isNotEmpty) {
        formData.fields.add(MapEntry('gender', profile.gender!));
      }
      if (profile.address != null && profile.address!.isNotEmpty) {
        formData.fields.add(MapEntry('address', profile.address!));
      }
      if (profile.city != null && profile.city!.isNotEmpty) {
        formData.fields.add(MapEntry('city', profile.city!));
      }
      if (profile.country != null && profile.country!.isNotEmpty) {
        formData.fields.add(MapEntry('country', profile.country!));
      }
      if (profile.dateOfBirth != null) {
        formData.fields.add(
          MapEntry('date_of_birth', profile.dateOfBirth!.toIso8601String()),
        );
      }

      // Optional avatar file (if avatar contains a local file path)
      if (profile.avatar != null && profile.avatar!.isNotEmpty) {
        final filePath = profile.avatar!;
        final file = File(filePath);
        if (await file.exists()) {
          formData.files.add(
            MapEntry('avatar', await MultipartFile.fromFile(filePath)),
          );
        }
      }
      log('formData: $formData');
      log('${ApiRoutes.baseUrlApi}${ApiRoutes.profile}');
      final response = await _dio.put(
        'https://aleef.meetsyourneed.com/api/profile',
        data: formData,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
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
}
