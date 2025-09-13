import 'package:aleef/modules/user/services/views/grommer_screen/grommer_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:aleef/shared/assets/app_color.dart';
import 'package:aleef/shared/routes/navigation_routes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class GrommerScreen extends StatefulWidget {
  const GrommerScreen({super.key});

  @override
  State<GrommerScreen> createState() => _GrommerScreenState();
}

class _GrommerScreenState extends State<GrommerScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildSearchBar(),
            Expanded(child: _buildGroomerList()),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              NavigationService().pop();
            },
            icon: Icon(Icons.arrow_back_ios, color: AppColor.primary, size: 20),
          ),
          Expanded(
            child: Text(
              'choose_groomer_for_pet'.tr(),
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: AppColor.title,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Color(0xFF6D9773), width: 2),
      ),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'search_for_groomer'.tr(),
          hintStyle: TextStyle(
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            fontSize: 16,
            height: 1.0,
            letterSpacing: 0,
            color: Color(0xFF979797),
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SvgPicture.asset(
              'assets/images/svg/fliter_icon.svg',
              width: 20,
              height: 20,
            ),
          ),
          prefixIcon: Icon(Icons.search, color: AppColor.primary, size: 25),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 12.h,
          ),
        ),
      ),
    );
  }

  Widget _buildGroomerList() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      itemCount: 3, // Sample data
      itemBuilder: (context, index) {
        return _buildGroomerCard();
      },
    );
  }

  Widget _buildGroomerCard() {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(1),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Color(0xFFE0E0E0), width: 1),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: _buildSalonDetails()),
                SizedBox(width: 12.w),
                _buildSalonLogo(),
              ],
            ),
            SizedBox(height: 12.h),
            SizedBox(
              width: 188.w,
              height: 32.h,
              child: ElevatedButton(
                onPressed: () {
                  // Handle booking
                  NavigationService().pushWidget(GrommerDetailsScreen());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.r),
                    side: BorderSide(color: AppColor.primary, width: 4),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 0),
                ),
                child: Text(
                  'book_now'.tr(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSalonLogo() {
    return Container(
      width: 162.w,
      height: 162.h,
      decoration: BoxDecoration(
        color: AppColor.secondary,
        borderRadius: BorderRadius.circular(12.r),
        image: DecorationImage(
          image: AssetImage('assets/images/png/pets_shop.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildSalonDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'soft_claws_salon'.tr(),
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: AppColor.title,
          ),
        ),
        SizedBox(height: 8.h),
        _buildDetailRow(Icons.pets, 'cats_dogs'.tr()),
        SizedBox(height: 8.h),
        _buildDetailRow(Icons.location_on, 'al_khoudh_muscat'.tr()),
        SizedBox(height: 8.h),
        _buildDetailRow(
          Icons.access_time,
          'service_duration_minutes'.tr(namedArgs: {'minutes': '45'}),
        ),
        SizedBox(height: 8.h),
        _buildDetailRow(
          Icons.attach_money,
          'starting_from_riyals'.tr(namedArgs: {'price': '5'}),
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            Text(
              '5.0',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: AppColor.title,
              ),
            ),
            SizedBox(width: 4.w),
            ...List.generate(
              5,
              (index) => Icon(Icons.star, color: Colors.amber, size: 16),
            ),
          ],
        ),
        SizedBox(height: 12.h),
      ],
    );
  }

  Widget _buildDetailRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: AppColor.primary, size: 16),
        SizedBox(width: 6.w),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 12.sp, color: AppColor.title),
          ),
        ),
      ],
    );
  }
}
