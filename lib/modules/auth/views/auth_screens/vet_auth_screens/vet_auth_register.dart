import 'package:aleef/modules/auth/views/auth_screens/vet_auth_screens/vet_auth_otp.dart';
import 'package:aleef/modules/auth/views/auth_screens/vet_auth_screens/vet_success_send_data.dart';
import 'package:aleef/shared/assets/app_color.dart';
import 'package:aleef/shared/routes/navigation_routes.dart';
import 'package:aleef/shared/widgets/custom_phone_input.dart';
import 'package:aleef/shared/widgets/profile_image_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VetAuthRegister extends StatefulWidget {
  VetAuthRegister({Key? key}) : super(key: key);

  @override
  _VetAuthRegisterState createState() => _VetAuthRegisterState();
}

class _VetAuthRegisterState extends State<VetAuthRegister> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          color: AppColor.teal,
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
                  "register_as_seller".tr(),
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
                  imageUrl: 'https://example.com/profile.jpg',
                  color: AppColor.teal,
                  colorBackground: AppColor.lightCyan, // اختياري
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
                  padding: const EdgeInsets.symmetric(horizontal: 17),
                  child: TextFormField(
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          color: AppColor.teal,
                          width: 2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          color: AppColor.teal,
                          width: 2,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          color: AppColor.teal,
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
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: CustomPhoneInput(onInputChanged: (value) {}),
              ),
              SizedBox(height: 25.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'specialization'.tr(),
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
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(1),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: AppColor.teal, width: 2),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: null,
                      hint: Text(
                        "  ${'specialization'.tr()}",
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 18,
                        ),
                      ),
                      isExpanded: true,
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black54,
                      ),
                      items:
                          <String>[
                            'General',
                            'Surgery',
                            'Dermatology',
                            'Dentistry',
                            'Ophthalmology',
                            'Cardiology',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                            );
                          }).toList(),
                      onChanged: (String? newValue) {
                        // Handle dropdown value change
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25.h),
              Container(
                width: double.infinity,
                height: 56,
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                decoration: BoxDecoration(
                  color: Colors.white, // #4EB3C1 with 20% opacity
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: const Color(0xFF4EB3C1), width: 2),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width: 16),
                    Text(
                      'upload_pdf_or_image'.tr(),
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                        fontSize: 20,
                        height: 1.0, // 100% line height
                        letterSpacing: 0.0,
                        color: Colors.black,
                      ),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.document_scanner,
                      color: AppColor.teal,
                      size: 28,
                    ),
                    const SizedBox(width: 16),
                  ],
                ),
              ),
              SizedBox(height: 25.h),
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
                      NavigationService().pushWidget(VetOtpScreen());
                    },
                    child: Text(
                      'upload_store_documents'.tr(),
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
