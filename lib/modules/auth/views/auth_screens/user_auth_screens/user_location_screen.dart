import 'package:aleef/modules/user/main/views/main_screen.dart';
import 'package:aleef/shared/assets/app_color.dart';
import 'package:aleef/shared/routes/navigation_routes.dart';
import 'package:aleef/modules/auth/view_models/auth_view_model.dart';
import 'package:aleef/modules/auth/models/governorates_model.dart';
import 'package:aleef/modules/auth/models/cities_model.dart';
import 'package:aleef/modules/auth/repository/auth_api_repository.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class UserLocationScreen extends StatefulWidget {
  const UserLocationScreen({super.key});

  @override
  State<UserLocationScreen> createState() => _UserLocationScreenState();
}

class _UserLocationScreenState extends State<UserLocationScreen> {
  late AuthViewModel _authViewModel;
  List<Governorate> governorates = [];
  List<City> cities = [];
  bool isLoadingGovernorates = false;
  bool isLoadingCities = false;
  String? selectedGovernorateId;
  String? selectedGovernorateName;
  String? selectedCityId;
  String? selectedCityName;

  @override
  void initState() {
    super.initState();
    _authViewModel = AuthViewModel(AuthApiRepository());
    _loadGovernorates();
  }

  Future<void> _loadGovernorates() async {
    setState(() {
      isLoadingGovernorates = true;
    });

    try {
      final response = await _authViewModel.getGovernorates();
      if (response.status == 'success') {
        setState(() {
          governorates = response.data;
          isLoadingGovernorates = false;
        });
      } else {
        setState(() {
          isLoadingGovernorates = false;
        });
        _showErrorSnackBar(response.message);
      }
    } catch (e) {
      setState(() {
        isLoadingGovernorates = false;
      });
      _showErrorSnackBar('Failed to load governorates');
    }
  }

  Future<void> _loadCities(int governorateId) async {
    setState(() {
      isLoadingCities = true;
      cities = [];
      selectedCityId = null;
      selectedCityName = null;
    });

    try {
      final response = await _authViewModel.getCities(governorateId);
      if (response.status == 'success') {
        setState(() {
          cities = response.data;
          isLoadingCities = false;
        });
      } else {
        setState(() {
          isLoadingCities = false;
        });
        _showErrorSnackBar(response.message);
      }
    } catch (e) {
      setState(() {
        isLoadingCities = false;
      });
      _showErrorSnackBar('Failed to load cities');
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 24.0,
                  ),
                  child: Icon(Icons.arrow_back_ios, color: AppColor.primary),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 24.0,
                  ),
                  child: Text(
                    'choose_geographical_region'.tr(),
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                      fontSize: 24,
                      height: 1.0,
                      letterSpacing: 0,
                      color: Color(0xFF2D2D2D),
                    ),
                  ),
                ),
                Spacer(),
                SizedBox(width: 50.w),
              ],
            ),
            SizedBox(height: 50.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'governorates'.tr(),
                style: const TextStyle(
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                  fontSize: 16,
                  height: 1.0,
                  letterSpacing: 0,
                  color: Color(0xFF2D2D2D),
                ),
              ),
            ),
            SizedBox(height: 20.h),

            Center(
              child: Container(
                width: double.infinity,
                height: 55,
                padding: const EdgeInsets.symmetric(
                  vertical: 9,
                  horizontal: 13,
                ),
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFA4D4AE),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: const Color(0xFF6D9773), width: 2),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedGovernorateId,
                    isExpanded: true,
                    icon: isLoadingGovernorates
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Color(0xFF2D2D2D),
                              ),
                            ),
                          )
                        : const Icon(
                            Icons.keyboard_arrow_down,
                            color: Color(0xFF2D2D2D),
                          ),
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Color(0xFF2D2D2D),
                    ),
                    hint: Text(
                      isLoadingGovernorates
                          ? 'loading_governorates'.tr()
                          : 'choose_location'.tr(),
                      style: const TextStyle(
                        color: Color(0xFF2D2D2D),
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    onChanged: isLoadingGovernorates
                        ? null
                        : (String? newValue) {
                            if (newValue != null) {
                              setState(() {
                                selectedGovernorateId = newValue;
                                selectedGovernorateName = governorates
                                    .firstWhere(
                                      (g) => g.id.toString() == newValue,
                                    )
                                    .name;
                              });
                              _loadCities(int.parse(newValue));
                            }
                          },
                    items: governorates.map<DropdownMenuItem<String>>((
                      Governorate governorate,
                    ) {
                      return DropdownMenuItem<String>(
                        value: governorate.id.toString(),
                        child: Text(governorate.name),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'areas_or_states'.tr(),
                style: const TextStyle(
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                  fontSize: 16,
                  height: 1.0,
                  letterSpacing: 0,
                  color: Color(0xFF2D2D2D),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Center(
              child: Container(
                width: double.infinity,
                height: 55,
                padding: const EdgeInsets.symmetric(
                  vertical: 9,
                  horizontal: 13,
                ),
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFA4D4AE),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: const Color(0xFF6D9773), width: 2),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedCityId,
                    isExpanded: true,
                    icon: isLoadingCities
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Color(0xFF2D2D2D),
                              ),
                            ),
                          )
                        : const Icon(
                            Icons.keyboard_arrow_down,
                            color: Color(0xFF2D2D2D),
                          ),
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Color(0xFF2D2D2D),
                    ),
                    hint: Text(
                      selectedGovernorateId == null
                          ? 'select_governorate_first'.tr()
                          : isLoadingCities
                          ? 'loading_cities'.tr()
                          : 'choose_location'.tr(),
                      style: const TextStyle(
                        color: Color(0xFF2D2D2D),
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    onChanged: selectedGovernorateId == null || isLoadingCities
                        ? null
                        : (String? newValue) {
                            if (newValue != null) {
                              setState(() {
                                selectedCityId = newValue;
                                selectedCityName = cities
                                    .firstWhere(
                                      (c) => c.id.toString() == newValue,
                                    )
                                    .name;
                              });
                            }
                          },
                    items: cities.map<DropdownMenuItem<String>>((City city) {
                      return DropdownMenuItem<String>(
                        value: city.id.toString(),
                        child: Text(city.name),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            Spacer(),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SvgPicture.asset(
                  'assets/images/svg/dog_tracks.svg',
                  width: 200.w,
                  height: 200.h,
                ),
              ),
            ),
            SizedBox(height: 30.h),
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
                  onPressed:
                      selectedGovernorateId != null && selectedCityId != null
                      ? () {
                          // TODO: Save the selected location data
                          print(
                            'Selected Governorate: $selectedGovernorateName (ID: $selectedGovernorateId)',
                          );
                          print(
                            'Selected City: $selectedCityName (ID: $selectedCityId)',
                          );
                          NavigationService().pushReplacementWidget(
                            MainScreen(),
                          );
                        }
                      : null,
                  child: Text(
                    'save_location'.tr(),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
