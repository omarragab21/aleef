import 'dart:developer';

import 'package:aleef/modules/auth/view_models/auth_view_model.dart';
import 'package:aleef/modules/user/home/views/home_screen.dart';
import 'package:aleef/modules/user/my_animals/view_models/animals_view_model.dart';
import 'package:aleef/modules/user/my_animals/views/animals_screen.dart';
import 'package:aleef/modules/user/profile/view_models/profile_view_model.dart';
import 'package:aleef/modules/user/profile/views/edit_profile_screen.dart';
import 'package:aleef/modules/user/profile/views/profile_screen.dart';
import 'package:aleef/modules/user/services/view_models/services_view_model.dart';
import 'package:aleef/modules/user/services/views/services_screen.dart';
import 'package:aleef/shared/routes/navigation_routes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../view_models/main_view_model.dart';
import '../../../../shared/assets/app_color.dart';
import '../../../../shared/assets/app_text_styles.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0; // Home is selected
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<Widget> _pages = [
    HomeScreen(),
    ServicesScreen(),
    AnimalsScreen(),
    const SizedBox(),
  ];
  @override
  void initState() {
    super.initState();
    // Load main data when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MainViewModel>().loadMainData();
      //context.read<ServicesViewModel>().getPetsData();
      context.read<ServicesViewModel>().getDoctors();
      context.read<ServicesViewModel>().getProducts();
      context.read<ProfileViewModel>().loadProfile();
      context.read<AnimalsViewModel>().loadAnimals();
    });
  }

  @override
  Widget build(BuildContext context) {
    log(context.read<AuthViewModel>().token.toString());
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: Directionality(
        textDirection: material.TextDirection.ltr,
        child: SafeArea(child: _pages[_selectedIndex]),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem('assets/images/svg/main_home.svg', 'home'.tr(), 0),
              _buildNavItem(
                'assets/images/svg/services.svg',
                'services'.tr(),
                1,
              ),
              _buildNavItem(
                'assets/images/svg/dogs_tarcks_two.svg',
                'my_pets'.tr(),
                2,
              ),
              _buildNavItem('assets/images/svg/user.svg', 'my_account'.tr(), 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(String icon, String label, int index) {
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () {
        if (index == 3) {
          NavigationService().pushWidget(EditProfileScreen());
        } else {
          setState(() {
            _selectedIndex = index;
          });
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            icon,
            width: 24.w,
            height: 24.h,
            fit: BoxFit.cover,
            color: isSelected ? AppColor.primary : AppColor.lightGray,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: AppTextStyles.labelSmall.copyWith(
              color: isSelected ? AppColor.primary : AppColor.lightGray,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
