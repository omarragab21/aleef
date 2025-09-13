class CategoryModel {
  final int id;
  final String name;
  final String? description;
  final String image;

  CategoryModel({
    required this.id,
    required this.name,
    this.description,
    required this.image,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'],
      image: json['image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'description': description, 'image': image};
  }
}
