import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../../../shared/routes/api_routes.dart';
import '../models/profile_model.dart';
import 'profile_repository_interface.dart';

class ProfileApiRepository implements ProfileRepositoryInterface {
  final http.Client _client;

  ProfileApiRepository({http.Client? client}) : _client = client ?? http.Client();

  @override
  Future<ProfileModel> getProfile() async {
    try {
      final response = await _client.get(
        Uri.parse('${ApiRoutes.baseUrl}${ApiRoutes.profile}'),
        headers: {
          'Content-Type': 'application/json',
          // Add authorization header if needed
          // 'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return ProfileModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load profile: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error loading profile: $e');
    }
  }

  @override
  Future<ProfileModel> updateProfile(ProfileModel profile) async {
    try {
      final response = await _client.put(
        Uri.parse('${ApiRoutes.baseUrl}${ApiRoutes.profile}'),
        headers: {
          'Content-Type': 'application/json',
          // Add authorization header if needed
          // 'Authorization': 'Bearer $token',
        },
        body: json.encode(profile.toJson()),
      );

      if (response.statusCode == 200) {
        return ProfileModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to update profile: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error updating profile: $e');
    }
  }

  @override
  Future<ProfileModel> updateProfileImage(String imagePath) async {
    try {
      final file = File(imagePath);
      final bytes = await file.readAsBytes();
      final fileName = imagePath.split('/').last;

      final request = http.MultipartRequest(
        'POST',
        Uri.parse('${ApiRoutes.baseUrl}${ApiRoutes.profile}/image'),
      );

      request.files.add(
        http.MultipartFile.fromBytes(
          'image',
          bytes,
          filename: fileName,
        ),
      );

      // Add authorization header if needed
      // request.headers['Authorization'] = 'Bearer $token';

      final response = await _client.send(request);
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        return ProfileModel.fromJson(json.decode(responseBody));
      } else {
        throw Exception('Failed to update profile image: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error updating profile image: $e');
    }
  }

  @override
  Future<void> logout() async {
    try {
      final response = await _client.post(
        Uri.parse('${ApiRoutes.baseUrl}${ApiRoutes.userLogout}'),
        headers: {
          'Content-Type': 'application/json',
          // Add authorization header if needed
          // 'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to logout: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error logging out: $e');
    }
  }
} 