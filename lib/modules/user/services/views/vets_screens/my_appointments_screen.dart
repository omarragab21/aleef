import 'package:flutter/material.dart';
import 'package:aleef/shared/assets/app_color.dart';
import 'package:aleef/shared/assets/app_text_styles.dart';
import 'package:aleef/modules/user/services/models/appointment_model.dart';
import 'package:aleef/modules/user/profile/models/reservation_model.dart';
import 'package:aleef/modules/user/profile/view_models/profile_view_model.dart';
import 'package:aleef/shared/routes/navigation_routes.dart';
import 'package:aleef/modules/user/services/views/vets_screens/confrim_reservation.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class MyAppointmentsScreen extends StatefulWidget {
  const MyAppointmentsScreen({super.key});

  @override
  State<MyAppointmentsScreen> createState() => _MyAppointmentsScreenState();
}

class _MyAppointmentsScreenState extends State<MyAppointmentsScreen> {
  @override
  void initState() {
    super.initState();
    // Load reservations when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileViewModel>().getReservations(type: 'current');
    });
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
            Expanded(
              child: Consumer<ProfileViewModel>(
                builder: (context, viewModel, child) {
                  if (viewModel.isLoadingReservations) {
                    return _buildLoadingState();
                  }

                  if (viewModel.reservationsError != null) {
                    return _buildErrorState(viewModel.reservationsError!);
                  }

                  if (viewModel.reservations.isEmpty) {
                    return _buildEmptyState();
                  }

                  return _buildAppointmentsList(viewModel.reservations);
                },
              ),
            ),
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

  Widget _buildAppointmentsList(List<ProfileReservationModel> reservations) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: reservations.length,
      itemBuilder: (context, index) {
        final reservation = reservations[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: _buildAppointmentCard(reservation, index),
        );
      },
    );
  }

  Widget _buildAppointmentCard(ProfileReservationModel reservation, int index) {
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
                  color: AppColor.primary.withOpacity(0.1),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/png/vet_person.jpg'),
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
                      reservation.doctor.name,
                      style: AppTextStyles.titleMedium.copyWith(
                        color: AppColor.title,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'طبيب بيطري', // Default specialty since it's not in the API response
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColor.title,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildAppointmentDetail(
                      icon: Icons.calendar_today,
                      text:
                          '${reservation.reservationDate} ${reservation.reservationTime}',
                    ),

                    const SizedBox(height: 4),

                    _buildAppointmentDetail(
                      icon: Icons.phone,
                      text: reservation.type == 'online'
                          ? 'كشف أونلاين'
                          : 'زيارة منزلية',
                    ),

                    const SizedBox(height: 4),

                    _buildAppointmentDetail(
                      icon: Icons.attach_money,
                      text: 'سعر الكشف: ${reservation.price} ريال',
                    ),

                    const SizedBox(height: 4),

                    _buildAppointmentDetail(
                      icon: Icons.pets,
                      text: 'الحيوان: ${reservation.pet.name}',
                    ),

                    const SizedBox(height: 4),

                    _buildAppointmentDetail(
                      icon: Icons.info,
                      text: 'الحالة: ${reservation.status}',
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
                  onTap: () => _handleSupportTap(reservation),
                ),
              ),

              const SizedBox(width: 12),

              // Right Button (Edit/Rebook)
              Expanded(
                child: _buildActionButton(
                  icon: index == 0 ? Icons.edit : Icons.refresh,
                  text: index == 0 ? 'تعديل' : 'إعادة الحجز',
                  onTap: () => index == 0
                      ? _handleEditTap(reservation)
                      : _handleRebookTap(reservation),
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

  Widget _buildLoadingState() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildErrorState(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'حدث خطأ في تحميل الحجوزات',
            style: AppTextStyles.titleMedium.copyWith(color: AppColor.title),
          ),
          const SizedBox(height: 8),
          Text(
            error,
            style: AppTextStyles.bodyMedium.copyWith(color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              context.read<ProfileViewModel>().getReservations(type: 'current');
            },
            child: Text('إعادة المحاولة'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.calendar_today_outlined,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'no_reservations_found'.tr(),
            style: AppTextStyles.titleMedium.copyWith(color: AppColor.title),
          ),
          const SizedBox(height: 8),
          Text(
            'لا توجد حجوزات متاحة حالياً',
            style: AppTextStyles.bodyMedium.copyWith(color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // Action Handlers
  void _handleSupportTap(ProfileReservationModel reservation) {
    // TODO: Implement support functionality
    print('Support tapped for reservation: ${reservation.id}');
  }

  void _handleEditTap(ProfileReservationModel reservation) {
    // TODO: Implement edit functionality
    print('Edit tapped for reservation: ${reservation.id}');
  }

  void _handleRebookTap(ProfileReservationModel reservation) {
    // Convert ProfileReservationModel to AppointmentModel for ConfrimReservation
    final appointment = AppointmentModel(
      id: reservation.id.toString(),
      doctorName: reservation.doctor.name,
      doctorSpecialty: 'طبيب بيطري',
      doctorImageUrl: null,
      appointmentDate:
          DateTime.tryParse(reservation.reservationDate) ?? DateTime.now(),
      appointmentTime: reservation.reservationTime,
      consultationType: reservation.type == 'online'
          ? 'كشف أونلاين'
          : 'زيارة منزلية',
      consultationPrice: double.tryParse(reservation.price) ?? 0.0,
      status: reservation.status.toLowerCase(),
    );

    NavigationService().pushWidget(
      ConfrimReservation(myAppointment: appointment),
    );
  }
}
