import 'package:aleef/modules/user/services/views/vets_screens/vet_details_screen.dart';
import 'package:aleef/shared/routes/navigation_routes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../shared/assets/app_color.dart';
import '../../../../../shared/assets/app_text_styles.dart';

class VetsScreen extends StatefulWidget {
  const VetsScreen({super.key});

  @override
  State<VetsScreen> createState() => _VetsScreenState();
}

class _VetsScreenState extends State<VetsScreen> {
  bool isExaminationSelected =
      true; // true for "كشف" (Examination), false for "أونلاين" (Online)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header Section
            _buildHeader(),

            // Toggle Section
            _buildToggleSection(),

            // Search Section
            _buildSearchSection(),

            // Doctors List
            Expanded(child: _buildDoctorsList()),
          ],
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

  Widget _buildToggleSection() {
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
              onTap: () => setState(() => isExaminationSelected = true),
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
              onTap: () => setState(() => isExaminationSelected = false),
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

  Widget _buildSearchSection() {
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

  Widget _buildDoctorsList() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        _buildDoctorCard(
          name: 'د. محمد أحمد',
          specialization: 'الطب البيطري العام - 10 سنين خبرة',
          animalTypes: 'التخصص الحيواني : قطط, كلاب',
          rating: '5.0',
          reviews: '100',
          price: '2',
          imageUrl: 'assets/images/png/vet_person.jpg',
        ),
        const SizedBox(height: 16),
        _buildDoctorCard(
          name: 'د. محمد أحمد',
          specialization: 'الطب السلوكي - 7 سنين خبرة',
          animalTypes: 'التخصص الحيواني : قطط, كلاب, طيور',
          rating: '5.0',
          reviews: '100',
          price: '5',
          imageUrl: 'assets/images/png/vet_person.jpg',
        ),
      ],
    );
  }

  Widget _buildDoctorCard({
    required String name,
    required String specialization,
    required String animalTypes,
    required String rating,
    required String reviews,
    required String price,
    required String imageUrl,
  }) {
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
              CircleAvatar(radius: 30, backgroundImage: AssetImage(imageUrl)),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Text(
                    name,
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
                    specialization,
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
                  const SizedBox(height: 4),
                  Text(
                    animalTypes,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColor.title,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        "($reviews) ${'reviews'.tr()}",
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColor.title,
                        ),
                      ),
                      const SizedBox(width: 4),

                      Text(
                        rating,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColor.title,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(Icons.star, color: Colors.amber, size: 16),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'السعر : $price ريال',
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
                // Handle booking appointment
                NavigationService().pushWidget(VetDetailsScreen());
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

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
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
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home, 'الرئيسية', true),
              _buildNavItem(Icons.grid_view, 'الخدمات', false),
              _buildNavItem(Icons.pets, 'حيواناتي', false),
              _buildNavItem(Icons.person, 'حسابي', false),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: isActive ? AppColor.primary : AppColor.lightGray,
          size: 24,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(
            color: isActive ? AppColor.primary : AppColor.lightGray,
          ),
        ),
      ],
    );
  }
}
