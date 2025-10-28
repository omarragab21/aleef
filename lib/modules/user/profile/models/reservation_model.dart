class ProfileReservationModel {
  final int id;
  final UserModel user;
  final DoctorModel doctor;
  final PetModel pet;
  final String? address;
  final String reservationDate;
  final String reservationTime;
  final String type;
  final String status;
  final String price;
  final String paymentStatus;
  final String paymentMethod;
  final String? notes;
  final VideoCallModel? videoCall;

  ProfileReservationModel({
    required this.id,
    required this.user,
    required this.doctor,
    required this.pet,
    this.address,
    required this.reservationDate,
    required this.reservationTime,
    required this.type,
    required this.status,
    required this.price,
    required this.paymentStatus,
    required this.paymentMethod,
    this.notes,
    this.videoCall,
  });

  factory ProfileReservationModel.fromJson(Map<String, dynamic> json) {
    return ProfileReservationModel(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      user: UserModel.fromJson(json['user'] ?? {}),
      doctor: DoctorModel.fromJson(json['doctor'] ?? {}),
      pet: PetModel.fromJson(json['pet'] ?? {}),
      address: json['address'],
      reservationDate: json['reservation_date']?.toString() ?? '',
      reservationTime: json['reservation_time']?.toString() ?? '',
      type: json['type']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      price: json['price']?.toString() ?? '0.00',
      paymentStatus: json['payment_status']?.toString() ?? '',
      paymentMethod: json['payment_method']?.toString() ?? '',
      notes: json['notes'],
      videoCall: json['video_call'] != null
          ? VideoCallModel.fromJson(json['video_call'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user.toJson(),
      'doctor': doctor.toJson(),
      'pet': pet.toJson(),
      'address': address,
      'reservation_date': reservationDate,
      'reservation_time': reservationTime,
      'type': type,
      'status': status,
      'price': price,
      'payment_status': paymentStatus,
      'payment_method': paymentMethod,
      'notes': notes,
      'video_call': videoCall?.toJson(),
    };
  }
}

class UserModel {
  final int id;
  final String name;
  final String phone;

  UserModel({required this.id, required this.name, required this.phone});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      name: json['name']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'phone': phone};
  }
}

class DoctorModel {
  final int id;
  final String name;

  DoctorModel({required this.id, required this.name});

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      name: json['name']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}

class PetModel {
  final int id;
  final String name;

  PetModel({required this.id, required this.name});

  factory PetModel.fromJson(Map<String, dynamic> json) {
    return PetModel(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      name: json['name']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}

class VideoCallModel {
  final String channelName;
  final String token;
  final String? callDuration;

  VideoCallModel({
    required this.channelName,
    required this.token,
    this.callDuration,
  });

  factory VideoCallModel.fromJson(Map<String, dynamic> json) {
    return VideoCallModel(
      channelName: json['channel_name']?.toString() ?? '',
      token: json['token']?.toString() ?? '',
      callDuration: json['call_duration']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'channel_name': channelName,
      'token': token,
      'call_duration': callDuration,
    };
  }
}

class ProfileReservationsResponse {
  final String status;
  final String message;
  final List<ProfileReservationModel> data;

  ProfileReservationsResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ProfileReservationsResponse.fromJson(Map<String, dynamic> json) {
    List<ProfileReservationModel> reservations = [];

    if (json['data'] != null && json['data'] is List) {
      reservations = (json['data'] as List)
          .map((item) => ProfileReservationModel.fromJson(item))
          .toList();
    }

    return ProfileReservationsResponse(
      status: json['status']?.toString() ?? '',
      message: json['message']?.toString() ?? '',
      data: reservations,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data.map((item) => item.toJson()).toList(),
    };
  }
}
