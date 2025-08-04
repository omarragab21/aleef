class ServiceModel {
  final String? id;
  final String? name;
  final String? description;
  final String? category;
  final double? price;
  final String? providerId;
  final String? providerName;
  final String? imageUrl;
  final bool? isAvailable;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ServiceModel({
    this.id,
    this.name,
    this.description,
    this.category,
    this.price,
    this.providerId,
    this.providerName,
    this.imageUrl,
    this.isAvailable,
    this.createdAt,
    this.updatedAt,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      category: json['category'],
      price: json['price']?.toDouble(),
      providerId: json['provider_id'],
      providerName: json['provider_name'],
      imageUrl: json['image_url'],
      isAvailable: json['is_available'],
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
      'provider_id': providerId,
      'provider_name': providerName,
      'image_url': imageUrl,
      'is_available': isAvailable,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
} 