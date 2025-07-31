import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:aleef/shared/assets/app_color.dart';

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

  // Set Oman as the initial country
  final PhoneNumber _initialPhoneNumber = PhoneNumber(isoCode: 'OM');

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? 358,
      height: widget.height ?? 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: widget.borderColor ?? AppColor.stroke2,
          width: 2,
        ),
      ),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: InternationalPhoneNumberInput(
          initialValue: _initialPhoneNumber,
          onInputChanged: (PhoneNumber number) {
            setState(() {
              completePhoneNumber = number.phoneNumber ?? "";
              isValidPhoneNumber =
                  number.phoneNumber != null && number.phoneNumber!.isNotEmpty;
            });
            widget.onInputChanged(number);
          },
          onInputValidated: (bool value) {
            setState(() {
              isValidPhoneNumber = value;
            });
            widget.onInputValidated?.call(value);
          },
          selectorConfig: const SelectorConfig(
            selectorType: PhoneInputSelectorType.DROPDOWN,
            showFlags: true,
            useEmoji: true,
            setSelectorButtonAsPrefixIcon: false,
            leadingPadding: 14,
            trailingSpace: false,
          ),
          ignoreBlank: false,
          autoValidateMode: AutovalidateMode.disabled,
          selectorTextStyle: const TextStyle(
            color: AppColor.title,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          textFieldController: widget.controller,
          keyboardType: const TextInputType.numberWithOptions(
            signed: true,
            decimal: true,
          ),
          inputDecoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 0,
              vertical: 16,
            ),
            border: InputBorder.none,
            hintText: widget.hintText ?? 'رقم الهاتف',
            hintStyle: const TextStyle(
              color: Color(0xFF9E9E9E),
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            filled: false,

            // Custom arrow styling
          ),
          formatInput: true,
          keyboardAction: TextInputAction.done,
          spaceBetweenSelectorAndTextField: 0,
          maxLength: 15,
          isEnabled: widget.isEnabled,
          locale: 'ar',
          countries: const [
            'EG',
            'SA',
            'AE',
            'KW',
            'QA',
            'BH',
            'OM',
            'JO',
            'LB',
            'SY',
            'IQ',
            'YE',
            'PS',
            'LY',
            'TN',
            'DZ',
            'MA',
            'SD',
            'SO',
            'DJ',
            'KM',
            'TD',
            'NE',
            'ML',
            'BF',
            'CI',
            'GH',
            'TG',
            'BJ',
            'NG',
          ],
          textStyle: const TextStyle(
            color: AppColor.title,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          cursorColor: AppColor.primary,
        ),
      ),
    );
  }
}
