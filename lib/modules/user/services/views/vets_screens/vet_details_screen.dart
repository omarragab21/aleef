import 'package:aleef/shared/assets/app_color.dart';
import 'package:aleef/shared/assets/app_text_styles.dart';
import 'package:aleef/shared/routes/navigation_routes.dart';
import 'package:aleef/modules/user/services/views/vets_screens/book__appointment_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class VetDetailsScreen extends StatelessWidget {
  const VetDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _buildDoctorCard(
                name: 'د. محمد أحمد',
                specialization: 'الطب البيطري العام - 10 سنين خبرة',
                animalTypes: 'التخصص الحيواني : قطط, كلاب',
                rating: '5.0',
                reviews: '100',
                price: '2',
                imageUrl: 'assets/images/png/vet_person.jpg',
              ),
            ),
            SizedBox(height: 30.h),
            const _priceWidget(),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 30.w,
                  height: 30.h,
                  padding: EdgeInsets.only(right: 7.w),
                  decoration: BoxDecoration(
                    color: Color(0xFFD9D9D9),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 20,
                    color: AppColor.primary,
                  ),
                ),
                SizedBox(
                  height: 220,
                  width: MediaQuery.of(context).size.width * .80,
                  child: ListView.separated(
                    itemCount: 3,
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        NavigationService().pushWidget(BookAppointmentScreen());
                      },
                      child: _timePickWidget(),
                    ),
                    separatorBuilder: (context, index) => SizedBox(width: 10.w),
                  ),
                ),
                Container(
                  width: 30.w,
                  height: 30.h,
                  padding: EdgeInsets.only(left: 0.w),
                  decoration: BoxDecoration(
                    color: Color(0xFFD9D9D9),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                    color: AppColor.primary,
                  ),
                ),
              ],
            ),
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
}

class _priceWidget extends StatelessWidget {
  const _priceWidget({super.key});

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
                  'سعر الكشف: 20 ريال عماني',
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: AppColor.primary, width: 2),
                  ),
                  child: const Center(
                    child: Icon(Icons.done, color: AppColor.primary, size: 20),
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  'زيارة منزلية',
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Color(0xFF2D2D2D),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: AppColor.stroke2, width: 2),
                  ),
                  child: null,
                ),
                SizedBox(width: 10),
                Text(
                  'كشف عيادة',
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Color(0xFF2D2D2D),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
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
      ],
    ),
  );
}

class _AvailabilityCalendar extends StatelessWidget {
  const _AvailabilityCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(children: [_timePickWidget()]);
  }

  Widget _buildDayCard(int index) {
    final days = [
      {
        'name': 'اليوم',
        'date': 'Today',
        'available': true,
        'time': '10:00 ص - 05:00 م',
      },
      {
        'name': 'غدًا',
        'date': 'Tomorrow',
        'available': true,
        'time': '10:00 ص - 05:00 م',
      },
      {
        'name': 'الخميس',
        'date': '5/6',
        'available': false,
        'time': 'لا يوجد مواعيد متاحة',
      },
      {
        'name': 'الجمعة',
        'date': '6/6',
        'available': true,
        'time': '10:00 ص - 05:00 م',
      },
      {
        'name': 'السبت',
        'date': '7/6',
        'available': true,
        'time': '10:00 ص - 05:00 م',
      },
      {
        'name': 'الأحد',
        'date': '8/6',
        'available': false,
        'time': 'لا يوجد مواعيد متاحة',
      },
      {
        'name': 'الاثنين',
        'date': '9/6',
        'available': true,
        'time': '10:00 ص - 05:00 م',
      },
    ];

    final day = days[index];

    return Container(
      width: 100.w,
      margin: EdgeInsets.only(right: 12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: day['available'] == true
              ? AppColor.primary
              : Colors.grey.shade300,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header section with green background
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 8.h),
            decoration: BoxDecoration(
              color: AppColor.primary,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Column(
              children: [
                Text(
                  day['name'] as String,
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                    color: Colors.white,
                  ),
                ),
                if (day['date'] != 'Today' && day['date'] != 'Tomorrow')
                  Text(
                    day['date'] as String,
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                      color: Colors.white,
                    ),
                  ),
              ],
            ),
          ),

          // Middle section with availability info
          Expanded(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: const Color(0xFFF6F1E9),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    day['time'] as String,
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                      color: day['available'] == true
                          ? const Color(0xFF2D2D2D)
                          : Colors.grey.shade600,
                      height: 1.2,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),

          // Bottom section with booking button
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 8.h),
            decoration: BoxDecoration(
              color: day['available'] == true
                  ? AppColor.primary
                  : Colors.grey.shade400,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: Text(
              'أحجز',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class _timePickWidget extends StatelessWidget {
  const _timePickWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
                      'الخميس',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '10:00 ص - 05:00 م',
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
}
