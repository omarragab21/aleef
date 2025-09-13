class DoctorModel {
  final int id;
  final String name;
  final String specialty;
  final String? image;
  final String? description;
  final double? rating;
  final int? experience;
  final String? location;
  final String? phone;
  final String? price;
  final String? email;

  DoctorModel({
    required this.id,
    required this.name,
    required this.specialty,
    this.image,
    this.description,
    this.rating,
    this.experience,
    this.location,
    this.phone,
    this.price,
    this.email,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      name: _safeStringFromJson(json['name']),
      specialty: _safeStringFromJson(json['specialty']),
      image: _safeStringFromJson(json['image']),
      description: _safeStringFromJson(json['description']),
      rating: _safeDoubleFromJson(json['rating']),
      experience: json['experience'] is int
          ? json['experience']
          : int.tryParse(json['experience']?.toString() ?? ''),
      location: _safeStringFromJson(json['location']),
      phone: _safeStringFromJson(json['phone']),
      email: _safeStringFromJson(json['email']),
      price: _safeStringFromJson(json['price']),
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
      'specialty': specialty,
      'image': image,
      'description': description,
      'rating': rating,
      'experience': experience,
      'location': location,
      'phone': phone,
      'price': price,
      'email': email,
    };
  }
}
