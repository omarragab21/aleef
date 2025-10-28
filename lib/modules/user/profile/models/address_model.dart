class AddressModel {
  final int id;
  final String? name;
  final String? building;
  final String? floor;
  final String? apartment;
  final String? street;
  final String? phone;
  final String? landmark;
  final bool isDefault;

  AddressModel({
    required this.id,
    this.name,
    this.building,
    this.floor,
    this.apartment,
    this.street,
    this.phone,
    this.landmark,
    required this.isDefault,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      name: json['name'],
      building: json['building'],
      floor: json['floor'],
      apartment: json['apartment'],
      street: json['street'],
      phone: json['phone'],
      landmark: json['landmark'],
      isDefault: json['is_default'] == true || json['is_default'] == '1',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'building': building,
      'floor': floor,
      'apartment': apartment,
      'street': street,
      'phone': phone,
      'landmark': landmark,
      'is_default': isDefault,
    };
  }

  String get displayAddress {
    List<String> parts = [];

    if (street != null && street!.isNotEmpty) {
      parts.add(street!);
    }

    if (building != null && building!.isNotEmpty) {
      parts.add('Building: $building');
    }

    if (floor != null && floor!.isNotEmpty) {
      parts.add('Floor: $floor');
    }

    if (apartment != null && apartment!.isNotEmpty) {
      parts.add('Apartment: $apartment');
    }

    if (landmark != null && landmark!.isNotEmpty) {
      parts.add('Landmark: $landmark');
    }

    return parts.join(', ');
  }
}

class AddressPaginationModel {
  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;
  final bool hasMorePages;

  AddressPaginationModel({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
    required this.hasMorePages,
  });

  factory AddressPaginationModel.fromJson(Map<String, dynamic> json) {
    return AddressPaginationModel(
      currentPage: json['current_page'] is int
          ? json['current_page']
          : int.tryParse(json['current_page']?.toString() ?? '1') ?? 1,
      lastPage: json['last_page'] is int
          ? json['last_page']
          : int.tryParse(json['last_page']?.toString() ?? '1') ?? 1,
      perPage: json['per_page'] is int
          ? json['per_page']
          : int.tryParse(json['per_page']?.toString() ?? '15') ?? 15,
      total: json['total'] is int
          ? json['total']
          : int.tryParse(json['total']?.toString() ?? '0') ?? 0,
      hasMorePages: json['has_more_pages'] == true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_page': currentPage,
      'last_page': lastPage,
      'per_page': perPage,
      'total': total,
      'has_more_pages': hasMorePages,
    };
  }
}

class AddressResponseModel {
  final List<AddressModel> items;
  final AddressPaginationModel pagination;

  AddressResponseModel({required this.items, required this.pagination});

  factory AddressResponseModel.fromJson(Map<String, dynamic> json) {
    return AddressResponseModel(
      items:
          (json['items'] as List<dynamic>?)
              ?.map(
                (item) => AddressModel.fromJson(item as Map<String, dynamic>),
              )
              .toList() ??
          [],
      pagination: AddressPaginationModel.fromJson(
        json['pagination'] as Map<String, dynamic>? ?? {},
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'items': items.map((item) => item.toJson()).toList(),
      'pagination': pagination.toJson(),
    };
  }
}

class AddressApiResponse {
  final String status;
  final String? message;
  final AddressResponseModel data;

  AddressApiResponse({required this.status, this.message, required this.data});

  factory AddressApiResponse.fromJson(Map<String, dynamic> json) {
    return AddressApiResponse(
      status: json['status'] ?? '',
      message: json['message'],
      data: AddressResponseModel.fromJson(json['data'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'message': message, 'data': data.toJson()};
  }
}
