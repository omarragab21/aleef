import 'package:aleef/modules/user/profile/views/edit_profile_screen.dart';
import 'package:aleef/modules/user/services/views/store_screens/my_orders_screen.dart';
import 'package:aleef/modules/user/services/views/vets_screens/my_appointments_screen.dart';
import 'package:aleef/shared/routes/navigation_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../assets/app_color.dart';
import '../assets/app_text_styles.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            // Header with profile
            _buildHeader(),
            // Menu items
            Expanded(child: _buildMenuItems()),
            // Bottom navigation
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const SizedBox(height: 5),

          // Title
          Text(
            'حسابي',
            style: AppTextStyles.titleLarge.copyWith(
              color: AppColor.title,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 24),

          // Profile picture with camera icon
          Stack(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: const DecorationImage(
                    image: AssetImage('assets/images/png/cat.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(
                      0xFFF8FFD9,
                    ), // Light yellow-green color (#F8FFD9)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: SvgPicture.asset(
                      'assets/images/svg/camera.svg',
                      color: AppColor.primary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItems() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Column(
          children: [
            _buildMenuItem(
              icon: Icons.person,
              title: 'حسابي',
              onTap: () {
                NavigationService().pushWidget(EditProfileScreen());
              },
            ),
            _buildMenuItem(
              icon: Icons.credit_card,
              title: 'بطاقات الإئتمان',
              onTap: () {},
            ),
            _buildMenuItem(
              icon: Icons.calendar_today,
              title: 'حجوزاتي',
              onTap: () {
                NavigationService().pushWidget(MyAppointmentsScreen());
              },
            ),
            _buildMenuItem(
              icon: Icons.shopping_bag,
              title: 'طلباتي',
              onTap: () {
                NavigationService().pushWidget(MyOrdersScreen());
              },
            ),
            _buildLanguageMenuItem(),
            _buildMenuItem(
              icon: Icons.headset,
              title: 'أتصل بنا',
              onTap: () {},
            ),
            _buildMenuItem(
              icon: Icons.description,
              title: 'الشروط والأحكام',
              onTap: () {},
            ),
            _buildMenuItem(
              icon: Icons.lock,
              title: 'سياسة الخصوصية',
              onTap: () {},
            ),
            const SizedBox(height: 20),
            _buildLogoutMenuItem(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isLogout = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        border: isLogout
            ? null
            : Border(bottom: BorderSide(color: Color(0xFFB0B0B0), width: 1)),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
          child: Row(
            children: [
              const SizedBox(width: 10),
              if (!isLogout)
                const Icon(
                  Icons.arrow_back_ios,
                  color: AppColor.title,
                  size: 16,
                ),
              const Spacer(),

              const SizedBox(width: 16),
              Text(
                title,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: isLogout ? Colors.red : AppColor.title,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 5),
              Icon(
                icon,
                color: isLogout ? Colors.red : AppColor.primary,
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageMenuItem() {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFB0B0B0), width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CupertinoSwitch(
            value: true,
            onChanged: (bool value) {
              // TODO: Implement language switch logic here
            },
            activeColor: AppColor.primary,
          ),
          const SizedBox(width: 10),
          Text(
            'عربي ',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColor.title,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 10),
          const Spacer(),
          Text(
            'اللغة',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColor.title,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 10),
          Icon(Icons.language, color: AppColor.primary, size: 24),
        ],
      ),
    );
  }

  Widget _buildLogoutMenuItem() {
    return _buildMenuItem(
      icon: Icons.logout,
      title: 'تسجيل الخروج',
      onTap: () {},
      isLogout: true,
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: AppColor.stroke2, width: 1)),
      ),
      child: Row(
        children: [
          _buildNavItem(icon: Icons.person, title: 'حسابي', isActive: true),
          _buildNavItem(icon: Icons.pets, title: 'حيواناتي', isActive: false),
          _buildNavItem(
            icon: Icons.grid_view,
            title: 'الخدمات',
            isActive: false,
          ),
          _buildNavItem(icon: Icons.home, title: 'الرئيسية', isActive: false),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String title,
    required bool isActive,
  }) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isActive ? AppColor.primary : AppColor.lightGray,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: AppTextStyles.bodySmall.copyWith(
              color: isActive ? AppColor.primary : AppColor.lightGray,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
