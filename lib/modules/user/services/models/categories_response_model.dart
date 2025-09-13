import 'category_model.dart';
import 'pagination_model.dart';

class CategoriesResponse {
  final String status;
  final String message;
  final CategoriesData data;

  CategoriesResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CategoriesResponse.fromJson(Map<String, dynamic> json) {
    return CategoriesResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: CategoriesData.fromJson(json['data'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'message': message, 'data': data.toJson()};
  }
}

class CategoriesData {
  final List<CategoryModel> items;
  final PaginationModel pagination;

  CategoriesData({required this.items, required this.pagination});

  factory CategoriesData.fromJson(Map<String, dynamic> json) {
    return CategoriesData(
      items:
          (json['items'] as List<dynamic>?)
              ?.map((item) => CategoryModel.fromJson(item))
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
