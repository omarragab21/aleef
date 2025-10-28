import 'dart:convert';

class AvailableSlotModel {
  final String time;

  AvailableSlotModel({required this.time});

  factory AvailableSlotModel.fromJson(Map<String, dynamic> json) {
    return AvailableSlotModel(time: json['time']?.toString() ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'time': time};
  }
}

class AvailableAppointmentModel {
  final String date;
  final String dateDisplay;
  final String day;
  final String startTime;
  final String endTime;
  final int appointmentDuration;
  final List<AvailableSlotModel> availableSlots;

  AvailableAppointmentModel({
    required this.date,
    required this.dateDisplay,
    required this.day,
    required this.startTime,
    required this.endTime,
    required this.appointmentDuration,
    required this.availableSlots,
  });

  factory AvailableAppointmentModel.fromJson(Map<String, dynamic> json) {
    List<AvailableSlotModel> slots = [];
    if (json['available_slots'] is List) {
      try {
        slots = (json['available_slots'] as List)
            .map((item) {
              if (item is Map<String, dynamic>) {
                return AvailableSlotModel.fromJson(item);
              } else if (item is String) {
                // Handle case where slot is just a string
                return AvailableSlotModel(time: item);
              }
              return null;
            })
            .where((item) => item != null)
            .cast<AvailableSlotModel>()
            .toList();
      } catch (e) {
        print('Error parsing available slots: $e');
        slots = [];
      }
    }

    return AvailableAppointmentModel(
      date: json['date']?.toString() ?? '',
      dateDisplay: json['date_display']?.toString() ?? '',
      day: json['day']?.toString() ?? '',
      startTime: json['start_time']?.toString() ?? '',
      endTime: json['end_time']?.toString() ?? '',
      appointmentDuration: json['appointment_duration'] is int
          ? json['appointment_duration']
          : int.tryParse(json['appointment_duration']?.toString() ?? '0') ?? 0,
      availableSlots: slots,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'date_display': dateDisplay,
      'day': day,
      'start_time': startTime,
      'end_time': endTime,
      'appointment_duration': appointmentDuration,
      'available_slots': availableSlots.map((slot) => slot.toJson()).toList(),
    };
  }
}

class AvailableAppointmentsResponse {
  final String status;
  final String message;
  final AvailableAppointmentsData data;

  AvailableAppointmentsResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory AvailableAppointmentsResponse.fromJson(Map<String, dynamic> json) {
    // Handle case where data might be a string or null
    Map<String, dynamic> dataJson = {};
    if (json['data'] is Map<String, dynamic>) {
      dataJson = json['data'] as Map<String, dynamic>;
    } else if (json['data'] is String) {
      // If data is a string, try to parse it as JSON
      try {
        dataJson = Map<String, dynamic>.from(
          jsonDecode(json['data'] as String),
        );
      } catch (e) {
        print('Error parsing data string: $e');
        dataJson = {};
      }
    }

    return AvailableAppointmentsResponse(
      status: json['status']?.toString() ?? '',
      message: json['message']?.toString() ?? '',
      data: AvailableAppointmentsData.fromJson(dataJson),
    );
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'message': message, 'data': data.toJson()};
  }
}

class AvailableAppointmentsData {
  final List<AvailableAppointmentModel> items;
  final PaginationModel pagination;

  AvailableAppointmentsData({required this.items, required this.pagination});

  factory AvailableAppointmentsData.fromJson(Map<String, dynamic> json) {
    List<AvailableAppointmentModel> appointments = [];
    if (json['items'] is List) {
      try {
        appointments = (json['items'] as List)
            .map((item) {
              if (item is Map<String, dynamic>) {
                return AvailableAppointmentModel.fromJson(item);
              }
              return null;
            })
            .where((item) => item != null)
            .cast<AvailableAppointmentModel>()
            .toList();
      } catch (e) {
        print('Error parsing appointments: $e');
        appointments = [];
      }
    }

    return AvailableAppointmentsData(
      items: appointments,
      pagination: PaginationModel.fromJson(json['pagination'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'items': items.map((item) => item.toJson()).toList(),
      'pagination': pagination.toJson(),
    };
  }
}

class PaginationModel {
  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;
  final bool hasMorePages;

  PaginationModel({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
    required this.hasMorePages,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) {
    return PaginationModel(
      currentPage: json['current_page'] is int
          ? json['current_page']
          : int.tryParse(json['current_page']?.toString() ?? '1') ?? 1,
      lastPage: json['last_page'] is int
          ? json['last_page']
          : int.tryParse(json['last_page']?.toString() ?? '1') ?? 1,
      perPage: json['per_page'] is int
          ? json['per_page']
          : int.tryParse(json['per_page']?.toString() ?? '10') ?? 10,
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

// Model for booked appointments (used in MyAppointmentsScreen)
class AppointmentModel {
  final String id;
  final String? doctorName;
  final String? doctorSpecialty;
  final String? doctorImageUrl;
  final DateTime appointmentDate;
  final String appointmentTime;
  final String? consultationType;
  final double consultationPrice;
  final String status;

  AppointmentModel({
    required this.id,
    this.doctorName,
    this.doctorSpecialty,
    this.doctorImageUrl,
    required this.appointmentDate,
    required this.appointmentTime,
    this.consultationType,
    required this.consultationPrice,
    required this.status,
  });

  String get formattedDate {
    return '${appointmentDate.day}/${appointmentDate.month}/${appointmentDate.year}';
  }

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      id: json['id']?.toString() ?? '',
      doctorName: json['doctor_name']?.toString(),
      doctorSpecialty: json['doctor_specialty']?.toString(),
      doctorImageUrl: json['doctor_image_url']?.toString(),
      appointmentDate:
          DateTime.tryParse(json['appointment_date']?.toString() ?? '') ??
          DateTime.now(),
      appointmentTime: json['appointment_time']?.toString() ?? '',
      consultationType: json['consultation_type']?.toString(),
      consultationPrice: (json['consultation_price'] is num)
          ? (json['consultation_price'] as num).toDouble()
          : double.tryParse(json['consultation_price']?.toString() ?? '0') ??
                0.0,
      status: json['status']?.toString() ?? 'pending',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'doctor_name': doctorName,
      'doctor_specialty': doctorSpecialty,
      'doctor_image_url': doctorImageUrl,
      'appointment_date': appointmentDate.toIso8601String(),
      'appointment_time': appointmentTime,
      'consultation_type': consultationType,
      'consultation_price': consultationPrice,
      'status': status,
    };
  }
}
