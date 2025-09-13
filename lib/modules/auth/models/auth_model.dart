class AuthModel {
  final String? id;
  final String? email;
  final String? phone;
  final String? code;
  final String? status;
  final String? message;

  AuthModel({
    this.id,
    this.email,
    this.phone,
    this.status,
    this.message,
    this.code,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      id: json['data']?['id']?.toString(),
      email: json['data']?['email'],
      status: json['status'],
      message: json['message'],
      phone: json['data']?['phone'],
      code: json['data']?['otp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': {'id': id, 'email': email, 'phone': phone, 'otp': code},
      'code': code,
    };
  }

  @override
  String toString() {
    return 'AuthModel(id: $id, email: $email, status: $status, message: $message, phone: $phone, code: $code)';
  }
}
