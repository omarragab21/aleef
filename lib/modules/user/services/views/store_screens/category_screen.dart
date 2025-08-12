import 'package:aleef/shared/assets/app_color.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryScreen extends StatelessWidget {
  final String categoryName;
  const CategoryScreen({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: SizedBox(),
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: SvgPicture.asset(
                'assets/images/svg/shopping_cart.svg',
                width: 28,
                height: 28,
              ),
            ),
          ),
        ],
        title: Text(
          categoryName,
          style: TextStyle(
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.normal,
            fontSize: 24,
            height: 1.0,
            letterSpacing: 0,
            color: Color(0xFF2D2D2D),
          ),
        ),
        iconTheme: const IconThemeData(color: Color(0xFF2D2D2D)),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top:
                    16.0, // You can adjust this to match top: 138px in your layout
                left: 18.0,
                right: 18.0,
              ),
              child: SizedBox(
                width: double.infinity,
                height: 44.h,
                child: TextField(
                  onTap: () {
                    // Handle TextField tap here
                    print('TextField tapped');
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(
                      top: 7,
                      bottom: 7,
                      right: 38,
                      left:
                          12, // Adjusted for better UX; original left: 233px is too much for a 357px field
                    ),
                    hintText: 'search_for_product'.tr(),
                    hintStyle: const TextStyle(
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Color(0xFFB0B0B0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        color: Color(0xFF6D9773),
                        width: 2,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        color: Color(0xFF6D9773),
                        width: 2,
                      ),
                    ),
                    prefixIcon: IconButton(
                      icon: const Icon(Icons.search, color: Color(0xFF6D9773)),
                      onPressed: () {
                        // Handle prefix icon (search) action
                        print('Search icon pressed');
                      },
                    ),
                    suffixIcon: IconButton(
                      icon: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: SvgPicture.asset(
                          'assets/images/svg/fliter_icon.svg',
                          width: 24,
                          height: 24,
                        ),
                      ),
                      onPressed: () {
                        // Handle suffix icon (mic) action
                        print('Mic icon pressed');
                      },
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 30.h),
            // Row title with plus icon in a circle

            // GridView of products
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: 8, // Example count, replace with your data length
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 30,
                  childAspectRatio: 156 / 210,
                ),
                itemBuilder: (context, index) {
                  return Container(
                    width: 156,
                    height: 210,
                    decoration: BoxDecoration(
                      color: Color(0xFFF6F1E9),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Example image, replace with your asset or network image
                        SizedBox(height: 16),
                        Center(
                          child: Container(
                            width: 120,
                            height: 120,
                            child: Image.asset(
                              'assets/images/png/product_item.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 16.0,
                            right: 16.0,
                          ),
                          child: Text(
                            'طعام قطط',
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 12,
                              height: 1.6,
                              letterSpacing: 0,
                              color: Color(0xFF2D2D2D),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '12,99 ريال',
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 20,
                                  height: 1.5,
                                  letterSpacing: 0,
                                  color: Color(0xFF2D2D2D),
                                ),
                              ),
                              Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  color: AppColor.primary,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(Icons.add, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
