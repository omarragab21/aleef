class ProductModel {
  final int id;
  final String name;
  final String price;
  final String image;
  final bool hasVariants;
  final String? description;
  final String? category;
  final String? brand;
  final bool? isAvailable;
  final int? stockQuantity;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.hasVariants,
    this.description,
    this.category,
    this.brand,
    this.isAvailable,
    this.stockQuantity,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      price: json['price'] ?? '0.00',
      image: json['image'] ?? '',
      hasVariants: json['has_variants'] ?? false,
      description: json['description'],
      category: json['category'],
      brand: json['brand'],
      isAvailable: true,
      stockQuantity: json['stockQuantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'image': image,
      'has_variants': hasVariants,
      'description': description,
      'category': category,
      'brand': brand,
      'isAvailable': isAvailable,
      'stockQuantity': stockQuantity,
    };
  }

  // Getters for backward compatibility
  String? get imageUrl => image;
}
