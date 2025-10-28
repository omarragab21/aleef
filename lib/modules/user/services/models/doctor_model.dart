import 'dart:developer';

class SpecialtyModel {
  final int id;
  final String name;

  SpecialtyModel({required this.id, required this.name});

  factory SpecialtyModel.fromJson(Map<String, dynamic> json) {
    return SpecialtyModel(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      name: _safeStringFromJson(json['name']),
    );
  }

  static String _safeStringFromJson(dynamic value) {
    if (value == null) return '';
    if (value is String) return value;
    return value.toString();
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}

class SpaceModel {
  final int id;
  final String name;

  SpaceModel({required this.id, required this.name});

  factory SpaceModel.fromJson(Map<String, dynamic> json) {
    return SpaceModel(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      name: _safeStringFromJson(json['name']),
    );
  }

  static String _safeStringFromJson(dynamic value) {
    if (value == null) return '';
    if (value is String) return value;
    return value.toString();
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}

class ReviewModel {
  final int id;
  final String? comment;
  final double? rating;
  final String? userName;
  final String? createdAt;

  ReviewModel({
    required this.id,
    this.comment,
    this.rating,
    this.userName,
    this.createdAt,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      comment: _safeStringFromJson(json['comment']),
      rating: _safeDoubleFromJson(json['rating']),
      userName: _safeStringFromJson(json['user_name']),
      createdAt: _safeStringFromJson(json['created_at']),
    );
  }

  static String _safeStringFromJson(dynamic value) {
    if (value == null) return '';
    if (value is String) return value;
    return value.toString();
  }

  static double? _safeDoubleFromJson(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'comment': comment,
      'rating': rating,
      'user_name': userName,
      'created_at': createdAt,
    };
  }
}

class DoctorModel {
  final int id;
  final String name;
  final String? description;
  final List<SpecialtyModel> specialty;
  final List<SpaceModel> space;
  final String? image;
  final double rating;
  final int totalReviews;
  final double price;
  final List<ReviewModel> reviews;

  DoctorModel({
    required this.id,
    required this.name,
    this.description,
    required this.specialty,
    required this.space,
    this.image,
    required this.rating,
    required this.totalReviews,
    required this.price,
    required this.reviews,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    log('json: $json');

    // Parse specialty list
    List<SpecialtyModel> specialtyList = [];
    if (json['specialty'] is List) {
      specialtyList = (json['specialty'] as List)
          .map((item) => SpecialtyModel.fromJson(item))
          .toList();
    }

    // Parse space list
    List<SpaceModel> spaceList = [];
    if (json['space'] is List) {
      spaceList = (json['space'] as List)
          .map((item) => SpaceModel.fromJson(item))
          .toList();
    }

    // Parse reviews list
    List<ReviewModel> reviewsList = [];
    if (json['reviews'] is List) {
      reviewsList = (json['reviews'] as List)
          .map((item) => ReviewModel.fromJson(item))
          .toList();
    }

    return DoctorModel(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      name: _safeStringFromJson(json['name']),
      description: _safeStringFromJson(json['description']),
      specialty: specialtyList,
      space: spaceList,
      image: _safeStringFromJson(json['image']),
      rating: _safeDoubleFromJson(json['rating']) ?? 0.0,
      totalReviews: json['total_reviews'] is int
          ? json['total_reviews']
          : int.tryParse(json['total_reviews']?.toString() ?? '0') ?? 0,
      price: _safeDoubleFromJson(json['price']) ?? 0.0,
      reviews: reviewsList,
    );
  }

  static String _safeStringFromJson(dynamic value) {
    if (value == null) return '';
    if (value is String) return value;
    if (value is List && value.isNotEmpty) {
      return value.first.toString();
    }
    return value.toString();
  }

  static double? _safeDoubleFromJson(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value);
    if (value is List && value.isNotEmpty) {
      final firstValue = value.first;
      if (firstValue is double) return firstValue;
      if (firstValue is int) return firstValue.toDouble();
      if (firstValue is String) return double.tryParse(firstValue);
    }
    return null;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'specialty': specialty.map((s) => s.toJson()).toList(),
      'space': space.map((s) => s.toJson()).toList(),
      'image': image,
      'rating': rating,
      'total_reviews': totalReviews,
      'price': price,
      'reviews': reviews.map((r) => r.toJson()).toList(),
    };
  }

  // Helper getters for backward compatibility
  String get specialtyString =>
      specialty.isNotEmpty ? specialty.first.name : '';
  String get spaceString => space.isNotEmpty ? space.first.name : '';
  String get priceString => price.toString();
  int? get experience => null; // Not available in new API
  String? get location => null; // Not available in new API
  String? get phone => null; // Not available in new API
  String? get email => null; // Not available in new API
}
