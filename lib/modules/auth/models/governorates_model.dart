class Governorate {
  final int id;
  final String name;

  Governorate({required this.id, required this.name});

  factory Governorate.fromJson(Map<String, dynamic> json) {
    return Governorate(id: json['id'] ?? 0, name: json['name'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }

  @override
  String toString() {
    return 'Governorate(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Governorate && other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}

class GovernoratesResponse {
  final String status;
  final String message;
  final List<Governorate> data;

  GovernoratesResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GovernoratesResponse.fromJson(Map<String, dynamic> json) {
    return GovernoratesResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data:
          (json['data'] as List<dynamic>?)
              ?.map(
                (item) => Governorate.fromJson(item as Map<String, dynamic>),
              )
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data.map((governorate) => governorate.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'GovernoratesResponse(status: $status, message: $message, data: $data)';
  }
}
