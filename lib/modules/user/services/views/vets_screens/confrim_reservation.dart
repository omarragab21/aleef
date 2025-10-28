import 'package:aleef/shared/assets/app_color.dart';
import 'package:aleef/modules/user/services/models/doctor_model.dart';
import 'package:aleef/modules/user/services/models/appointment_model.dart';
import 'package:aleef/modules/user/services/view_models/services_view_model.dart';
import 'package:aleef/modules/user/main/views/main_screen.dart';
import 'package:aleef/shared/routes/navigation_routes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ConfrimReservation extends StatelessWidget {
  final DoctorModel? doctor;
  final AvailableAppointmentModel? appointment;
  final AppointmentModel? myAppointment;
  final String? selectedTime;
  final String? selectedPet;
  final String? consultationType;
  final double? consultationPrice;

  const ConfrimReservation({
    super.key,
    this.doctor,
    this.appointment,
    this.myAppointment,
    this.selectedTime,
    this.selectedPet,
    this.consultationType,
    this.consultationPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'confirm_booking'.tr(),
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.close, color: AppColor.primary, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 7,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Doctor Profile Section
                  _buildDoctorProfile(),
                  const SizedBox(height: 20),

                  // Booking Details Section
                  _buildBookingDetails(),
                  const SizedBox(height: 20),

                  // Appointment Time Section
                  _buildAppointmentTime(),
                  const SizedBox(height: 20),

                  // Price Section
                  _buildPriceSection(),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: _buildConfirmButton(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmButton() {
    return Consumer<ServicesViewModel>(
      builder: (context, viewModel, child) {
        return Center(
          child: GestureDetector(
            onTap: viewModel.isCreatingReservation
                ? null
                : () => _handleConfirmBooking(context, viewModel),
            child: Container(
              width: double.infinity,
              height: 56,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: viewModel.isCreatingReservation
                    ? Colors.grey
                    : const Color(0xFF6D9773),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: viewModel.isCreatingReservation
                      ? Colors.grey
                      : const Color(0xFF6D9773),
                  width: 2,
                ),
              ),
              alignment: Alignment.center,
              child: viewModel.isCreatingReservation
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'creating_reservation'.tr(),
                          style: const TextStyle(
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                            fontSize: 20,
                            height: 1.0,
                            letterSpacing: 0,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )
                  : Text(
                      'تأكيد الحجز',
                      style: const TextStyle(
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                        fontSize: 20,
                        height: 1.0,
                        letterSpacing: 0,
                        color: Colors.white,
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _handleConfirmBooking(
    BuildContext context,
    ServicesViewModel viewModel,
  ) async {
    try {
      // Prepare reservation data
      int doctorId;
      String reservationDate;
      String reservationTime;
      String type;
      String paymentMethod = 'card'; // Default payment method
      int userPetId = 1; // Default pet ID - should be dynamic in real app

      // Get doctor ID
      if (doctor != null) {
        doctorId = doctor!.id;
      } else if (myAppointment != null) {
        // For rebooking from my appointments, we need the doctor ID
        // This should be stored in the appointment model or fetched
        doctorId = 1; // Default - should be dynamic
      } else {
        _showErrorDialog(context, 'لا يمكن تحديد الطبيب');
        return;
      }

      // Get reservation date and time
      if (selectedTime != null) {
        // From booking screen
        reservationDate = _formatDateForAPI(
          DateTime.now(),
        ); // Use current date as default
        reservationTime = _formatTimeForAPI(selectedTime!);
        type = consultationType == 'زيارة منزلية' ? 'offline' : 'online';
      } else if (myAppointment != null) {
        // From my appointments
        reservationDate = _formatDateForAPI(myAppointment!.appointmentDate);
        reservationTime = _formatTimeForAPI(myAppointment!.appointmentTime);
        type = myAppointment!.consultationType == 'زيارة منزلية'
            ? 'offline'
            : 'online';
      } else if (appointment != null) {
        // From available appointments
        reservationDate = _formatDateForAPI(
          DateTime.now(),
        ); // Use current date as default
        reservationTime = _formatTimeForAPI(appointment!.dateDisplay);
        type = 'online'; // Default to online
      } else {
        _showErrorDialog(context, 'لا يمكن تحديد وقت الموعد');
        return;
      }

      // Debug logging
      print('Reservation data:');
      print('Date: $reservationDate');
      print('Time: $reservationTime');
      print('Type: $type');
      print('Doctor ID: $doctorId');

      // Show loading dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Row(
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 20),
                Text('creating_reservation'.tr()),
              ],
            ),
          );
        },
      );

      // Create reservation
      final success = await viewModel.createReservation(
        doctorId: doctorId,
        reservationDate: reservationDate,
        reservationTime: reservationTime,
        type: type,
        paymentMethod: paymentMethod,
        userPetId: userPetId,
      );

      // Hide loading dialog
      Navigator.of(context).pop();

      if (success) {
        // Show success dialog
        _showSuccessDialog(context);
      } else {
        // Show error dialog
        _showErrorDialog(
          context,
          viewModel.reservationError ?? 'فشل في إنشاء الحجز',
        );
      }
    } catch (e) {
      // Hide loading dialog if it's still showing
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
      _showErrorDialog(context, 'حدث خطأ: $e');
    }
  }

  String _formatDateForAPI(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  String _formatTimeForAPI(String time) {
    try {
      // Handle different time formats
      if (time.contains('م') || time.contains('ص')) {
        // Arabic time format like "05:00 م" or "10:30 ص"
        String cleanTime = time.replaceAll('م', '').replaceAll('ص', '').trim();
        List<String> parts = cleanTime.split(':');
        if (parts.length >= 2) {
          int hour = int.parse(parts[0]);
          String minute = parts[1];

          // Convert to 24-hour format
          if (time.contains('م') && hour != 12) {
            hour += 12;
          } else if (time.contains('ص') && hour == 12) {
            hour = 0;
          }

          return '${hour.toString().padLeft(2, '0')}:${minute.padLeft(2, '0')}';
        }
      } else if (time.contains(':')) {
        // Already in HH:MM format, validate it
        List<String> parts = time.split(':');
        if (parts.length >= 2) {
          int hour = int.parse(parts[0]);
          int minute = int.parse(parts[1]);

          // Ensure valid time range
          if (hour >= 0 && hour <= 23 && minute >= 0 && minute <= 59) {
            return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
          }
        }
      }

      // Default fallback - use current time
      DateTime now = DateTime.now();
      return '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      print('Error formatting time: $e');
      // Default fallback
      return '10:00';
    }
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('reservation_success'.tr()),
          content: Text('reservation_success_message'.tr()),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                // Navigate to main screen
                NavigationService().pushAndRemoveUntilWidget(MainScreen());
              },
              child: Text('ok'.tr()),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('reservation_error'.tr()),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('ok'.tr()),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDoctorProfile() {
    // Determine which data source to use
    String doctorName = 'د. محمد أحمد'; // Default
    String doctorSpecialty = 'استشاري الطب البيطري'; // Default
    String? doctorImage;

    if (doctor != null) {
      doctorName = doctor!.name;
      doctorSpecialty = doctor!.specialty.isNotEmpty
          ? doctor!.specialty.first.name
          : 'استشاري الطب البيطري';
      doctorImage = doctor!.image;
    } else if (myAppointment != null) {
      doctorName = myAppointment!.doctorName ?? 'د. محمد أحمد';
      doctorSpecialty =
          myAppointment!.doctorSpecialty ?? 'استشاري الطب البيطري';
    }

    return SizedBox(
      width: double.infinity,
      height: 180,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              height: 110,
              decoration: BoxDecoration(
                color: Color(0xFFF6F1E9),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: AppColor.primary, width: 1),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    doctorName,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    doctorSpecialty,
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white,
              backgroundImage: doctorImage != null && doctorImage.isNotEmpty
                  ? NetworkImage(doctorImage)
                  : AssetImage('assets/images/png/vet_person.jpg')
                        as ImageProvider,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingDetails() {
    // Determine which data source to use
    String petName = 'لولو'; // Default
    String consultationTypeText = 'كشف عيادة'; // Default

    if (selectedPet != null) {
      petName = selectedPet!;
    } else if (myAppointment != null) {
      petName =
          myAppointment!.consultationType ??
          'لولو'; // This might need adjustment based on actual model
    }

    if (consultationType != null) {
      consultationTypeText = consultationType!;
    } else if (myAppointment != null) {
      consultationTypeText = myAppointment!.consultationType ?? 'كشف عيادة';
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F1E9),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFF6D9773), width: 1),
      ),
      child: Column(
        children: [
          _buildDetailRow(
            icon: Icons.person,
            label: 'الاسم كامل',
            value: 'omnia khaled',
          ),
          _buildDivider(),
          _buildDetailRow(
            icon: Icons.pets,
            label: 'أسم حيوانك الأليف',
            value: petName,
          ),
          _buildDivider(),
          _buildDetailRow(
            icon: Icons.home,
            label: 'مكان حيوانك الأليف',
            value: consultationTypeText,
          ),
          _buildDivider(),
          _buildDetailRow(
            icon: Icons.phone,
            label: 'رقم الهاتف',
            value: '+968 000 000 0000',
            showFlag: true,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
    bool showFlag = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        children: [
          // Right side - Label and icon
          if (!showFlag) ...[
            Row(
              children: [
                Icon(icon, color: AppColor.primary, size: 30),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: const TextStyle(
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                        fontSize: 16,
                        height: 1.0,
                        letterSpacing: 0,
                        color: Color(0xFF2D2D2D),
                      ),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      value,
                      style: const TextStyle(
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                        fontSize: 16,
                        height: 1.0,
                        letterSpacing: 0,
                        color: Color(0xFF2D2D2D),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
          // Left side - Value
          if (showFlag) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 5),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Color(0xFFB0B0B0), width: 1),
                    ),
                  ),
                  child: Row(
                    children: [
                      Text('🇴🇲', style: TextStyle(fontSize: 30)),
                      Icon(
                        Icons.keyboard_arrow_down,
                        size: 30,
                        color: AppColor.primary,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Color(0xFFB0B0B0), width: 1),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.phone, color: AppColor.primary, size: 30),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'رقم الهاتف',
                            style: const TextStyle(
                              fontFamily: 'Cairo',
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.normal,
                              fontSize: 16,
                              height: 1.0,
                              letterSpacing: 0,
                              color: Color(0xFF2D2D2D),
                            ),
                          ),
                          const SizedBox(height: 7),
                          Text(
                            '+968 000 000 0000',
                            style: const TextStyle(
                              fontFamily: 'Cairo',
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.normal,
                              fontSize: 16,
                              height: 1.0,
                              letterSpacing: 0,
                              color: Color(0xFF2D2D2D),
                            ),
                          ),
                          SizedBox(height: 5),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      width: double.infinity,
      height: 0,
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Color(0xFFB0B0B0), width: 1)),
      ),
    );
  }

  Widget _buildAppointmentTime() {
    // Determine which data source to use
    String appointmentTime = '05:00 م'; // Default
    String appointmentDate = 'اليوم 3 يونيو'; // Default

    if (selectedTime != null) {
      appointmentTime = selectedTime!;
    } else if (myAppointment != null) {
      appointmentTime = myAppointment!.appointmentTime;
      appointmentDate = myAppointment!.formattedDate;
    } else if (appointment != null) {
      appointmentTime = appointment!.dateDisplay;
      appointmentDate = appointment!.dateDisplay;
    }

    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F1E9),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFF6D9773), width: 1),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                child: const Icon(
                  Icons.calendar_today,
                  color: AppColor.primary,
                  size: 25,
                ),
              ),
              const SizedBox(width: 4),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Text(
                    appointmentTime,
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal,
                      fontSize: 16,
                      height: 1.0,
                      letterSpacing: 0,
                      color: Color(0xFF2D2D2D),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    appointmentDate,
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal,
                      fontSize: 16,
                      height: 1.0,
                      letterSpacing: 0,
                      color: Color(0xFF2D2D2D),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildPriceSection() {
    // Determine which data source to use
    String priceText = 'سعر الكشف 10 ريال'; // Default

    if (consultationPrice != null) {
      priceText = 'سعر الكشف ${consultationPrice!.toInt()} ريال';
    } else if (myAppointment != null) {
      priceText = 'سعر الكشف ${myAppointment!.consultationPrice.toInt()} ريال';
    } else if (doctor != null) {
      priceText = 'سعر الكشف ${doctor!.price.toInt()} ريال';
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F1E9),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFF6D9773), width: 1),
      ),
      child: Row(
        children: [
          const Icon(Icons.receipt, color: AppColor.primary, size: 20),
          const SizedBox(width: 12),
          Text(
            priceText,
            style: const TextStyle(
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.normal,
              fontSize: 16,
              height: 1.0,
              letterSpacing: 0,
              color: Color(0xFF2D2D2D),
            ),
          ),
        ],
      ),
    );
  }
}
