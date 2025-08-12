class ProductModel {
  final String? id;
  final String? name;
  final String? description;
  final String? category;
  final double? price;
  final String? imageUrl;
  final bool? isAvailable;
  final int? stockQuantity;
  final String? brand;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ProductModel({
    this.id,
    this.name,
    this.description,
    this.category,
    this.price,
    this.imageUrl,
    this.isAvailable,
    this.stockQuantity,
    this.brand,
    this.createdAt,
    this.updatedAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      category: json['category'],
      price: json['price']?.toDouble(),
      imageUrl: json['image_url'],
      isAvailable: json['is_available'],
      stockQuantity: json['stock_quantity'],
      brand: json['brand'],
      createdAt: json['created_at'] != null 
          ? DateTime.parse(json['created_at']) 
          : null,
      updatedAt: json['updated_at'] != null 
          ? DateTime.parse(json['updated_at']) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'category': category,
      'price': price,
      'image_url': imageUrl,
      'is_available': isAvailable,
      'stock_quantity': stockQuantity,
      'brand': brand,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
