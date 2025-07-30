import 'package:aleef/modules/auth/views/auth_screens/auth_type_screen.dart';
import 'package:aleef/shared/assets/app_color.dart';
import 'package:aleef/shared/routes/navigation_routes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<String> _svg = [
    "assets/images/svg/onboarding_1.svg",
    "assets/images/svg/onboarding_2.svg",
    "assets/images/svg/onboarding_3.svg",
  ];
  final List<String> _titles = [
    "track_pet_health",
    "book_vet_visit",
    "shop_pet_supplies",
  ];

  final List<String> _subTitles = [
    "create_medical_file",
    "choose_doctor_video",
    "shop_from_top_stores",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _svg.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 40),
                      SvgPicture.asset(_svg[index], height: 300.h),
                      SizedBox(height: 48),
                      // Title
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 0.0),
                        child: Text(
                          _titles[index].tr(),
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 24),
                      // Subtitle
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.0),
                        child: Text(
                          _subTitles[index].tr(),
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            // Next button
            Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              child: _currentIndex == _svg.length - 1
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: 58.h,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          onPressed: () {
                            NavigationService().pushWidget(AuthTypeScreen());
                          },
                          child: Text(
                            "start_now".tr(),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: 'Cairo',
                            ),
                          ),
                        ),
                      ),
                    )
                  : Align(
                      alignment: context.locale.languageCode == 'ar'
                          ? Alignment.bottomRight
                          : Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: const Color(0xFF7A9B7A),
                          child: IconButton(
                            padding: EdgeInsets.all(0),
                            icon: Padding(
                              padding: EdgeInsets.only(right: 9.w),
                              child: Icon(
                                context.locale.languageCode == 'ar'
                                    ? Icons.arrow_back_ios
                                    : Icons.arrow_forward_ios_rounded,
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {
                              // TODO: Add navigation logic
                              if (_currentIndex < _svg.length - 1) {
                                _pageController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
