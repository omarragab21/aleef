import 'package:aleef/modules/auth/views/auth_screens/vet_auth_screens/vet_auth_login.dart';
import 'package:aleef/shared/assets/app_color.dart';
import 'package:aleef/shared/routes/navigation_routes.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class VetSuccessSendData extends StatefulWidget {
  const VetSuccessSendData({super.key});

  @override
  State<VetSuccessSendData> createState() => _VetSuccessSendDataState();
}

class _VetSuccessSendDataState extends State<VetSuccessSendData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'request_sent_success'.tr(),
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                    fontSize: 24,
                    height: 1.0, // 100% line height
                    letterSpacing: 0.0,
                    color: Color(0xFF2D2D2D),
                  ),
                ),
                SizedBox(width: 5.w),
                Icon(Icons.check_circle_outline, color: Colors.green, size: 28),
              ],
            ),
            SizedBox(height: 30.h),
            Text(
              'request_under_review'.tr(),
              style: const TextStyle(
                fontFamily: 'Cairo',
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.normal,
                fontSize: 18,
                height: 1.0, // 100% line height
                letterSpacing: 0.0,
                color: Color(0xFF2D2D2D),
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              'approval_notification'.tr(),
              style: const TextStyle(
                fontFamily: 'Cairo',
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.normal,
                fontSize: 18,
                height: 1.0, // 100% line height
                letterSpacing: 0.0,
                color: Color(0xFF2D2D2D),
              ),
            ),
            SizedBox(height: 30.h),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                'assets/images/svg/vets.svg',
                height: 400.h,
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: SizedBox(
                width: double.infinity,
                height: 58.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: AppColor.teal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    NavigationService().pushWidget(VetAuthLoginScreen());
                  },
                  child: Text(
                    'back_to_login'.tr(),
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
