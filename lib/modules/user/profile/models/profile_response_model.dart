import 'profile_model.dart';

class ProfileResponse {
  final String status;
  final String? message;
  final ProfileModel data;

  ProfileResponse({required this.status, this.message, required this.data});

  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    return ProfileResponse(
      status: json['status'] ?? '',
      message: json['message'],
      data: ProfileModel.fromJson(json['data'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'message': message, 'data': data.toJson()};
  }
}
