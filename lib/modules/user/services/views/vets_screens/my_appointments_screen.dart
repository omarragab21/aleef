import 'package:flutter/material.dart';
import 'package:aleef/shared/assets/app_color.dart';
import 'package:aleef/shared/assets/app_text_styles.dart';
import 'package:aleef/modules/user/services/models/appointment_model.dart';

class MyAppointmentsScreen extends StatefulWidget {
  const MyAppointmentsScreen({super.key});

  @override
  State<MyAppointmentsScreen> createState() => _MyAppointmentsScreenState();
}

class _MyAppointmentsScreenState extends State<MyAppointmentsScreen> {
  List<AppointmentModel> appointments = [];

  @override
  void initState() {
    super.initState();
    _loadAppointments();
  }

  void _loadAppointments() {
    // Mock data based on the UI design
    appointments = [
      AppointmentModel(
        id: '1',
        doctorName: 'د. محمد أحمد',
        doctorSpecialty: 'استشاري الطب البيطري',
        doctorImageUrl:
            'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?w=150&h=150&fit=crop&crop=face',
        appointmentDate: DateTime.now(),
        appointmentTime: '05:00 م',
        consultationType: 'كشف أونلاين',
        consultationPrice: 2.0,
        status: 'active',
      ),
      AppointmentModel(
        id: '2',
        doctorName: 'د. محمد أحمد',
        doctorSpecialty: 'استشاري الطب البيطري',
        doctorImageUrl:
            'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?w=150&h=150&fit=crop&crop=face',
        appointmentDate: DateTime.now(),
        appointmentTime: '05:00 م',
        consultationType: 'كشف أونلاين',
        consultationPrice: 2.0,
        status: 'completed',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header Section
            _buildHeader(),

            // Appointments List
            Expanded(child: _buildAppointmentsList()),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        children: [
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios, color: AppColor.primary, size: 20),
          ),
          Expanded(
            child: Text(
              'حجوزاتي',
              style: AppTextStyles.titleLarge.copyWith(
                color: AppColor.title,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppointmentsList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: appointments.length,
      itemBuilder: (context, index) {
        final appointment = appointments[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: _buildAppointmentCard(appointment, index),
        );
      },
    );
  }

  Widget _buildAppointmentCard(AppointmentModel appointment, int index) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.f6f1e9,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColor.primary, width: 1),
      ),
      child: Column(
        children: [
          // Doctor Info Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Doctor Image
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(appointment.doctorImageUrl ?? ''),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // Doctor Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15),
                    Text(
                      appointment.doctorName ?? '',
                      style: AppTextStyles.titleMedium.copyWith(
                        color: AppColor.title,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      appointment.doctorSpecialty ?? '',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColor.title,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildAppointmentDetail(
                      icon: Icons.calendar_today,
                      text:
                          '${appointment.formattedDate} ${appointment.appointmentTime}',
                    ),

                    const SizedBox(height: 4),

                    _buildAppointmentDetail(
                      icon: Icons.phone,
                      text: appointment.consultationType ?? '',
                    ),

                    const SizedBox(height: 4),

                    _buildAppointmentDetail(
                      icon: Icons.attach_money,
                      text: 'سعر الكشف: ${appointment.consultationPrice} ريال',
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 30),

          // Action Buttons
          Row(
            children: [
              // Left Button (Support)
              Expanded(
                child: _buildActionButton(
                  icon: Icons.headset_mic,
                  text: 'الدعم',
                  onTap: () => _handleSupportTap(appointment),
                ),
              ),

              const SizedBox(width: 12),

              // Right Button (Edit/Rebook)
              Expanded(
                child: _buildActionButton(
                  icon: index == 0 ? Icons.edit : Icons.refresh,
                  text: index == 0 ? 'تعديل' : 'إعادة الحجز',
                  onTap: () => index == 0
                      ? _handleEditTap(appointment)
                      : _handleRebookTap(appointment),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAppointmentDetail({
    required IconData icon,
    required String text,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Icon(icon, color: AppColor.primary, size: 20),
        const SizedBox(width: 8),
        Text(
          text,
          style: AppTextStyles.bodyMedium.copyWith(color: AppColor.title),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: AppColor.primary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 18),
            const SizedBox(width: 8),
            Text(
              text,
              style: AppTextStyles.labelMedium.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNavItem(
                icon: Icons.home,
                label: 'الرئيسية',
                isSelected: false,
                onTap: () {},
              ),
              _buildNavItem(
                icon: Icons.grid_view,
                label: 'الخدمات',
                isSelected: false,
                onTap: () {},
              ),
              _buildNavItem(
                icon: Icons.pets,
                label: 'حيواناتي',
                isSelected: false,
                onTap: () {},
              ),
              _buildNavItem(
                icon: Icons.person,
                label: 'حسابي',
                isSelected: false,
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? AppColor.primary : AppColor.lightGray,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: AppTextStyles.labelSmall.copyWith(
              color: isSelected ? AppColor.primary : AppColor.lightGray,
            ),
          ),
        ],
      ),
    );
  }

  // Action Handlers
  void _handleSupportTap(AppointmentModel appointment) {
    // TODO: Implement support functionality
    print('Support tapped for appointment: ${appointment.id}');
  }

  void _handleEditTap(AppointmentModel appointment) {
    // TODO: Implement edit functionality
    print('Edit tapped for appointment: ${appointment.id}');
  }

  void _handleRebookTap(AppointmentModel appointment) {
    // TODO: Implement rebook functionality
    print('Rebook tapped for appointment: ${appointment.id}');
  }
}
