class AppointmentModel {
  final String? id;
  final String? doctorName;
  final String? doctorSpecialty;
  final String? doctorImageUrl;
  final DateTime? appointmentDate;
  final String? appointmentTime;
  final String? consultationType;
  final double? consultationPrice;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  AppointmentModel({
    this.id,
    this.doctorName,
    this.doctorSpecialty,
    this.doctorImageUrl,
    this.appointmentDate,
    this.appointmentTime,
    this.consultationType,
    this.consultationPrice,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      id: json['id'],
      doctorName: json['doctor_name'],
      doctorSpecialty: json['doctor_specialty'],
      doctorImageUrl: json['doctor_image_url'],
      appointmentDate: json['appointment_date'] != null 
          ? DateTime.parse(json['appointment_date']) 
          : null,
      appointmentTime: json['appointment_time'],
      consultationType: json['consultation_type'],
      consultationPrice: json['consultation_price']?.toDouble(),
      status: json['status'],
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
      'doctor_name': doctorName,
      'doctor_specialty': doctorSpecialty,
      'doctor_image_url': doctorImageUrl,
      'appointment_date': appointmentDate?.toIso8601String(),
      'appointment_time': appointmentTime,
      'consultation_type': consultationType,
      'consultation_price': consultationPrice,
      'status': status,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  // Helper method to get formatted date string
  String get formattedDate {
    if (appointmentDate == null) return '';
    
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final appointmentDay = DateTime(
      appointmentDate!.year, 
      appointmentDate!.month, 
      appointmentDate!.day
    );
    
    if (appointmentDay == today) {
      return 'اليوم ${appointmentDate!.day} ${_getMonthName(appointmentDate!.month)}';
    } else if (appointmentDay == today.add(const Duration(days: 1))) {
      return 'غدا ${appointmentDate!.day} ${_getMonthName(appointmentDate!.month)}';
    } else {
      return '${_getDayName(appointmentDate!.weekday)} ${appointmentDate!.day} ${_getMonthName(appointmentDate!.month)}';
    }
  }

  String _getMonthName(int month) {
    const months = [
      '', 'يناير', 'فبراير', 'مارس', 'أبريل', 'مايو', 'يونيو',
      'يوليو', 'أغسطس', 'سبتمبر', 'أكتوبر', 'نوفمبر', 'ديسمبر'
    ];
    return months[month];
  }

  String _getDayName(int weekday) {
    const days = ['', 'الاثنين', 'الثلاثاء', 'الأربعاء', 'الخميس', 'الجمعة', 'السبت', 'الأحد'];
    return days[weekday];
  }
}
