class MainModel {
  final String? id;
  final String? title;
  final String? description;
  final String? type;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  MainModel({
    this.id,
    this.title,
    this.description,
    this.type,
    this.createdAt,
    this.updatedAt,
  });

  factory MainModel.fromJson(Map<String, dynamic> json) {
    return MainModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      type: json['type'],
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
      'title': title,
      'description': description,
      'type': type,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
} 