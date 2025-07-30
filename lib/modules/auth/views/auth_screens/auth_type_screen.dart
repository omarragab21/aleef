import 'package:aleef/modules/auth/views/auth_screens/service_provider_screens/type_account_screen.dart';
import 'package:aleef/shared/assets/app_color.dart';
import 'package:aleef/shared/assets/app_text_styles.dart';
import 'package:aleef/shared/routes/navigation_routes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class AuthTypeScreen extends StatefulWidget {
  const AuthTypeScreen({super.key});

  @override
  State<AuthTypeScreen> createState() => _AuthTypeScreenState();
}

class _AuthTypeScreenState extends State<AuthTypeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: context.locale.languageCode == 'ar'
                  ? AlignmentDirectional.centerStart
                  : AlignmentDirectional.bottomEnd,
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
            const SizedBox(height: 10),
            Center(
              child: Image.asset(
                'assets/images/png/welcome_screen.png',
                height: 200.h,
                width: 200.w,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 30.h),
            Center(
              child: Text(
                'account_type'.tr(),
                style: AppTextStyles.bodySmall.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  fontSize: 26.sp,
                ),
              ),
            ),
            Center(
              child: Text(
                'login_as'.tr(),
                style: AppTextStyles.bodySmall.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  fontSize: 20.sp,
                ),
              ),
            ),
            SizedBox(height: 30.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                width: double.infinity,
                height: 65.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: AppColor.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SvgPicture.asset('assets/images/svg/user.svg'),
                      SizedBox(width: 10.w),
                      Text(
                        'user'.tr(),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                width: double.infinity,
                height: 65.h,
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
                    NavigationService().pushWidget(TypeAccountScreen());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SvgPicture.asset('assets/images/svg/dashboard.svg'),
                      SizedBox(width: 10.w),
                      Text(
                        'service_provider'.tr(),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Spacer(),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: SvgPicture.asset('assets/images/svg/dog_tracks.svg'),
            ),
          ],
        ),
      ),
    );
  }
}
