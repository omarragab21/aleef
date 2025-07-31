import 'package:aleef/modules/auth/views/auth_screens/seller_auth_screens/seller_auth_register.dart';
import 'package:aleef/modules/auth/views/auth_screens/vet_auth_screens/vet_auth_login.dart';
import 'package:aleef/shared/assets/app_color.dart';
import 'package:aleef/shared/routes/navigation_routes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class TypeAccountScreen extends StatefulWidget {
  const TypeAccountScreen({super.key});

  @override
  State<TypeAccountScreen> createState() => _TypeAccountScreenState();
}

class _TypeAccountScreenState extends State<TypeAccountScreen> {
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
            TypeAccountWidget(
              svgPath: "assets/images/svg/stethoscope.svg",
              typeName: 'vet',
              onPressed: () {
                NavigationService().pushWidget(VetAuthLoginScreen());
              },
            ),
            SizedBox(height: 15.h),
            TypeAccountWidget(
              svgPath: "assets/images/svg/shopping_cart.svg",
              typeName: 'seller',
              onPressed: () {
                NavigationService().pushWidget(SellerAuthRegister());
              },
            ),
            SizedBox(height: 15.h),
            TypeAccountWidget(
              svgPath: "assets/images/svg/home.svg",
              typeName: 'hotel',
              onPressed: () {},
            ),
            SizedBox(height: 15.h),
            TypeAccountWidget(
              svgPath: "assets/images/svg/scissors.svg",
              typeName: 'groomer',
              onPressed: () {},
            ),
            SizedBox(height: 15.h),
            TypeAccountWidget(
              svgPath: "assets/images/svg/dog_trainer.svg",
              typeName: 'trainer',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class TypeAccountWidget extends StatelessWidget {
  final String svgPath, typeName;
  final Function()? onPressed;
  const TypeAccountWidget({
    super.key,
    required this.svgPath,
    required this.typeName,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SizedBox(
        width: double.infinity,
        height: 65.h,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 2,
            backgroundColor: Colors.white,
            side: BorderSide(width: 2, color: AppColor.primary),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              SvgPicture.asset(svgPath, color: Colors.black),
              SizedBox(width: 10.w),
              Text(
                typeName.tr(),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
