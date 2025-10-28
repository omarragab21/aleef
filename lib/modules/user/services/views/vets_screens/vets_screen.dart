import 'package:aleef/modules/user/services/views/vets_screens/vet_details_screen.dart';
import 'package:aleef/shared/routes/navigation_routes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../../../shared/assets/app_color.dart';
import '../../../../../shared/assets/app_text_styles.dart';
import '../../view_models/services_view_model.dart';
import '../../models/doctor_model.dart';

class VetsScreen extends StatefulWidget {
  const VetsScreen({super.key});

  @override
  State<VetsScreen> createState() => _VetsScreenState();
}

class _VetsScreenState extends State<VetsScreen> {
  bool isExaminationSelected =
      true; // true for "كشف" (Examination), false for "أونلاين" (Online)
  DoctorModel? selectedDoctor;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Load doctors when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ServicesViewModel>().getDoctors(type: 'normal');
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Consumer<ServicesViewModel>(
          builder: (context, servicesViewModel, child) {
            return Column(
              children: [
                // Header Section
                _buildHeader(),

                // Toggle Section
                _buildToggleSection(servicesViewModel),

                // Search Section
                _buildSearchSection(servicesViewModel),

                // Doctors List
                Expanded(child: _buildDoctorsList(servicesViewModel)),
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
            'book_doctor'.tr(),
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

  Widget _buildToggleSection(ServicesViewModel servicesViewModel) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColor.lightGreen,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColor.stroke2),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() => isExaminationSelected = true);
                servicesViewModel.getDoctors(type: 'normal');
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isExaminationSelected
                      ? AppColor.primary
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  'online_consultation'.tr(),
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                    fontSize: 20,
                    height: 1.0,
                    letterSpacing: 0,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() => isExaminationSelected = false);
                servicesViewModel.getDoctors(type: 'online');
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: !isExaminationSelected
                      ? AppColor.primary
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  'consultation'.tr(),
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                    fontSize: 20,
                    height: 1.0,
                    letterSpacing: 0,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchSection(ServicesViewModel servicesViewModel) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColor.primary),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Icon(Icons.search, color: AppColor.primary, size: 27),
          ),
          Expanded(
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                // Implement search functionality
                if (value.isEmpty) {
                  servicesViewModel.getDoctors(
                    type: isExaminationSelected ? 'normal' : 'online',
                  );
                } else {
                  // You can implement search logic here
                  // For now, we'll just filter locally
                }
              },
              decoration: InputDecoration(
                hintText: 'search_for_vet'.tr(),
                hintStyle: const TextStyle(
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                  fontSize: 20,
                  height: 1.0,
                  letterSpacing: 0,
                  color: Color(0xFF555555),
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(12),
            child: SvgPicture.asset(
              'assets/images/svg/fliter_icon.svg',
              width: 20,
              height: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorsList(ServicesViewModel servicesViewModel) {
    if (servicesViewModel.isLoadingDoctors) {
      return const Center(
        child: CircularProgressIndicator(color: AppColor.primary),
      );
    }

    if (servicesViewModel.doctorsError != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Error: ${servicesViewModel.doctorsError}',
              style: const TextStyle(color: Colors.red),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => servicesViewModel.getDoctors(
                type: isExaminationSelected ? 'normal' : 'online',
              ),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (servicesViewModel.doctors.isEmpty) {
      return Center(
        child: Text(
          'no_doctors_found'.tr(),
          style: AppTextStyles.bodyLarge.copyWith(color: AppColor.title),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: servicesViewModel.doctors.length,
      itemBuilder: (context, index) {
        final doctor = servicesViewModel.doctors[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: _buildDoctorCard(
            doctor: doctor,
            isSelected: selectedDoctor?.id == doctor.id,
            onTap: () {
              setState(() {
                selectedDoctor = doctor;
              });
            },
          ),
        );
      },
    );
  }

  Widget _buildDoctorCard({
    required DoctorModel doctor,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? AppColor.lightGreen : const Color(0xFFF6F1E9),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColor.primary : Color(0xFF6D9773),
            width: isSelected ? 2 : 1,
          ),
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
                      Row(
                        children: [
                          Text(
                            doctor.specialty.map((e) => e.name).join(', '),
                            style: const TextStyle(
                              fontFamily: 'Cairo',
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.normal,
                              fontSize: 15,
                              height: 1.0,
                              letterSpacing: 0,
                              color: Color(0xFF2D2D2D),
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '- ${doctor.experience != null ? doctor.experience! : 0} سنين خبرة',
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
                          const SizedBox(width: 8),
                          Text(
                            '- ${doctor.spaceString}',
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
                if (isSelected)
                  Icon(Icons.check_circle, color: AppColor.primary, size: 24),
              ],
            ),
            const SizedBox(height: 12),

            // Service Buttons
            Row(
              children: [
                Expanded(child: _buildServiceButton('العناية')),
                const SizedBox(width: 8),
                Expanded(child: _buildServiceButton('العلاج')),
                const SizedBox(width: 8),
                Expanded(child: _buildServiceButton('كشف أونلاين')),
              ],
            ),

            const SizedBox(height: 12),

            // Book Appointment Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Handle booking appointment with selected doctor
                  NavigationService().pushWidget(
                    VetDetailsScreen(doctor: doctor),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'حجز موعد',
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
          ],
        ),
      ),
    );
  }

  Widget _buildServiceButton(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 13),
      decoration: BoxDecoration(
        color: AppColor.lightGreen,
        borderRadius: BorderRadius.circular(15),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          text,
          style: const TextStyle(
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            fontSize: 16,
            height: 1.0,
            letterSpacing: 0,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
