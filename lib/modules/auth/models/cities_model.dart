class City {
  final int id;
  final String name;
  final int governorateId;

  City({required this.id, required this.name, required this.governorateId});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      governorateId: json['governorate_id'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'governorate_id': governorateId};
  }

  @override
  String toString() {
    return 'City(id: $id, name: $name, governorateId: $governorateId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is City &&
        other.id == id &&
        other.name == name &&
        other.governorateId == governorateId;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ governorateId.hashCode;
}

class CitiesResponse {
  final String status;
  final String message;
  final List<City> data;

  CitiesResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CitiesResponse.fromJson(Map<String, dynamic> json) {
    return CitiesResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data:
          (json['data'] as List<dynamic>?)
              ?.map((item) => City.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data.map((city) => city.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'CitiesResponse(status: $status, message: $message, data: $data)';
  }
}
