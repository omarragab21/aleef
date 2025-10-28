import 'package:aleef/modules/user/profile/views/add_address_screen.dart';
import 'package:aleef/shared/routes/navigation_routes.dart';
import 'package:aleef/shared/widgets/custom_phone_input.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import '../view_models/profile_view_model.dart';
import '../models/profile_model.dart';
import '../../../../shared/assets/app_color.dart';
import '../../../../shared/assets/app_text_styles.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _dateOfBirthController = TextEditingController();

  String _selectedGender = 'male';
  bool _isEditing = false;
  ProfileModel? _profile;

  @override
  void initState() {
    super.initState();
    // Load profile data when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadProfileData();
    });
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _dateOfBirthController.dispose();
    super.dispose();
  }

  Future<void> _loadProfileData() async {
    final profileViewModel = context.read<ProfileViewModel>();
    await profileViewModel.loadProfile();

    if (profileViewModel.profile != null) {
      setState(() {
        _profile = profileViewModel.profile;
        _populateFields();
      });
    }
  }

  void _populateFields() {
    if (_profile != null) {
      _fullNameController.text = _profile!.fullName;
      _phoneController.text = _profile!.phone ?? '';
      _emailController.text = _profile!.email ?? '';
      _selectedGender = _profile!.gender ?? 'male';

      if (_profile!.dateOfBirth != null) {
        final date = _profile!.dateOfBirth!;
        _dateOfBirthController.text =
            '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColor.primary),
          iconSize: 18,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'my_account'.tr(),
          style: const TextStyle(
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
            fontSize: 20,
            height: 1.0, // 100% line height
            letterSpacing: 0.0,
          ),
          textAlign: TextAlign.right,
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _isEditing = !_isEditing;
              });
            },
            child: Text(
              'edit'.tr(),
              style: const TextStyle(
                fontFamily: 'Cairo',
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.normal,
                fontSize: 20,
                height: 1.0, // 100% line height
                letterSpacing: 0.0,
                color: Color(0xFF6D9773),
              ),
            ),
          ),
        ],
      ),
      body: Consumer<ProfileViewModel>(
        builder: (context, profileViewModel, child) {
          if (profileViewModel.isLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColor.primary),
            );
          }

          if (profileViewModel.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Error: ${profileViewModel.error}',
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => _loadProfileData(),
                    child: Text('retry'.tr()),
                  ),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),

                  // Full Name Field
                  _buildInputField(
                    label: 'full_name'.tr(),
                    controller: _fullNameController,
                    enabled: _isEditing,
                  ),

                  const SizedBox(height: 24),

                  // Phone Number Field
                  _buildPhoneField(),

                  const SizedBox(height: 24),

                  // Email Field
                  _buildInputField(
                    label: 'email'.tr(),
                    controller: _emailController,
                    enabled: _isEditing,
                    keyboardType: TextInputType.emailAddress,
                  ),

                  const SizedBox(height: 24),

                  // Date of Birth Field
                  _buildDateField(),

                  const SizedBox(height: 24),

                  // Gender Selection
                  _buildGenderSelection(),

                  const SizedBox(height: 24),

                  // Address Section
                  _buildAddressSection(),

                  const SizedBox(height: 40),

                  // Save Button
                  _buildSaveButton(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required bool enabled,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
            fontSize: 20,
            height: 1.0, // 100% line height
            letterSpacing: 0.0,
          ),
          textAlign: TextAlign.right,
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          enabled: enabled,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: label,
            hintStyle: AppTextStyles.bodyMedium.copyWith(
              color: AppColor.title,
              fontWeight: FontWeight.w500,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFB0B0B0), width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFB0B0B0), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFB0B0B0), width: 1),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
          style: AppTextStyles.bodyMedium.copyWith(color: AppColor.title),
        ),
      ],
    );
  }

  Widget _buildPhoneField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'phone_number'.tr(),
          style: const TextStyle(
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
            fontSize: 20,
            height: 1.0, // 100% line height
            letterSpacing: 0.0,
          ),
          textAlign: TextAlign.right,
        ),
        const SizedBox(height: 8),
        CustomPhoneInput(
          onInputChanged: (value) {
            _phoneController.text = value.phoneNumber ?? '';
          },
          initialValue:
              _profile?.phone?.replaceAll(RegExp(r'^\+\d+'), '') ?? '',
          borderColor: const Color(0xFFE0E0E0),
          isEnabled: _isEditing,
        ),
      ],
    );
  }

  Widget _buildDateField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'date_of_birth'.tr(),
          style: const TextStyle(
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
            fontSize: 20,
            height: 1.0, // 100% line height
            letterSpacing: 0.0,
          ),
          textAlign: TextAlign.right,
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _dateOfBirthController,
          enabled: _isEditing,
          decoration: InputDecoration(
            hintText: 'dd/mm/yyyy',
            hintStyle: AppTextStyles.bodyMedium.copyWith(color: AppColor.title),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFB0B0B0), width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFB0B0B0), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFB0B0B0), width: 1),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
          style: AppTextStyles.bodyMedium.copyWith(color: AppColor.title),
          keyboardType: TextInputType.datetime,

          onTap: () {
            _selectDate();
          },
        ),
      ],
    );
  }

  Widget _buildGenderSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'gender'.tr(),
          style: const TextStyle(
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
            fontSize: 20,
            height: 1.0, // 100% line height
            letterSpacing: 0.0,
          ),
          textAlign: TextAlign.right,
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildGenderButton(
                text: 'male'.tr(),
                isSelected: _selectedGender == 'male',
                onTap: _isEditing
                    ? () => setState(() => _selectedGender = 'male')
                    : null,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildGenderButton(
                text: 'female'.tr(),
                isSelected: _selectedGender == 'female',
                onTap: _isEditing
                    ? () => setState(() => _selectedGender = 'female')
                    : null,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildGenderButton({
    required String text,
    required bool isSelected,
    required VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColor.lightGreen : const Color(0xFFB0B0B0),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
            fontSize: 20,
            height: 1.0, // 100% line height
            letterSpacing: 0.0,
            color: isSelected ? Colors.white : Color(0xFF2D2D2D),
          ),
        ),
      ),
    );
  }

  Widget _buildAddressSection() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        NavigationService().pushWidget(const AddAddressScreen());
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'address'.tr(),
            style: const TextStyle(
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.normal,
              fontSize: 20,
              height: 1.0, // 100% line height
              letterSpacing: 0.0,
            ),
            textAlign: TextAlign.right,
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color: AppColor.lightGreen,
              borderRadius: BorderRadius.circular(15),
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFFFFFFFF).withOpacity(0.8),
                  width: 10,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.add, color: Colors.white, size: 20),
                const SizedBox(width: 8),
                Text(
                  'add_address'.tr(),
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                    fontSize: 20,
                    height: 1.0, // 100% line height
                    letterSpacing: 0.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          _saveProfile();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: Text(
          'save'.tr(),
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
    );
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _dateOfBirthController.text =
            '${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}';
      });
    }
  }

  Future<void> _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      try {
        final profileViewModel = context.read<ProfileViewModel>();

        // Parse date from controller
        DateTime? dateOfBirth;
        if (_dateOfBirthController.text.isNotEmpty) {
          final dateParts = _dateOfBirthController.text.split('/');
          if (dateParts.length == 3) {
            dateOfBirth = DateTime(
              int.parse(dateParts[2]), // year
              int.parse(dateParts[1]), // month
              int.parse(dateParts[0]), // day
            );
          }
        }

        // Create updated profile model
        final updatedProfile = ProfileModel(
          id: _profile?.id,
          name: _fullNameController.text.trim(),
          email: _emailController.text.trim(),
          phone: _phoneController.text.trim(),
          gender: _selectedGender,
          dateOfBirth: dateOfBirth,
          address: _profile?.address,
          city: _profile?.city,
          country: _profile?.country,
          profileImage: _profile?.profileImage,
          avatar: _profile?.avatar,
          firstName: _fullNameController.text.trim().split(' ')[0],
          lastName: _fullNameController.text.trim().split(' ')[1],
          createdAt: _profile?.createdAt,
          updatedAt: DateTime.now(),
        );

        await profileViewModel.updateProfile(updatedProfile);

        if (profileViewModel.error == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('profile_saved_successfully'.tr()),
              backgroundColor: AppColor.primary,
            ),
          );
          setState(() {
            _isEditing = false;
            _profile = profileViewModel.profile;
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: ${profileViewModel.error}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving profile: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
