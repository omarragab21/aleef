class AuthModel {
  final String? id;
  final String? email;
  final String? phone;
  final String? status;
  final String? message;

  AuthModel({this.id, this.email, this.phone, this.status, this.message});

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      id: json['data']?['id']?.toString(),
      email: json['data']?['email'],
      status: json['status'],
      message: json['message'],
      phone: json['data']?['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': {'id': id, 'email': email, 'phone': phone},
    };
  }

  @override
  String toString() {
    return 'AuthModel(id: $id, email: $email, status: $status, message: $message, phone: $phone)';
  }
}
