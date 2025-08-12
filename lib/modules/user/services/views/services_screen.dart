import 'package:aleef/modules/user/services/views/store_screens/product_screen.dart';
import 'package:aleef/shared/routes/navigation_routes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/services_view_model.dart';
import '../models/service_model.dart';
import 'package:aleef/shared/assets/app_color.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  @override
  void initState() {
    super.initState();
    // Load services when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ServicesViewModel>().loadServices();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Header Section
            _buildHeader(),
            const SizedBox(height: 20),
            // Service Categories Grid
            Expanded(child: _buildServiceCategories()),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const SizedBox(height: 8),
          const Text(
            'خدماتنا',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.normal,
              fontSize: 24,
              height: 1.0,
              letterSpacing: 0,
              color: Color(0xFF2D2D2D),
            ),
            textAlign: TextAlign.center,
            textHeightBehavior: TextHeightBehavior(
              applyHeightToFirstAscent: false,
              applyHeightToLastDescent: false,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'ما الذي تبحث عنه ؟',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.normal,
              fontSize: 20,
              height: 1.0,
              letterSpacing: 0,
              color: Color(0xFF2D2D2D),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCategories() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 60,
              mainAxisSpacing: 60,
              childAspectRatio: 1.1,
              children: [
                _buildServiceCard(
                  icon: 'assets/images/png/store.png',
                  title: 'store'.tr(),
                  onTap: () => _navigateToServiceCategory('store'),
                ),
                _buildServiceCard(
                  icon: 'assets/images/png/doctor.png',
                  title: 'book_doctor'.tr(),
                  onTap: () => _navigateToServiceCategory('doctor'),
                ),
                _buildServiceCard(
                  icon: 'assets/images/png/trainer.png',
                  title: 'trainers'.tr(),
                  onTap: () => _navigateToServiceCategory('trainer'),
                ),
                _buildServiceCard(
                  icon: 'assets/images/png/hotel.png',
                  title: 'hotels'.tr(),
                  onTap: () => _navigateToServiceCategory('hotel'),
                ),
                _buildServiceCard(
                  icon: 'assets/images/png/scisorss.png',
                  title: 'groomers'.tr(),
                  onTap: () => _navigateToServiceCategory('groomer'),
                  isCentered: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard({
    required String icon,
    required String title,
    required VoidCallback onTap,
    bool isCentered = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 134,
        height: 114,
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(1),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: const Color(0xFFB0B0B0), width: 2),
          boxShadow: [
            const BoxShadow(
              color: Color(0x66000000), // #00000040 with 40% opacity
              offset: Offset(0, 4),
              blurRadius: 4,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(child: Image.asset(icon, width: 60, height: 60)),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                icon: 'assets/images/svg/home.svg',
                label: 'الرئيسية',
                isActive: false,
                onTap: () => _navigateToHome(),
              ),
              _buildNavItem(
                icon: 'assets/images/svg/services.svg',
                label: 'الخدمات',
                isActive: true,
                onTap: () {},
              ),
              _buildNavItem(
                icon: 'assets/images/svg/dog_tracks.svg',
                label: 'حيواناتي',
                isActive: false,
                onTap: () => _navigateToMyAnimals(),
              ),
              _buildNavItem(
                icon: 'assets/images/svg/user.svg',
                label: 'حسابي',
                isActive: false,
                onTap: () => _navigateToProfile(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required String icon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            icon,
            width: 24,
            height: 24,
            color: isActive ? AppColor.primary : Colors.grey,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: isActive ? AppColor.primary : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToServiceCategory(String category) {
    // Navigate to specific service category
    print('Navigating to $category category');
    if (category == 'store') {
      NavigationService().pushWidget(ProductScreen());
    }
  }

  void _navigateToHome() {
    // Navigate to home screen
    print('Navigating to home');
  }

  void _navigateToMyAnimals() {
    // Navigate to my animals screen
    print('Navigating to my animals');
  }

  void _navigateToProfile() {
    // Navigate to profile screen
    print('Navigating to profile');
  }
}
