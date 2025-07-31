import 'package:aleef/modules/auth/views/auth_screens/user_auth_screens/user_auth_login.dart';
import 'package:aleef/modules/auth/views/auth_screens/user_auth_screens/user_otp_screen.dart';
import 'package:aleef/shared/assets/app_color.dart';
import 'package:aleef/shared/routes/navigation_routes.dart';
import 'package:aleef/shared/widgets/custom_phone_input.dart';
import 'package:aleef/shared/widgets/profile_image_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserAuthRegister extends StatefulWidget {
  const UserAuthRegister({super.key});

  @override
  State<UserAuthRegister> createState() => _UserAuthRegisterState();
}

class _UserAuthRegisterState extends State<UserAuthRegister> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
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
              SizedBox(height: 15.h),
              Center(
                child: Text(
                  "register_as_user".tr(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                    fontSize: 24,
                    height: 1.0, // 100% line height
                    letterSpacing: 0.0,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Center(
                child: ProfileImageWidget(
                  size: 120,
                  imageUrl: 'https://example.com/profile.jpg', // اختياري
                  onTap: () {
                    // وظيفة عند النقر على الصورة
                  },
                  showCameraIcon: true, // اختياري، افتراضي true
                ),
              ),
              SizedBox(height: 25.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'full_name'.tr(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                    fontSize: 20,
                    height: 1.0, // 100% line height
                    letterSpacing: 0.0,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 0,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          color: Color(0xFF6D9773),
                          width: 2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          color: Color(0xFF6D9773),
                          width: 2,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          color: Color(0xFF6D9773),
                          width: 2,
                        ),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    style: const TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ),
              ),
              SizedBox(height: 15.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'phone_number'.tr(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                    fontSize: 20,
                    height: 1.0, // 100% line height
                    letterSpacing: 0.0,
                  ),
                ),
              ),
              SizedBox(height: 15.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: CustomPhoneInput(onInputChanged: (value) {}),
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  // First text with Cairo, weight 400, regular, size 13, color #2D2D2D
                  Text(
                    'already_have_account'.tr(),
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 13,
                      height: 1.0, // 100% line height
                      letterSpacing: 0.0,
                      color: Color(0xFF2D2D2D),
                    ),
                  ),
                  SizedBox(width: 2),
                  // Second text with Cairo, weight 500, medium, size 13, color #0400FF, underline
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () =>
                        NavigationService().pushWidget(UserAuthLoginScreen()),
                    child: Text(
                      'login'.tr(),
                      style: const TextStyle(
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                        fontSize: 13,
                        height: 1.0, // 100% line height
                        letterSpacing: 0.0,
                        color: Color(0xFF0400FF),
                        decoration: TextDecoration.underline,
                        decorationColor: Color(0xFF0400FF),
                        decorationThickness: 1,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    'login_as_guest'.tr(),
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal,
                      fontSize: 13,
                      height: 1.0, // 100% line height
                      letterSpacing: 0.0,
                      color: Color(0xFF0400FF),
                      decoration: TextDecoration.underline,
                      decorationColor: Color(0xFF0400FF),
                      decorationThickness: 1,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40.h),
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
                      NavigationService().pushReplacementWidget(
                        UserOtpScreen(),
                      );
                    },
                    child: Text(
                      'create_account'.tr(),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
