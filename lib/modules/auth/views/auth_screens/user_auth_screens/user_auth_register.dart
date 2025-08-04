import 'dart:developer';

import 'package:aleef/modules/auth/view_models/auth_view_model.dart';
import 'package:aleef/modules/auth/views/auth_screens/user_auth_screens/user_auth_login.dart';
import 'package:aleef/modules/auth/views/auth_screens/user_auth_screens/user_otp_screen.dart';
import 'package:aleef/shared/assets/app_color.dart';
import 'package:aleef/shared/constants/app_constants.dart';
import 'package:aleef/shared/routes/navigation_routes.dart';
import 'package:aleef/shared/widgets/custom_phone_input.dart';
import 'package:aleef/shared/widgets/profile_image_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:io';

import 'package:provider/provider.dart';

class UserAuthRegister extends StatefulWidget {
  const UserAuthRegister({super.key});

  @override
  State<UserAuthRegister> createState() => _UserAuthRegisterState();
}

class _UserAuthRegisterState extends State<UserAuthRegister> {
  File? _selectedProfileImage;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
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
                    imageUrl: null,
                    onImagePicked: (File? imageFile) {
                      setState(() {
                        _selectedProfileImage = imageFile;
                      });
                      if (imageFile != null) {
                        print('Profile image selected: ${imageFile.path}');
                        // TODO: Add your image upload logic here
                      }
                    },
                    showCameraIcon: true,
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
                      controller: _nameController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'full_name_required'.tr();
                        }
                        if (value.trim().length < 3) {
                          return 'full_name_min_length'.tr();
                        }
                        if (value.trim().length > 50) {
                          return 'full_name_max_length'.tr();
                        }
                        // Check if name contains only letters, spaces, and Arabic characters
                        final nameRegex = RegExp(
                          r'^[\u0600-\u06FF\u0750-\u077F\u08A0-\u08FF\uFB50-\uFDFF\uFE70-\uFEFFa-zA-Z\s]+$',
                        );
                        if (!nameRegex.hasMatch(value.trim())) {
                          return 'full_name_invalid'.tr();
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
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
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Colors.red,
                            width: 2,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Colors.red,
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
                        errorStyle: const TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                        ),
                      ),
                      style: const TextStyle(fontSize: 18, color: Colors.black),
                      textInputAction: TextInputAction.next,
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
                  child: CustomPhoneInput(
                    controller: _phoneController,
                    onInputChanged: (PhoneNumber value) {
                      // Handle phone number changes
                      print('Phone number: ${value.phoneNumber}');
                      _phoneController.text = value.phoneNumber ?? '';
                    },
                    onInputValidated: (bool isValid) {
                      // Handle validation
                      print('Phone validation: $isValid');
                    },
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'phone_number_required'.tr();
                      }
                      if (value.length < 8) {
                        return 'phone_number_invalid'.tr();
                      }
                      // Check if phone contains only numbers
                      final phoneRegex = RegExp(r'^[0-9]+$');
                      if (!phoneRegex.hasMatch(
                        value.replaceAll(RegExp(r'[^0-9]'), ''),
                      )) {
                        return 'phone_number_invalid'.tr();
                      }
                      return null;
                    },
                    borderColor: Color(0xFFE0E0E0),
                  ),
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
                      onPressed: () async {
                        // Validate the form
                        if (_formKey.currentState!.validate()) {
                          // Form is valid, proceed with account creation
                          log('Form is valid');
                          log('Name: ${_nameController.text}');
                          log('Phone: ${_phoneController.text}');
                          showDialog(
                            context: context,
                            builder: (context) => AppConstants.loadingScreen(),
                          );
                          Map<String, dynamic> data = {
                            'name': _nameController.text,
                            'phone': _phoneController.text,
                          };
                          log('data: $data');
                          if (_selectedProfileImage != null) {
                            data['image'] = _selectedProfileImage!.path;
                            // TODO: Upload image to server before proceeding
                            log('data: $data');
                            final response = await context
                                .read<AuthViewModel>()
                                .register(data);
                            log('response: $response');
                            Navigator.pop(context);
                            if (response['status'] == "success") {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(response['message']),
                                  backgroundColor: Colors.green,
                                ),
                              );
                              NavigationService().pushReplacementWidget(
                                UserOtpScreen(phone: _phoneController.text),
                              );
                            } else {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(response['message']),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          } else {
                            log('data: $data');
                            final response = await context
                                .read<AuthViewModel>()
                                .register(data);
                            log('response: $response');
                            Navigator.pop(context);
                            if (response['status'] == "success") {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(response['message'])),
                              );
                              NavigationService().pushReplacementWidget(
                                UserOtpScreen(phone: _phoneController.text),
                              );
                            } else {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(response['message'])),
                              );
                            }
                          }
                        } else {
                          // Form is invalid, show error message
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('please_fill_all_fields'.tr()),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
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
      ),
    );
  }
}
