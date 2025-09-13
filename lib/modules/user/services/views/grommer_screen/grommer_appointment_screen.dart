import 'package:aleef/shared/routes/navigation_routes.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aleef/shared/assets/app_color.dart';

class GrommerAppointmentScreen extends StatefulWidget {
  const GrommerAppointmentScreen({super.key});

  @override
  State<GrommerAppointmentScreen> createState() =>
      _GrommerAppointmentScreenState();
}

class _GrommerAppointmentScreenState extends State<GrommerAppointmentScreen> {
  bool isServiceDropdownOpen = false;
  bool isPetDropdownOpen = false;

  // Service selections
  bool haircutSelected = true;
  bool earCleaningSelected = true;
  bool nailTrimmingSelected = false;

  // Location selection
  String selectedLocation = 'salon'; // 'salon' or 'home'

  // Selected pet
  String selectedPet = 'lulu';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColor.primary),
          onPressed: () => NavigationService().pop(),
        ),
        title: Text(
          'service_booking_details'.tr(),
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            fontFamily: 'Cairo',
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 9,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),

                  // Service Selection Section
                  _buildServiceSelectionSection(),

                  SizedBox(height: 24.h),

                  // Pet Selection Section
                  _buildPetSelectionSection(),

                  SizedBox(height: 24.h),

                  // Location Selection Section
                  _buildLocationSelectionSection(),

                  SizedBox(height: 24.h),
                  // INSERT_YOUR_CODE
                  // Date & Time Picker Section
                  StatefulBuilder(
                    builder: (context, setState) {
                      DateTime? selectedDate;
                      TimeOfDay? selectedTime;

                      // Helper to format date
                      String getDateText() {
                        if (selectedDate == null) return 'choose_date'.tr();
                        return "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}";
                      }

                      // Helper to format time
                      String getTimeText() {
                        if (selectedTime == null) return 'choose_time'.tr();
                        final hour = selectedTime!.hour.toString().padLeft(
                          2,
                          '0',
                        );
                        final minute = selectedTime!.minute.toString().padLeft(
                          2,
                          '0',
                        );
                        return "$hour:$minute";
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'choose_date_and_time'.tr(),
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              fontFamily: 'Cairo',
                            ),
                          ),
                          SizedBox(height: 12.h),
                          GestureDetector(
                            onTap: () async {
                              final now = DateTime.now();
                              final pickedDate = await showDatePicker(
                                context: context,
                                initialDate: selectedDate ?? now,
                                firstDate: now,
                                lastDate: DateTime(now.year + 2),
                              );
                              if (pickedDate != null) {
                                final pickedTime = await showTimePicker(
                                  context: context,
                                  initialTime: selectedTime ?? TimeOfDay.now(),
                                );
                                setState(() {
                                  selectedDate = pickedDate;
                                  selectedTime = pickedTime;
                                });
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 14.h,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: AppColor.primary,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(15.r),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.calendar_today,
                                    color: AppColor.primary,
                                    size: 20.sp,
                                  ),
                                  SizedBox(width: 12.w),
                                  Expanded(
                                    child: Text(
                                      selectedDate == null
                                          ? 'choose_date'.tr()
                                          : "${getDateText()}  ${selectedTime != null ? getTimeText() : ''}",
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        color: Colors.black,
                                        fontFamily: 'Cairo',
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Colors.grey[600],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(flex: 2, child: _buildConfirmBookingButton()),
        ],
      ),
    );
  }

  Widget _buildServiceSelectionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'choose_appropriate_service'.tr(),
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
            fontFamily: 'Cairo',
          ),
        ),
        SizedBox(height: 12.h),

        // Service Dropdown
        GestureDetector(
          onTap: () {
            setState(() {
              isServiceDropdownOpen = !isServiceDropdownOpen;
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
              border: Border.all(color: Color(0xFF6D9773), width: 1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'choose_service'.tr(),
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                    fontSize: 16,
                    height: 1.0, // 100% line height
                    letterSpacing: 0.0,
                    color: Color(0xFF2D2D2D),
                  ),
                ),
                Icon(
                  isServiceDropdownOpen
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: Colors.grey[600],
                ),
              ],
            ),
          ),
        ),

        // Service Options
        if (isServiceDropdownOpen) ...[
          SizedBox(height: 8.h),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColor.primary, width: 1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              children: [
                SizedBox(height: 8.h),
                _buildServiceOption('haircut_5_riyals'.tr(), haircutSelected, (
                  value,
                ) {
                  setState(() {
                    haircutSelected = value!;
                  });
                }),
                _buildServiceOption(
                  'ear_cleaning_2_riyals'.tr(),
                  earCleaningSelected,
                  (value) {
                    setState(() {
                      earCleaningSelected = value!;
                    });
                  },
                ),
                _buildServiceOption(
                  'nail_trimming_3_riyals'.tr(),
                  nailTrimmingSelected,
                  (value) {
                    setState(() {
                      nailTrimmingSelected = value!;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildServiceOption(
    String title,
    bool isSelected,
    Function(bool?) onChanged,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 18.w,
                height: 18.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: AppColor.primary, width: 2),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(4.r),
                  onTap: () => onChanged(!isSelected),
                  child: Center(
                    child: isSelected
                        ? Icon(Icons.done, color: AppColor.primary, size: 14.sp)
                        : null,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                    fontSize: 16,
                    height: 1.0, // 100% line height
                    letterSpacing: 0.0,
                    color: Color(0xFF2D2D2D),
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Container(
            width: double.infinity,
            height: 1.h,
            color: AppColor.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildPetSelectionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'choose_animal'.tr(),
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
            fontFamily: 'Cairo',
          ),
        ),
        SizedBox(height: 12.h),

        // Pet Dropdown
        GestureDetector(
          onTap: () {
            setState(() {
              isPetDropdownOpen = !isPetDropdownOpen;
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              border: Border.all(color: AppColor.primary, width: 1),
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'choose_animal'.tr(),
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.grey[600],
                    fontFamily: 'Cairo',
                  ),
                ),
                Icon(
                  isPetDropdownOpen
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: Colors.grey[600],
                ),
              ],
            ),
          ),
        ),

        // Pet Options
        if (isPetDropdownOpen) ...[
          SizedBox(height: 8.h),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColor.primary, width: 1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              children: [
                SizedBox(height: 8.h),
                _buildPetOption('lulu'.tr(), 'lulu'),
                _buildPetOption('oscar'.tr(), 'oscar'),
                _buildPetOption('bubble'.tr(), 'bubble'),
                SizedBox(height: 8.h),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildPetOption(String name, String value) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPet = value;
          isPetDropdownOpen = false;
        });
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 8.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),

        child: Column(
          children: [
            Row(
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.black,
                    fontFamily: 'Cairo',
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
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

  Widget _buildLocationSelectionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'choose_grooming_location'.tr(),
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
            fontFamily: 'Cairo',
          ),
        ),
        SizedBox(height: 12.h),

        // In Salon Option
        _buildLocationOption('in_salon'.tr(), 'salon'),
        SizedBox(height: 8.h),

        // At Home Option
        _buildLocationOption('at_home'.tr(), 'home'),
      ],
    );
  }

  Widget _buildLocationOption(String title, String value) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedLocation = value;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),

        child: Row(
          children: [
            Container(
              width: 18.w,
              height: 18.w,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: AppColor.primary, width: 1.4.r),
                borderRadius: BorderRadius.circular(1.r),
              ),
              child: Center(
                child: selectedLocation == value
                    ? Icon(Icons.done, color: AppColor.primary, size: 14.sp)
                    : null,
              ),
            ),
            SizedBox(width: 8.w),
            Text(
              title,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.black,
                fontFamily: 'Cairo',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConfirmBookingButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 40.h),
      child: SizedBox(
        width: double.infinity,
        height: 50.h,
        child: ElevatedButton(
          onPressed: () {
            // Handle booking confirmation
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('booking_confirmed'.tr()),
                backgroundColor: AppColor.primary,
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
          child: Text(
            'confirm_booking'.tr(),
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontFamily: 'Cairo',
            ),
          ),
        ),
      ),
    );
  }
}
