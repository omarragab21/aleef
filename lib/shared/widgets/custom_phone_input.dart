import 'package:flutter/material.dart';
import 'package:aleef/shared/assets/app_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PhoneNumber {
  final String? phoneNumber;
  final String? isoCode;

  PhoneNumber({this.phoneNumber, this.isoCode});
}

class CustomPhoneInput extends StatefulWidget {
  final Function(PhoneNumber) onInputChanged;
  final Function(bool)? onInputValidated;
  final String? initialValue;
  final String? hintText;
  final TextEditingController? controller;
  final bool isEnabled;
  final String? Function(String?)? validator;
  final Color? borderColor;
  final Color? arrowColor;
  final double? width;
  final double? height;

  const CustomPhoneInput({
    Key? key,
    required this.onInputChanged,
    this.onInputValidated,
    this.initialValue,
    this.hintText,
    this.controller,
    this.isEnabled = true,
    this.validator,
    this.borderColor,
    this.arrowColor,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  State<CustomPhoneInput> createState() => _CustomPhoneInputState();
}

class _CustomPhoneInputState extends State<CustomPhoneInput> {
  String completePhoneNumber = "";
  bool isValidPhoneNumber = false;
  String selectedCountryCode = "+968"; // Oman default
  final TextEditingController _phoneController = TextEditingController();

  final List<Map<String, String>> countries = [
    {'name': 'Oman', 'code': '+968', 'flag': '🇴🇲'},
    {'name': 'Egypt', 'code': '+20', 'flag': '🇪🇬'},
    {'name': 'Saudi Arabia', 'code': '+966', 'flag': '🇸🇦'},
    {'name': 'UAE', 'code': '+971', 'flag': '🇦🇪'},
    {'name': 'Kuwait', 'code': '+965', 'flag': '🇰🇼'},
    {'name': 'Qatar', 'code': '+974', 'flag': '🇶🇦'},
    {'name': 'Bahrain', 'code': '+973', 'flag': '🇧🇭'},
    {'name': 'Jordan', 'code': '+962', 'flag': '🇯🇴'},
    {'name': 'Lebanon', 'code': '+961', 'flag': '🇱🇧'},
    {'name': 'Syria', 'code': '+963', 'flag': '🇸🇾'},
    {'name': 'Iraq', 'code': '+964', 'flag': '🇮🇶'},
    {'name': 'Yemen', 'code': '+967', 'flag': '🇾🇪'},
    {'name': 'Palestine', 'code': '+970', 'flag': '🇵🇸'},
    {'name': 'Libya', 'code': '+218', 'flag': '🇱🇾'},
    {'name': 'Tunisia', 'code': '+216', 'flag': '🇹🇳'},
    {'name': 'Algeria', 'code': '+213', 'flag': '🇩🇿'},
    {'name': 'Morocco', 'code': '+212', 'flag': '🇲🇦'},
    {'name': 'Sudan', 'code': '+249', 'flag': '🇸🇩'},
    {'name': 'Somalia', 'code': '+252', 'flag': '🇸🇴'},
    {'name': 'Djibouti', 'code': '+253', 'flag': '🇩🇯'},
    {'name': 'Comoros', 'code': '+269', 'flag': '🇰🇲'},
    {'name': 'Chad', 'code': '+235', 'flag': '🇹🇩'},
    {'name': 'Niger', 'code': '+227', 'flag': '🇳🇪'},
    {'name': 'Mali', 'code': '+223', 'flag': '🇲🇱'},
    {'name': 'Burkina Faso', 'code': '+226', 'flag': '🇧🇫'},
    {'name': 'Ivory Coast', 'code': '+225', 'flag': '🇨🇮'},
    {'name': 'Ghana', 'code': '+233', 'flag': '🇬🇭'},
    {'name': 'Togo', 'code': '+228', 'flag': '🇹🇬'},
    {'name': 'Benin', 'code': '+229', 'flag': '🇧🇯'},
    {'name': 'Nigeria', 'code': '+234', 'flag': '🇳🇬'},
  ];

  @override
  void initState() {
    super.initState();
    if (widget.controller != null) {
      _phoneController.text = widget.controller!.text;
    }
    if (widget.initialValue != null) {
      _phoneController.text = widget.initialValue!;
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _updatePhoneNumber() {
    final phoneNumber = _phoneController.text;
    completePhoneNumber = selectedCountryCode + phoneNumber;
    isValidPhoneNumber = phoneNumber.isNotEmpty && phoneNumber.length >= 8;

    final phoneNumberObj = PhoneNumber(
      phoneNumber: completePhoneNumber,
      isoCode: selectedCountryCode,
    );

    widget.onInputChanged(phoneNumberObj);
    widget.onInputValidated?.call(isValidPhoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height ?? 56,
      margin: EdgeInsets.symmetric(horizontal: 0.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: widget.borderColor ?? AppColor.teal,
          width: 2,
        ),
      ),
      child: Row(
        children: [
          // Country code dropdown
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedCountryCode,
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  color: widget.arrowColor ?? AppColor.title,
                ),
                style: const TextStyle(
                  color: AppColor.title,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                items: countries.map((country) {
                  return DropdownMenuItem<String>(
                    value: country['code'],
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(country['flag']!),
                        const SizedBox(width: 8),
                        Text(country['code']!),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: widget.isEnabled
                    ? (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            selectedCountryCode = newValue;
                          });
                          _updatePhoneNumber();
                        }
                      }
                    : null,
              ),
            ),
          ),
          // Phone number input
          Expanded(
            child: TextField(
              controller: _phoneController,
              enabled: widget.isEnabled,
              keyboardType: TextInputType.phone,
              style: const TextStyle(
                color: AppColor.title,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                fillColor: Colors.white.withOpacity(1),
                border: InputBorder.none,
                hintText: widget.hintText ?? 'رقم الهاتف',
                hintStyle: const TextStyle(
                  color: Color(0xFF9E9E9E),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
              ),
              onChanged: (value) {
                _updatePhoneNumber();
              },
            ),
          ),
        ],
      ),
    );
  }
}
