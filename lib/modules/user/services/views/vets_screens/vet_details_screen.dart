import 'package:aleef/shared/assets/app_color.dart';
import 'package:aleef/shared/assets/app_text_styles.dart';
import 'package:aleef/shared/routes/navigation_routes.dart';
import 'package:aleef/modules/user/services/views/vets_screens/book__appointment_screen.dart';
import 'package:aleef/modules/user/services/models/doctor_model.dart';
import 'package:aleef/modules/user/services/models/appointment_model.dart';
import 'package:aleef/modules/user/services/view_models/services_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class VetDetailsScreen extends StatefulWidget {
  final DoctorModel? doctor;

  const VetDetailsScreen({super.key, this.doctor});

  @override
  State<VetDetailsScreen> createState() => _VetDetailsScreenState();
}

class _VetDetailsScreenState extends State<VetDetailsScreen> {
  bool isHomeVisitSelected = true; // Default to home visit
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _pageController.addListener(_onPageChanged);
  }

  void _onPageChanged() {
    if (_pageController.hasClients) {
      setState(() {
        // Trigger rebuild to update button states
      });
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Consumer<ServicesViewModel>(
          builder: (context, servicesViewModel, child) {
            // Fetch appointments when doctor is available
            if (widget.doctor != null &&
                servicesViewModel.selectedDoctorId != widget.doctor!.id) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                servicesViewModel.getAvailableAppointments(
                  doctorId: widget.doctor!.id,
                );
              });
            }

            return Column(
              children: [
                _buildHeader(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _buildDoctorCard(doctor: widget.doctor),
                ),
                SizedBox(height: 30.h),
                _priceWidget(
                  doctor: widget.doctor,
                  isHomeVisitSelected: isHomeVisitSelected,
                  onSelectionChanged: (isHomeVisit) {
                    setState(() {
                      isHomeVisitSelected = isHomeVisit;
                    });
                  },
                ),
                SizedBox(height: 20.h),
                Text(
                  'choose_booking_time'.tr(),
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                    fontSize: 16,
                    height: 1.0,
                    letterSpacing: 0,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20.h),
                _buildAppointmentsList(servicesViewModel, context),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              NavigationService().pop();
            },
            icon: Icon(Icons.arrow_back_ios, color: AppColor.primary, size: 20),
          ),
          Spacer(),
          Text(
            'doctor_info'.tr(),
            style: AppTextStyles.titleLarge.copyWith(
              color: AppColor.title,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(width: 30.w),
          Spacer(),
        ],
      ),
    );
  }

  Widget _buildAppointmentsList(
    ServicesViewModel servicesViewModel,
    BuildContext context,
  ) {
    if (servicesViewModel.isLoadingAppointments) {
      return const Center(
        child: CircularProgressIndicator(color: AppColor.primary),
      );
    }

    if (servicesViewModel.appointmentsError != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Error: ${servicesViewModel.appointmentsError}',
              style: const TextStyle(color: Colors.red),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (widget.doctor != null) {
                  servicesViewModel.getAvailableAppointments(
                    doctorId: widget.doctor!.id,
                  );
                }
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (servicesViewModel.availableAppointments.isEmpty) {
      return Center(
        child: Text(
          'no_appointments_available'.tr(),
          style: AppTextStyles.bodyLarge.copyWith(color: AppColor.title),
        ),
      );
    }

    // Calculate scroll states
    final canScrollLeft =
        _pageController.hasClients && _pageController.offset > 0;
    final canScrollRight =
        _pageController.hasClients &&
        _pageController.offset < _pageController.position.maxScrollExtent;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Left Arrow Button
        GestureDetector(
          onTap: canScrollLeft
              ? () {
                  if (_pageController.hasClients) {
                    final currentOffset = _pageController.offset;
                    final itemWidth =
                        (MediaQuery.of(context).size.width * .80) / 3;
                    final newOffset = (currentOffset - itemWidth).clamp(
                      0.0,
                      _pageController.position.maxScrollExtent,
                    );
                    _pageController.animateTo(
                      newOffset,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                }
              : null,
          child: Container(
            width: 30.w,
            height: 30.h,
            padding: EdgeInsets.only(right: 7.w),
            decoration: BoxDecoration(
              color: canScrollLeft ? Color(0xFFD9D9D9) : Color(0xFFE0E0E0),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: canScrollLeft ? AppColor.primary : Color(0xFFB0B0B0),
            ),
          ),
        ),
        // ListView for Appointments (showing 3 at once)
        SizedBox(
          height: 220,
          width: MediaQuery.of(context).size.width * .80,
          child: ListView.builder(
            controller: _pageController,
            scrollDirection: Axis.horizontal,
            itemCount: servicesViewModel.availableAppointments.length,
            itemBuilder: (context, index) {
              final appointment =
                  servicesViewModel.availableAppointments[index];
              return Container(
                width:
                    (MediaQuery.of(context).size.width * .80) /
                    3, // Show 3 items
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: GestureDetector(
                  onTap: () {
                    NavigationService().pushWidget(
                      BookAppointmentScreen(
                        doctor: widget.doctor,
                        appointment: appointment,
                      ),
                    );
                  },
                  child: _buildAppointmentCard(appointment),
                ),
              );
            },
          ),
        ),
        // Right Arrow Button
        GestureDetector(
          onTap: canScrollRight
              ? () {
                  if (_pageController.hasClients) {
                    final currentOffset = _pageController.offset;
                    final itemWidth =
                        (MediaQuery.of(context).size.width * .80) / 3;
                    final newOffset = (currentOffset + itemWidth).clamp(
                      0.0,
                      _pageController.position.maxScrollExtent,
                    );
                    _pageController.animateTo(
                      newOffset,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                }
              : null,
          child: Container(
            width: 30.w,
            height: 30.h,
            padding: EdgeInsets.only(left: 0.w),
            decoration: BoxDecoration(
              color: canScrollRight ? Color(0xFFD9D9D9) : Color(0xFFE0E0E0),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(
              Icons.arrow_forward_ios,
              size: 20,
              color: canScrollRight ? AppColor.primary : Color(0xFFB0B0B0),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAppointmentCard(AvailableAppointmentModel appointment) {
    return Container(
      width: 100.w,
      height: 220,
      decoration: BoxDecoration(
        color: Color(0xFFF6F1E9),
        border: Border.all(color: AppColor.primary, width: 1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 65.h,
            decoration: BoxDecoration(
              color: const Color(0xFF6D9773),
              borderRadius: BorderRadius.circular(15),
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Column(
                  children: [
                    Text(
                      appointment.day,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '${appointment.dateDisplay}',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Spacer(),
          Container(
            width: double.infinity,
            height: 60.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xFFFE0A0A),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              'أحجز',
              style: AppTextStyles.bodyMedium.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 16,
                height: 1.0,
                letterSpacing: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorCard({required DoctorModel? doctor}) {
    if (doctor == null) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFF6F1E9),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Color(0xFF6D9773), width: 1),
        ),
        child: const Center(child: Text('No doctor selected')),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F1E9),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Color(0xFF6D9773), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Doctor Info Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage:
                    doctor.image != null && doctor.image!.isNotEmpty
                    ? NetworkImage(doctor.image!)
                    : const AssetImage('assets/images/png/vet_person.jpg')
                          as ImageProvider,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text(
                      doctor.name,
                      style: const TextStyle(
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                        fontSize: 20,
                        height: 1.0,
                        letterSpacing: 0,
                        color: Color(0xFF2D2D2D),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      doctor.specialtyString,
                      style: const TextStyle(
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                        fontSize: 15,
                        height: 1.0,
                        letterSpacing: 0,
                        color: Color(0xFF2D2D2D),
                      ),
                    ),
                    if (doctor.description != null &&
                        doctor.description!.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        doctor.description!,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColor.title,
                        ),
                      ),
                    ],
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        if (doctor.rating > 0) ...[
                          Text(
                            doctor.rating.toString(),
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColor.title,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Icon(Icons.star, color: Colors.amber, size: 16),
                          const SizedBox(width: 8),
                        ],
                        Text(
                          '(${doctor.totalReviews}) ${'reviews'.tr()}',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColor.title,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    if (doctor.price > 0)
                      Text(
                        'السعر : ${doctor.priceString} ريال',
                        style: const TextStyle(
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                          fontSize: 15,
                          height: 1.0,
                          letterSpacing: 0,
                          color: Color(0xFF2D2D2D),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _priceWidget extends StatelessWidget {
  final DoctorModel? doctor;
  final bool isHomeVisitSelected;
  final Function(bool) onSelectionChanged;

  const _priceWidget({
    required this.doctor,
    required this.isHomeVisitSelected,
    required this.onSelectionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F1E9),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFF6D9773), width: 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10, top: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset('assets/images/svg/wallet.svg'),
                SizedBox(width: 5.5.w),
                Text(
                  'سعر الكشف: ${doctor?.price ?? 0} ريال عماني ${isHomeVisitSelected ? '(زيارة منزلية)' : '(كشف عيادة)'}',
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
          ),
          SizedBox(height: 12),
          Divider(color: Color(0xFFB0B0B0), thickness: 1),
          // Home Visit Option
          GestureDetector(
            onTap: () => onSelectionChanged(true),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      color: isHomeVisitSelected
                          ? AppColor.primary
                          : Colors.transparent,
                      border: Border.all(
                        color: isHomeVisitSelected
                            ? AppColor.primary
                            : AppColor.stroke2,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12.5),
                    ),
                    child: isHomeVisitSelected
                        ? const Center(
                            child: Icon(
                              Icons.done,
                              color: Colors.white,
                              size: 16,
                            ),
                          )
                        : null,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'زيارة منزلية',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: isHomeVisitSelected
                          ? AppColor.primary
                          : Color(0xFF2D2D2D),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Clinic Visit Option
          GestureDetector(
            onTap: () => onSelectionChanged(false),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      color: !isHomeVisitSelected
                          ? AppColor.primary
                          : Colors.transparent,
                      border: Border.all(
                        color: !isHomeVisitSelected
                            ? AppColor.primary
                            : AppColor.stroke2,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12.5),
                    ),
                    child: !isHomeVisitSelected
                        ? const Center(
                            child: Icon(
                              Icons.done,
                              color: Colors.white,
                              size: 16,
                            ),
                          )
                        : null,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'كشف عيادة',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: !isHomeVisitSelected
                          ? AppColor.primary
                          : Color(0xFF2D2D2D),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
