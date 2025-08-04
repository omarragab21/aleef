import 'package:aleef/modules/auth/views/auth_screens/user_auth_screens/user_auth_login.dart';
import 'package:aleef/shared/assets/app_color.dart';
import 'package:aleef/shared/routes/navigation_routes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as matetail;

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'dart:async';

class UserOtpScreen extends StatefulWidget {
  final String phone;
  const UserOtpScreen({super.key, required this.phone});

  @override
  State<UserOtpScreen> createState() => _UserOtpScreenState();
}

class _UserOtpScreenState extends State<UserOtpScreen> {
  late ValueNotifier<int> _countdownNotifier;
  late Timer _timer;
  static const int _initialSeconds = 60; // 60 minutes in seconds

  @override
  void initState() {
    super.initState();
    _countdownNotifier = ValueNotifier<int>(_initialSeconds);
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdownNotifier.value > 0) {
        _countdownNotifier.value--;
      } else {
        timer.cancel();
      }
    });
  }

  void _resetTimer() {
    _timer.cancel();
    _countdownNotifier.value = _initialSeconds;
    _startTimer();
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer.cancel();
    _countdownNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
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
            SizedBox(height: 20.h),
            Text(
              "verify_password".tr(),
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.normal,
                fontSize: 24,
                height: 1.0, // 100% line height
                letterSpacing: 0.0,
              ),
            ),
            SizedBox(height: 40.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Text(
                'verification_code_sent'.tr(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                  fontSize: 18,
                  height: 1.0, // 100% line height
                  letterSpacing: 0.0,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 25.h),
            Text(
              widget.phone,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Cairo',
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.normal,
                fontSize: 18,
                height: 1.0, // 100% line height
                letterSpacing: 0.0,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 25.h),
            Text(
              'enter_5_digit_code'.tr(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Cairo',
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.normal,
                fontSize: 18,
                height: 1.0, // 100% line height
                letterSpacing: 0.0,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 40.h),
            Directionality(
              textDirection: matetail.TextDirection.ltr,
              child: Pinput(
                length: 5,
                defaultPinTheme: PinTheme(
                  width: 56,
                  height: 56,
                  textStyle: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Color(0xFF6D9773), width: 1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                focusedPinTheme: PinTheme(
                  width: 56,
                  height: 56,
                  textStyle: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Color(0xFF6D9773), width: 1.5),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                submittedPinTheme: PinTheme(
                  width: 56,
                  height: 56,
                  textStyle: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Color(0xFF6D9773), width: 1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                showCursor: true,
              ),
            ),
            SizedBox(height: 25.h),
            ValueListenableBuilder<int>(
              valueListenable: _countdownNotifier,
              builder: (context, seconds, child) {
                return Text(
                  "${'code_expires_in'.tr()}  ${_formatTime(seconds)}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                    fontSize: 18,
                    height: 1.0, // 100% line height
                    letterSpacing: 0.0,
                    color: Colors.black,
                  ),
                );
              },
            ),
            SizedBox(height: 25.h),
            GestureDetector(
              onTap: _resetTimer,
              child: Text(
                'resend_code'.tr(),
                style: const TextStyle(
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                  fontSize: 20,
                  height: 1.0, // 100% line height
                  letterSpacing: 0.0,
                  color: Color(0xFF0400FF),
                  decoration: TextDecoration.underline,
                  decorationColor: Color(0xFF0400FF),
                  decorationThickness: 1,
                ),
              ),
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
                    NavigationService().pushReplacementWidget(
                      UserAuthLoginScreen(),
                    );
                  },
                  child: Text(
                    'confirm_code'.tr(),
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
