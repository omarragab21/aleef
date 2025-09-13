import 'package:aleef/modules/user/services/views/hotels_screen/pet_booking.dart';
import 'package:aleef/shared/routes/navigation_routes.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aleef/shared/assets/app_color.dart';
import 'package:aleef/shared/assets/app_text_styles.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter_svg/svg.dart';

class HotelBookingScreen extends StatefulWidget {
  const HotelBookingScreen({super.key});

  @override
  State<HotelBookingScreen> createState() => _HotelBookingScreenState();
}

class _HotelBookingScreenState extends State<HotelBookingScreen> {
  String? selectedPet;
  List<DateTime?> _dates = [];
  bool isPetDropdownExpanded = false;
  bool isDateDropdownExpanded = false;

  final List<String> pets = ['lulu'.tr(), 'oscar'.tr(), 'bubble'.tr()];

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
          'book_stay_for_pet'.tr(),
          style: AppTextStyles.titleLarge.copyWith(
            color: AppColor.title,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Select Pet Section
            _buildSelectPetSection(),
            SizedBox(height: 24.h),

            // Select Stay Duration Section
            _buildSelectStayDurationSection(),
            SizedBox(height: 32.h),

            // Continue Button
            _buildContinueButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectPetSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'select_pet'.tr(),
          style: AppTextStyles.titleMedium.copyWith(
            color: AppColor.title,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12.h),

        // Pet Selection Dropdown
        GestureDetector(
          onTap: () {
            setState(() {
              isPetDropdownExpanded = !isPetDropdownExpanded;
            });
          },
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            decoration: BoxDecoration(
              border: Border.all(color: AppColor.primary, width: 1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              children: [
                Icon(
                  isPetDropdownExpanded
                      ? Icons.keyboard_arrow_down
                      : Icons.keyboard_arrow_up,
                  color: AppColor.primary,
                  size: 24.sp,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    selectedPet ?? 'select_pet'.tr(),
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: selectedPet != null
                          ? AppColor.title
                          : AppColor.lightGray,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Pet Options List
        if (isPetDropdownExpanded)
          Container(
            margin: EdgeInsets.only(top: 8.h),
            decoration: BoxDecoration(
              border: Border.all(color: AppColor.primary, width: 1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              children: pets.map((pet) => _buildPetOption(pet)).toList(),
            ),
          ),
      ],
    );
  }

  Widget _buildPetOption(String petName) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPet = petName;
          isPetDropdownExpanded = false;
        });
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: selectedPet == petName
              ? AppColor.primary.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              petName,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColor.title,
                fontWeight: selectedPet == petName
                    ? FontWeight.w600
                    : FontWeight.normal,
              ),
            ),
            SizedBox(height: 5.h),
            Container(
              width: double.infinity,
              height: 1.h,
              color: AppColor.primary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectStayDurationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'select_stay_duration'.tr(),
          style: AppTextStyles.titleMedium.copyWith(
            color: AppColor.title,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12.h),

        // Date Selection Dropdown
        GestureDetector(
          onTap: () {
            setState(() {
              isDateDropdownExpanded = !isDateDropdownExpanded;
            });
          },
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            decoration: BoxDecoration(
              border: Border.all(color: AppColor.primary, width: 1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              children: [
                Icon(
                  isDateDropdownExpanded
                      ? Icons.keyboard_arrow_down
                      : Icons.keyboard_arrow_up,
                  color: AppColor.primary,
                  size: 24.sp,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    _dates.isNotEmpty && _dates.length >= 2
                        ? '${_formatDate(_dates.first!)} - ${_formatDate(_dates.last!)}'
                        : 'arrival_departure_date'.tr(),
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: _dates.isNotEmpty && _dates.length >= 2
                          ? AppColor.title
                          : AppColor.lightGray,
                    ),
                  ),
                ),
                SvgPicture.asset(
                  'assets/images/svg/calender.svg',
                  width: 24.w,
                  height: 24.h,
                  color: AppColor.primary,
                ),
              ],
            ),
          ),
        ),
        if (isDateDropdownExpanded) SizedBox(height: 12.h),
        if (isDateDropdownExpanded)
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: 275.w,
              height: 200.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: AppColor.primary, width: 1),
              ),
              child: CalendarDatePicker2(
                config: CalendarDatePicker2Config(
                  calendarType: CalendarDatePicker2Type.range,
                  firstDayOfWeek: 1,
                  selectedRangeHighlightColor: AppColor.primary.withOpacity(
                    0.3,
                  ),
                  selectedDayHighlightColor: AppColor.primary,
                  dayTextStyle: AppTextStyles.bodySmall.copyWith(
                    color: AppColor.title,
                    fontWeight: FontWeight.w500,
                  ),
                  yearTextStyle: AppTextStyles.titleSmall.copyWith(
                    color: AppColor.title,
                    fontWeight: FontWeight.w600,
                  ),
                  monthTextStyle: AppTextStyles.titleSmall.copyWith(
                    color: AppColor.title,
                    fontWeight: FontWeight.w600,
                  ),
                  weekdayLabelTextStyle: AppTextStyles.bodySmall.copyWith(
                    color: AppColor.lightGray,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                value: _dates,
                onValueChanged: (dates) {
                  setState(() {
                    _dates = dates;
                    if (_dates.length >= 2) {
                      isDateDropdownExpanded = false;
                    }
                  });
                },
              ),
            ),
          ),

        // Calendar Widget
        // if (isDateDropdownExpanded)
        // Container(
        //   margin: EdgeInsets.only(top: 9.h),
        //   padding: EdgeInsets.all(16.w),
        //   decoration: BoxDecoration(
        //     border: Border.all(color: AppColor.primary, width: 1),
        //     borderRadius: BorderRadius.circular(12.r),
        //   ),
        //   child: CalendarDatePicker2(
        //     config: CalendarDatePicker2Config(
        //       calendarType: CalendarDatePicker2Type.range,
        //       firstDayOfWeek: 1,
        //       selectedRangeHighlightColor: AppColor.primary.withOpacity(0.3),
        //       selectedDayHighlightColor: AppColor.primary,
        //       dayTextStyle: AppTextStyles.bodySmall.copyWith(
        //         color: AppColor.title,
        //         fontWeight: FontWeight.w500,
        //       ),
        //       yearTextStyle: AppTextStyles.titleSmall.copyWith(
        //         color: AppColor.title,
        //         fontWeight: FontWeight.w600,
        //       ),
        //       monthTextStyle: AppTextStyles.titleSmall.copyWith(
        //         color: AppColor.title,
        //         fontWeight: FontWeight.w600,
        //       ),
        //       weekdayLabelTextStyle: AppTextStyles.bodySmall.copyWith(
        //         color: AppColor.lightGray,
        //         fontWeight: FontWeight.w500,
        //       ),
        //     ),
        //     value: _dates,
        //     onValueChanged: (dates) {
        //       setState(() {
        //         _dates = dates;
        //         if (_dates.length >= 2) {
        //           isDateDropdownExpanded = false;
        //         }
        //       });
        //     },
        //   ),
        // ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  Widget _buildContinueButton() {
    bool canContinue =
        selectedPet != null && _dates.isNotEmpty && _dates.length >= 2;

    return Container(
      width: double.infinity,
      height: 56.h,
      child: ElevatedButton(
        onPressed: canContinue
            ? () {
                // TODO: Navigate to next step
                NavigationService().pushWidget(PetBooking());
              }
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: canContinue ? AppColor.primary : AppColor.lightGray,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          elevation: 0,
        ),
        child: Text(
          'continue'.tr(),
          style: AppTextStyles.titleMedium.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
