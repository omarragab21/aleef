import 'package:aleef/modules/user/main/views/main_screen.dart';
import 'package:aleef/shared/assets/app_color.dart';
import 'package:aleef/shared/routes/navigation_routes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class UserLocationScreen extends StatefulWidget {
  const UserLocationScreen({super.key});

  @override
  State<UserLocationScreen> createState() => _UserLocationScreenState();
}

class _UserLocationScreenState extends State<UserLocationScreen> {
  // Oman governorates list
  final List<String> omanGovernorates = [
    'Muscat',
    'Dhofar',
    'Musandam',
    'Al Buraimi',
    'Ad Dakhiliyah',
    'North Al Batinah',
    'South Al Batinah',
    'South Ash Sharqiyah',
    'North Ash Sharqiyah',
    'Al Dhahirah',
    'Al Wusta',
  ];

  final List<String> omanAreasOrStates = [
    'Al Seeb',
    'Bawshar',
    'Muttrah',
    'Al Amerat',
    'Salalah',
    'Taqah',
    'Mirbat',
    'Khasab',
    'Dibba',
    'Madha',
    'Al Buraimi City',
    'Mahdah',
    'Ibri',
    'Yanqul',
    'Nizwa',
    'Bahla',
    'Adam',
    'Sohar',
    'Shinas',
    'Liwa',
    'Saham',
    'Barka',
    'Nakhal',
    'Al Khaburah',
    'Al Suwaiq',
    'Sur',
    'Ibra',
    'Al Mudhaibi',
    'Haima',
    'Duqm',
    'Mahout',
    // Add more as needed
  ];

  String? selectedGovernorate;
  String? selectedAreaOrState;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 24.0,
                  ),
                  child: Icon(Icons.arrow_back_ios, color: AppColor.primary),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 24.0,
                  ),
                  child: Text(
                    'choose_geographical_region'.tr(),
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                      fontSize: 24,
                      height: 1.0,
                      letterSpacing: 0,
                      color: Color(0xFF2D2D2D),
                    ),
                  ),
                ),
                Spacer(),
                SizedBox(width: 50.w),
              ],
            ),
            SizedBox(height: 50.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'governorates'.tr(),
                style: const TextStyle(
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                  fontSize: 16,
                  height: 1.0,
                  letterSpacing: 0,
                  color: Color(0xFF2D2D2D),
                ),
              ),
            ),
            SizedBox(height: 20.h),

            StatefulBuilder(
              builder: (context, setState) {
                return Center(
                  child: Container(
                    width: double.infinity,
                    height: 55,
                    padding: const EdgeInsets.symmetric(
                      vertical: 9,
                      horizontal: 13,
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFFA4D4AE),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: const Color(0xFF6D9773),
                        width: 2,
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedGovernorate,
                        isExpanded: true,
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Color(0xFF2D2D2D),
                        ),
                        style: const TextStyle(
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Color(0xFF2D2D2D),
                        ),
                        hint: Text(
                          'choose_location'.tr(),
                          style: const TextStyle(
                            color: Color(0xFF2D2D2D),
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedGovernorate = newValue;
                          });
                        },
                        items: omanGovernorates.map<DropdownMenuItem<String>>((
                          String value,
                        ) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 20.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'areas_or_states'.tr(),
                style: const TextStyle(
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                  fontSize: 16,
                  height: 1.0,
                  letterSpacing: 0,
                  color: Color(0xFF2D2D2D),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            StatefulBuilder(
              builder: (context, setState) {
                return Center(
                  child: Container(
                    width: double.infinity,
                    height: 55,
                    padding: const EdgeInsets.symmetric(
                      vertical: 9,
                      horizontal: 13,
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFFA4D4AE),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: const Color(0xFF6D9773),
                        width: 2,
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedAreaOrState,
                        isExpanded: true,
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Color(0xFF2D2D2D),
                        ),
                        style: const TextStyle(
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Color(0xFF2D2D2D),
                        ),
                        hint: Text(
                          'choose_location'.tr(),
                          style: const TextStyle(
                            color: Color(0xFF2D2D2D),
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedAreaOrState = newValue;
                          });
                        },
                        items: omanAreasOrStates.map<DropdownMenuItem<String>>((
                          String value,
                        ) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                );
              },
            ),
            Spacer(),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SvgPicture.asset(
                  'assets/images/svg/dog_tracks.svg',
                  width: 200.w,
                  height: 200.h,
                ),
              ),
            ),
            SizedBox(height: 30.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                width: double.infinity,
                height: 58.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: AppColor.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    NavigationService().pushReplacementWidget(MainScreen());
                  },
                  child: Text(
                    'save_location'.tr(),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
