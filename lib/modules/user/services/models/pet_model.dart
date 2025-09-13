class PetModel {
  final String? id;
  final String? name;
  final String? type;
  final String? breed;
  final String? age;
  final String? weight;
  final String? imageUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  PetModel({
    this.id,
    this.name,
    this.type,
    this.breed,
    this.age,
    this.weight,
    this.imageUrl,
    this.createdAt,
    this.updatedAt,
  });

  factory PetModel.fromJson(Map<String, dynamic> json) {
    return PetModel(
      id: json['id']?.toString(),
      name: json['name'],
      type: json['type'],
      breed: json['breed'],
      age: json['age']?.toString(),
      weight: json['weight']?.toString(),
      imageUrl: json['image_url'],
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
      'type': type,
      'breed': breed,
      'age': age,
      'weight': weight,
      'image_url': imageUrl,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
