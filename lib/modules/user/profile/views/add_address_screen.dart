import 'package:aleef/shared/assets/app_color.dart';
import 'package:aleef/shared/widgets/custom_phone_input.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final _buildingNameController = TextEditingController();
  final _apartmentNumberController = TextEditingController();
  final _floorController = TextEditingController();
  final _streetController = TextEditingController();
  final _phoneController = TextEditingController();
  final _distinctiveMarkController = TextEditingController();
  final _addressNameController = TextEditingController();

  static const Color _greyB0B0B0 = Color(0xFFB0B0B0);

  @override
  void dispose() {
    _buildingNameController.dispose();
    _apartmentNumberController.dispose();
    _floorController.dispose();
    _streetController.dispose();
    _phoneController.dispose();
    _distinctiveMarkController.dispose();
    _addressNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        title: Text(
          'add_address_title'.tr(),
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close, color: AppColor.primary, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Building Name
            const SizedBox(height: 16),
            TextFormField(
              controller: _buildingNameController,
              decoration: InputDecoration(
                hintText: 'building_name'.tr(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: _greyB0B0B0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: _greyB0B0B0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    color: AppColor.primary,
                    width: 2,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Apartment and Floor Row
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _apartmentNumberController,
                    decoration: InputDecoration(
                      hintText: 'apartment_number'.tr(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: _greyB0B0B0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: _greyB0B0B0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          color: Colors.green,
                          width: 2,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _floorController,
                    decoration: InputDecoration(
                      hintText: 'floor_optional'.tr(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: _greyB0B0B0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: _greyB0B0B0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          color: Colors.green,
                          width: 2,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Street
            TextFormField(
              controller: _streetController,
              decoration: InputDecoration(
                hintText: 'street'.tr(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: _greyB0B0B0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: _greyB0B0B0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.green, width: 2),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Mobile Phone Number
            CustomPhoneInput(
              controller: _phoneController,
              borderColor: _greyB0B0B0,
              arrowColor: AppColor.primary,
              onInputChanged: (value) {},
            ),
            const SizedBox(height: 16),

            // Distinctive Mark
            TextFormField(
              controller: _distinctiveMarkController,
              decoration: InputDecoration(
                hintText: 'distinctive_mark_optional'.tr(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: _greyB0B0B0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: _greyB0B0B0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.green, width: 2),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Address Name
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _addressNameController,
                  decoration: InputDecoration(
                    hintText: 'address_name_optional'.tr(),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: _greyB0B0B0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: _greyB0B0B0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Colors.green,
                        width: 2,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'address_naming_instruction'.tr(),
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.w500,

                      fontStyle: FontStyle.normal,
                      fontSize: 13,
                      height: 1.0, // 100% line height
                      letterSpacing: 0.0,
                      color: Color(0xFF7A7A7A),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),

            const Spacer(),

            // Save Address Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _saveAddress,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'save_address'.tr(),
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                    fontSize: 20,
                    height: 1.0, // 100% line height
                    letterSpacing: 0.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  void _saveAddress() {
    // Manual validation
    String buildingName = _buildingNameController.text.trim();
    String apartmentNumber = _apartmentNumberController.text.trim();
    String street = _streetController.text.trim();
    String phone = _phoneController.text.trim();

    if (buildingName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('required_field'.tr()),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (apartmentNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('required_field'.tr()),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (street.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('required_field'.tr()),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('required_field'.tr()),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // All validations passed, proceed with saving
    // TODO: Implement address saving logic
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('success'.tr()), backgroundColor: Colors.green),
    );
    Navigator.of(context).pop();
  }
}
