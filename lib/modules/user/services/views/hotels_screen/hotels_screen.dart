import 'package:aleef/modules/user/services/views/hotels_screen/hotel_details_screen.dart';
import 'package:aleef/shared/routes/navigation_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:aleef/shared/assets/app_color.dart';
import 'package:aleef/shared/assets/app_text_styles.dart';

class HotelsScreen extends StatelessWidget {
  const HotelsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Title and search bar
            _buildTitleAndSearch(),

            // Hotel listings
            Expanded(child: _buildHotelListings()),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Time
          Text(
            '11:30',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColor.title,
              fontWeight: FontWeight.w500,
            ),
          ),

          // Status icons (signal, wifi, battery)
          Row(
            children: [
              Icon(
                Icons.signal_cellular_4_bar,
                size: 16,
                color: AppColor.title,
              ),
              SizedBox(width: 4.w),
              Icon(Icons.wifi, size: 16, color: AppColor.title),
              SizedBox(width: 4.w),
              Icon(Icons.battery_full, size: 16, color: AppColor.title),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTitleAndSearch() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        children: [
          // Title with arrow
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.arrow_back_ios, color: AppColor.primary, size: 24),
              Spacer(),
              Text(
                'hotels'.tr(),
                style: const TextStyle(
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                  fontSize: 24,
                  height: 1.0, // 100% line height
                  letterSpacing: 0.0,
                  color: Color(0xFF2D2D2D),
                ),
                textAlign: TextAlign.center,
              ),
              Spacer(),
            ],
          ),

          SizedBox(height: 16.h),

          // Search bar with filter
          SizedBox(
            width: double.infinity,
            height: 60.h,
            child: TextFormField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 0,
                ),
                filled: true,
                fillColor: Colors.white.withOpacity(1),
                hintText: 'hotel_search_placeholder'.tr(),
                hintStyle: const TextStyle(
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  fontSize: 16,
                  height: 1.0, // 100% line height
                  letterSpacing: 0.0,
                  color: Color(0xFF979797),
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: SvgPicture.asset(
                    'assets/images/svg/fliter_icon.svg',
                    width: 15.w,
                    height: 15.h,
                  ),
                ),
                prefixIconConstraints: BoxConstraints(
                  minWidth: 40,
                  minHeight: 40,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: AppColor.primary,
                  size: 24,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Color(0xFF6D9773), width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Color(0xFF6D9773), width: 2),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Color(0xFF6D9773), width: 2),
                ),
              ),
              style: AppTextStyles.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHotelListings() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      itemCount: 3, // Show 3 identical hotels as in the image
      itemBuilder: (context, index) {
        return _buildHotelCard();
      },
    );
  }

  Widget _buildHotelCard() {
    return GestureDetector(
      onTap: () {
        NavigationService().pushWidget(HotelDetailsScreen());
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColor.stroke2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Hotel details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hotel title
                  Text(
                    'hotel_aleef_stay_for_animals'.tr(),
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

                  SizedBox(height: 12.h),

                  // Pet types
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/svg/dog_tracks.svg',
                        width: 20.w,
                        height: 20.h,
                        colorFilter: ColorFilter.mode(
                          AppColor.primary,
                          BlendMode.srcIn,
                        ),
                      ),
                      SizedBox(width: 6.w),
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
                    ],
                  ),

                  SizedBox(height: 6.h),

                  // Location
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/svg/location_point.svg',
                        width: 20.w,
                        height: 20.h,
                        colorFilter: ColorFilter.mode(
                          AppColor.primary,
                          BlendMode.srcIn,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        'al_khoudh_muscat'.tr(),
                        style: const TextStyle(
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: 15,
                          height: 1.0, // 100% line height
                          letterSpacing: 0.0,
                          color: Color(0xFF2D2D2D),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 6.h),

                  // Price
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/svg/money_dollar.svg',
                        width: 20.w,
                        height: 20.h,
                        colorFilter: ColorFilter.mode(
                          AppColor.primary,
                          BlendMode.srcIn,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        '4.5 ${'riyals_per_day'.tr()}',
                        style: const TextStyle(
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: 15,
                          height: 1.0, // 100% line height
                          letterSpacing: 0.0,
                          color: Color(0xFF2D2D2D),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 6.h),

                  // Rating
                  Row(
                    children: [
                      Text(
                        '4.0',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColor.title,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Row(
                        children: List.generate(4, (index) {
                          if (index < 3) {
                            return Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 16,
                            );
                          } else {
                            return Icon(
                              Icons.star_half,
                              color: Colors.amber,
                              size: 16,
                            );
                          }
                        }),
                      ),
                    ],
                  ),

                  SizedBox(height: 12.h),

                  // Book now button
                  Container(
                    width: 188.w,
                    height: 32.h,
                    padding: EdgeInsets.only(right: 24.w, left: 24.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6D9773),
                      borderRadius: BorderRadius.circular(15.r),
                      border: Border.all(
                        color: const Color(0xFF6D9773),
                        width: 4,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'book_now'.tr(),
                        style: const TextStyle(
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                          fontSize: 14,
                          height: 1.0, // 100% line height
                          letterSpacing: 0.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 16.w),
            Container(
              width: 118.w,
              height: 170.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                image: DecorationImage(
                  image: AssetImage('assets/images/png/hotels_temp.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
