class ProfileModel {
  final int? id;
  final String? name;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final String? avatar;
  final String? gender;
  final String? address;
  final String? city;
  final String? country;
  final String? profileImage;
  final DateTime? dateOfBirth;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ProfileModel({
    this.id,
    this.name,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.avatar,
    this.gender,
    this.address,
    this.city,
    this.country,
    this.profileImage,
    this.dateOfBirth,
    this.createdAt,
    this.updatedAt,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'],
      name: json['name'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      phone: json['phone'],
      avatar: json['avatar'],
      gender: json['gender'],
      address: json['address'],
      city: json['city'],
      country: json['country'],
      profileImage: json['profile_image'],
      dateOfBirth: json['date_of_birth'] != null
          ? DateTime.parse(json['date_of_birth'])
          : null,
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
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone': phone,
      'avatar': avatar,
      'gender': gender,
      'address': address,
      'city': city,
      'country': country,
      'profile_image': profileImage,
      'date_of_birth': dateOfBirth?.toIso8601String(),
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  String get fullName => name ?? '${firstName ?? ''} ${lastName ?? ''}'.trim();
}
