import 'package:aleef/modules/user/services/views/hotels_screen/hotel_booking_screen.dart';
import 'package:aleef/shared/assets/app_color.dart';
import 'package:aleef/shared/routes/navigation_routes.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HotelDetailsScreen extends StatelessWidget {
  const HotelDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColor.primary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'hotel_details'.tr(),
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
        ),
        centerTitle: true,
        actions: [],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hotel Image Carousel
            _buildImageCarousel(),

            // Hotel Overview Information
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hotel Name
                  Row(
                    children: [
                      Text(
                        'aleef_stay_hotel_for_animals'.tr(),
                        style: const TextStyle(
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                          fontSize: 16,
                          height: 1.0, // 100% line height
                          letterSpacing: 0.0,
                          color: Color(0xFF2D2D2D),
                        ),
                        textAlign: TextAlign.right,
                      ),
                      Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ...List.generate(
                                4,
                                (index) => Icon(
                                  index < 4 ? Icons.star : Icons.star_border,
                                  color: Colors.amber,
                                  size: 20.sp,
                                ),
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                '4.0',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),

                          Text(
                            '(${'based_on_reviews'.tr(namedArgs: {'count': '135'})})',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),

                  // Pet Friendly Badge
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/svg/dogs_track_one.svg',
                        width: 20.w,
                        height: 20.h,
                      ),
                      SizedBox(width: 8.w),

                      Text(
                        'cats_dogs'.tr(),
                        style: const TextStyle(
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: 15,
                          height: 1.0, // 100% line height
                          letterSpacing: 0.0,
                          color: Color(0xFF2D2D2D),
                        ),
                        textAlign: TextAlign.right,
                      ),
                      Spacer(),
                      SvgPicture.asset(
                        'assets/images/svg/location_point.svg',
                        width: 20.w,
                        height: 20.h,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        'al_khoudh_muscat'.tr(),
                        style: const TextStyle(
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: 14,
                          height: 1.0, // 100% line height
                          letterSpacing: 0.0,
                          color: Color(0xFF2D2D2D),
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),

                  SizedBox(height: 24.h),

                  // Available Services
                  Text(
                    'available_services'.tr(),
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 12.h),

                  _buildServiceItem('air_conditioned_rooms'.tr()),
                  _buildServiceItem('food_service'.tr()),
                  _buildServiceItem('play_area'.tr()),
                  _buildServiceItem('health_monitoring'.tr()),
                  _buildServiceItem('regular_cleaning'.tr()),

                  SizedBox(height: 24.h),

                  // Available Room Types
                  Text(
                    'available_room_types'.tr(),
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 16.h),

                  _buildRoomTypeCard(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageCarousel() {
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
                'assets/images/png/hotels_temp.jpg',
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

  Widget _buildServiceItem(String service) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(
        service,
        style: const TextStyle(
          fontFamily: 'Cairo',
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          fontSize: 17,
          height: 1.0, // 100% line height
          letterSpacing: 0.0,
          color: Color(0xFF2D2D2D),
        ),
      ),
    );
  }

  Widget _buildRoomTypeCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                'assets/images/svg/bed.svg',
                width: 20.w,
                height: 20.h,
              ),
              SizedBox(width: 8.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'standard_room'.tr(),
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    'suitable_for_one_animal'.tr(),
                    style: TextStyle(fontSize: 14.sp, color: Colors.grey[700]),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 12.h),

          Row(
            children: [
              SvgPicture.asset(
                'assets/images/svg/soap.svg',
                width: 20.w,
                height: 20.h,
              ),
              SizedBox(width: 8.w),
              Text(
                'daily_cleaning'.tr(),
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                  fontSize: 16.sp,
                  height: 1.0,
                  letterSpacing: 0.0,
                  color: Color(0xFF2D2D2D),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          Row(
            children: [
              SvgPicture.asset(
                'assets/images/svg/money_dollar.svg',
                width: 20.w,
                height: 20.h,
                color: AppColor.primary,
              ),
              SizedBox(width: 8.w),
              Text(
                'price_per_night'.tr(),
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                  fontSize: 16.sp,
                  height: 1.0,
                  letterSpacing: 0.0,
                  color: Color(0xFF2D2D2D),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),

          Padding(
            padding: EdgeInsets.only(right: 29.w),
            child: Text(
              'riyals_per_night'.tr(namedArgs: {'price': '4.5'}),
              style: const TextStyle(
                fontFamily: 'Cairo',
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.normal,
                fontSize: 16,
                height: 1.0, // 100% line height
                letterSpacing: 0.0,
                color: Color(0xFF2D2D2D),
              ),
              textAlign: TextAlign.right,
            ),
          ),
          SizedBox(height: 16.h),
          Center(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                // TODO: Implement booking functionality
                NavigationService().pushWidget(HotelBookingScreen());
              },
              child: Container(
                width: 305.w,
                height: 41.h,
                padding: EdgeInsets.only(right: 24.w, left: 24.w),
                decoration: BoxDecoration(
                  color: Color(0xFF6D9773),
                  borderRadius: BorderRadius.circular(15.r),
                  border: Border.all(color: Color(0xFF6D9773), width: 4),
                ),
                alignment: Alignment.center,
                child: Text(
                  'book_this_room'.tr(),
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                    fontSize: 14,
                    height: 1.0, // 100% line height
                    letterSpacing: 0.0,
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
}
