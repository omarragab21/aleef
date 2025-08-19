import 'package:aleef/shared/assets/app_color.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ConfrimReservation extends StatelessWidget {
  const ConfrimReservation({super.key});

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
    return Center(
      child: GestureDetector(
        onTap: () {
          // Handle booking confirmation
          // NavigationService().pushWidget(ConfrimReservation());
        },
        child: Container(
          width: double.infinity,
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: const Color(0xFF6D9773),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: const Color(0xFF6D9773), width: 2),
          ),
          alignment: Alignment.center,
          child: Text(
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
  }
}

Widget _buildDoctorProfile() {
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
                  'د. محمد أحمد',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'استشاري الطب البيطري',
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
            backgroundImage: AssetImage('assets/images/png/vet_person.jpg'),
          ),
        ),
      ],
    ),
  );
}

Widget _buildBookingDetails() {
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
          value: 'لولو',
        ),
        _buildDivider(),
        _buildDetailRow(
          icon: Icons.home,
          label: 'مكان حيوانك الأليف',
          value: 'المنزل',
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
    // Opacity is 1 by default, angle 180deg is not directly applicable for a line
  );
}

Widget _buildAppointmentTime() {
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
                const Text(
                  '05:00 م',
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
                const Text(
                  'اليوم 3 يونيو',
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

        // Confirm Booking Button
      ],
    ),
  );
}

Widget _buildPriceSection() {
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
        const Text(
          'سعر الكشف 10 ريال',
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
