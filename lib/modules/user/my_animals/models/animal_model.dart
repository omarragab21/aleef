class AnimalModel {
  final String? id;
  final String? name;
  final String? type;
  final String? breed;
  final String? age;
  final String? weight;
  final String? imageUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  AnimalModel({
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

  factory AnimalModel.fromJson(Map<String, dynamic> json) {
    return AnimalModel(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      breed: json['breed'],
      age: json['age'],
      weight: json['weight'],
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