import 'package:aleef/modules/user/services/views/store_screens/track_order_screen.dart';
import 'package:aleef/shared/assets/app_color.dart';
import 'package:aleef/shared/routes/navigation_routes.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/svg.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            color: AppColor.primary,
            size: 30,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'my_orders'.tr(),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              'assets/images/svg/shopping_cart.svg',
              color: AppColor.primary,
            ),
            onPressed: () {
              // Navigate to cart
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 3, // Number of orders shown in image
                itemBuilder: (context, index) {
                  return OrderCard(
                    orderNumber: "#747364",
                    date: "10 يونيو 2025",
                    status: 'in_delivery'.tr(),
                    productCount: "3",
                    total: "200 ريال عماني",
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

class OrderCard extends StatelessWidget {
  final String orderNumber;
  final String date;
  final String status;
  final String productCount;
  final String total;

  const OrderCard({
    super.key,
    required this.orderNumber,
    required this.date,
    required this.status,
    required this.productCount,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFF6D9773), width: 1),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color(0x40000000), // #00000040 with 25% opacity
            offset: Offset(0, 4),
            blurRadius: 4,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            '${'order_number'.tr()} :    $orderNumber',
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.normal,
              fontSize: 15,
              height: 1.0, // 100% line height
              letterSpacing: 0.0,
              color: Color(0xFF2D2D2D),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            '${'date'.tr()} :    $date',
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.normal,
              fontSize: 15,
              height: 1.0,
              letterSpacing: 0.0,
              color: Color(0xFF2D2D2D),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            '${'status'.tr()} :   $status',
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.normal,
              fontSize: 15,
              height: 1.0,
              letterSpacing: 0.0,
              color: Color(0xFF2D2D2D),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            '${'number_of_products'.tr()} :     $productCount',
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.normal,
              fontSize: 15,
              height: 1.0,
              letterSpacing: 0.0,
              color: Color(0xFF2D2D2D),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            '${'total'.tr()} :   $total',
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.normal,
              fontSize: 15,
              height: 1.0,
              letterSpacing: 0.0,
              color: Color(0xFF2D2D2D),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Navigate to order details
                NavigationService().pushWidget(TrackOrderScreen());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: Text(
                'view_details'.tr(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
