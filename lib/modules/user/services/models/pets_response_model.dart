import 'pagination_model.dart';
import 'pet_model.dart';

class PetsResponse {
  final String status;
  final String message;
  final PetsData data;

  PetsResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory PetsResponse.fromJson(Map<String, dynamic> json) {
    return PetsResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: PetsData.fromJson(json['data'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'message': message, 'data': data.toJson()};
  }
}

class PetsData {
  final List<PetModel> items;
  final PaginationModel pagination;

  PetsData({required this.items, required this.pagination});

  factory PetsData.fromJson(Map<String, dynamic> json) {
    return PetsData(
      items:
          (json['items'] as List<dynamic>?)
              ?.map((item) => PetModel.fromJson(item))
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
