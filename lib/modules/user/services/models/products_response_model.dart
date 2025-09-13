import 'product_model.dart';

class ProductsResponse {
  final String status;
  final String message;
  final List<ProductModel> data;

  ProductsResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ProductsResponse.fromJson(Map<String, dynamic> json) {
    return ProductsResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data:
          (json['data'] as List<dynamic>?)
              ?.map((item) => ProductModel.fromJson(item))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data.map((item) => item.toJson()).toList(),
    };
  }
}
