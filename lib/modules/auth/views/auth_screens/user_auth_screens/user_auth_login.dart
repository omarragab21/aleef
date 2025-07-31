import 'package:aleef/shared/assets/app_color.dart';
import 'package:aleef/shared/index.dart';
import 'package:aleef/shared/routes/navigation_routes.dart';
import 'package:aleef/shared/widgets/custom_phone_input.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserAuthLoginScreen extends StatefulWidget {
  const UserAuthLoginScreen({super.key});

  @override
  State<UserAuthLoginScreen> createState() => _UserAuthLoginScreenState();
}

class _UserAuthLoginScreenState extends State<UserAuthLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Align(
                  alignment: context.locale.languageCode == 'ar'
                      ? AlignmentDirectional.centerStart
                      : AlignmentDirectional.bottomEnd,
                  child: Padding(
                    padding: EdgeInsets.only(top: 5.h),
                    child: IconButton(
                      onPressed: () => NavigationService().pop(),
                      icon: Icon(
                        context.locale.languageCode == 'ar'
                            ? Icons.arrow_back_ios
                            : Icons.arrow_forward_ios,
                        color: AppColor.primary,
                        size: 20,
                      ),
                    ),
                  ),
                ),
                Spacer(),

                Center(
                  child: Image.asset(
                    'assets/images/png/welcome_screen.png',
                    height: 200.h,
                    width: 200.w,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 40.w),
                Spacer(),
              ],
            ),
            SizedBox(height: 30.h),
            Center(
              child: Text(
                'login_as_user'.tr(), // "Login" in Arabic, adjust as needed
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                  fontSize: 24,
                  height: 1.0, // 100% line height
                  letterSpacing: 0.0,
                ),
              ),
            ),
            SizedBox(height: 70.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'phone_number'.tr(), // Example text, replace as needed
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                    fontSize: 20,
                    height: 1.0, // 100% line height
                    letterSpacing: 0.0,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CustomPhoneInput(onInputChanged: (value) {}),
            ),
            Spacer(),
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
                    // NavigationService().pushWidget(OnboardingScreen());
                  },
                  child: Text(
                    'login'.tr(),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
