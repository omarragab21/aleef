import 'package:aleef/modules/user/home/views/home_screen.dart';
import 'package:aleef/modules/user/my_animals/views/animals_screen.dart';
import 'package:aleef/modules/user/services/views/services_screen.dart';
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

  List<Widget> _pages = [
    HomeScreen(),
    ServicesScreen(),
    AnimalsScreen(),
    SizedBox(),
    SizedBox(),
  ];
  @override
  void initState() {
    super.initState();
    // Load main data when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MainViewModel>().loadMainData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        setState(() {
          _selectedIndex = index;
        });
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
