import 'pagination_model.dart';
import 'doctor_model.dart';

class DoctorsResponse {
  final String status;
  final String message;
  final DoctorsData data;

  DoctorsResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory DoctorsResponse.fromJson(Map<String, dynamic> json) {
    return DoctorsResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: DoctorsData.fromJson(json['data'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'message': message, 'data': data.toJson()};
  }
}

class DoctorsData {
  final List<DoctorModel> items;
  final PaginationModel pagination;

  DoctorsData({required this.items, required this.pagination});

  factory DoctorsData.fromJson(Map<String, dynamic> json) {
    return DoctorsData(
      items:
          (json['items'] as List<dynamic>?)
              ?.map((item) => DoctorModel.fromJson(item))
              .toList() ??
          [],
      pagination: PaginationModel.fromJson(json['pagination'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'items': items.map((item) => item.toJson()).toList(),
      'pagination': pagination.toJson(),
    };
  }
}
