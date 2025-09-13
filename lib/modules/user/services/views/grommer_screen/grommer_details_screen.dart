import 'package:aleef/modules/user/services/views/grommer_screen/grommer_appointment_screen.dart';
import 'package:aleef/shared/routes/navigation_routes.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aleef/shared/assets/app_color.dart';
import 'package:aleef/shared/assets/app_text_styles.dart';

class GrommerDetailsScreen extends StatefulWidget {
  const GrommerDetailsScreen({super.key});

  @override
  State<GrommerDetailsScreen> createState() => _GrommerDetailsScreenState();
}

class _GrommerDetailsScreenState extends State<GrommerDetailsScreen> {
  int currentImageIndex = 1;
  final int totalImages = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColor.primary),
          onPressed: () => NavigationService().pop(),
        ),
        title: Text(
          'salon_details'.tr(),
          style: AppTextStyles.titleLarge.copyWith(
            color: AppColor.title,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Salon Banner/Image Carousel
            _buildSalonBanner(),
            SizedBox(height: 16.h),

            // Salon Rating and Name
            _buildSalonInfo(),
            SizedBox(height: 8.h),

            // Salon Reviews
            _buildSalonReviews(),
            SizedBox(height: 24.h),

            // Available Services Section
            _buildAvailableServices(),
            SizedBox(height: 24.h),

            // Service Duration
            _buildServiceDuration(),
            SizedBox(height: 100.h), // Space for the bottom button
          ],
        ),
      ),
      bottomNavigationBar: _buildBookServiceButton(),
    );
  }

  Widget _buildSalonBanner() {
    return Container(
      height: 250.h,
      width: double.infinity,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: Colors.grey[200],
      ),
      child: Stack(
        children: [
          // Placeholder for hotel image
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: Colors.grey[300],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.asset(
                'assets/images/png/pets_shop.jpg',
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),

          // Navigation arrows
          Positioned(
            left: 0.w,
            top: 0,
            bottom: 0,
            child: Center(
              child: Container(
                height: 24.h,
                width: 24.w,
                decoration: BoxDecoration(color: Color(0xFFB2B2B2)),
                child: Icon(Icons.arrow_forward_ios, size: 20.sp),
              ),
            ),
          ),

          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: Center(
              child: Container(
                height: 24.h,
                width: 24.w,
                decoration: BoxDecoration(color: Color(0xFFB2B2B2)),
                child: Padding(
                  padding: const EdgeInsets.only(right: 5.0),
                  child: Icon(Icons.arrow_back_ios, size: 20.sp),
                ),
              ),
            ),
          ),

          // Image counter
          Positioned(
            bottom: 16.h,
            left: 16.w,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                '1/20',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSalonInfo() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          // Rating
          SizedBox(width: 16.w),

          // Salon Name
          Text(
            'soft_claws_salon_ar'.tr(),
            style: AppTextStyles.titleMedium.copyWith(
              color: AppColor.title,
              fontWeight: FontWeight.w600,
            ),
          ),
          Spacer(),
          Row(
            children: [
              Text(
                '5.0',
                style: AppTextStyles.titleMedium.copyWith(
                  color: AppColor.title,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 8.w),
              Row(
                children: List.generate(5, (index) {
                  return Icon(Icons.star, color: Colors.amber, size: 16.sp);
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSalonReviews() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            'based_on_reviews_count'.tr(namedArgs: {'count': '80'}),
            style: AppTextStyles.bodySmall.copyWith(color: AppColor.lightGray),
          ),
        ),
      ],
    );
  }

  Widget _buildAvailableServices() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: Color(0xFF6D9773), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'available_services_colon'.tr(),
            style: AppTextStyles.titleSmall.copyWith(
              color: AppColor.title,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 12.h),
          Divider(color: AppColor.primary, height: 24.h),
          // Haircut service
          _buildServiceItem('haircut'.tr(), true),

          Divider(color: AppColor.primary, height: 24.h),

          // Ear cleaning service
          _buildServiceItem('ear_cleaning'.tr(), false),
        ],
      ),
    );
  }

  Widget _buildServiceItem(String serviceName, bool isAvailable) {
    return Text(
      serviceName,
      style: AppTextStyles.bodyMedium.copyWith(
        color: isAvailable ? AppColor.title : AppColor.lightGray,
        fontWeight: isAvailable ? FontWeight.w500 : FontWeight.normal,
      ),
    );
  }

  Widget _buildServiceDuration() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: Color(0xFF6D9773), width: 1),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Row(
          children: [
            Icon(Icons.access_time, color: Color(0xFF2D2D2D), size: 16.sp),
            SizedBox(width: 8.w),
            Text(
              'service_duration'.tr(namedArgs: {'minutes': '45'}),
              style: const TextStyle(
                fontFamily: 'Cairo',
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.normal,
                fontSize: 16,
                height: 1.0, // 100% line height
                letterSpacing: 0.0,
                color: Color(0xFF2D2D2D),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookServiceButton() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(color: Colors.transparent),
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: 48.h,
          child: ElevatedButton(
            onPressed: () {
              // TODO: Navigate to booking screen
              NavigationService().pushWidget(GrommerAppointmentScreen());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              elevation: 0,
            ),
            child: Text(
              'book_service'.tr(),
              style: AppTextStyles.titleMedium.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
