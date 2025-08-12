import 'package:aleef/modules/user/services/views/store_screens/finish_order_screen.dart';
import 'package:aleef/shared/assets/app_color.dart';
import 'package:aleef/shared/routes/navigation_routes.dart';
import 'package:aleef/shared/widgets/quantity_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int item1Quantity = 1;
  int item2Quantity = 1;
  String selectedDeliveryMethod = 'شركة بوسطة';
  bool isDeliveryExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColor.primary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'سلة التسوق',
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
        ),
        centerTitle: true,
        actions: [],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Shopping Cart Items Section
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            child: _buildCartItem(
              image: 'assets/images/png/product_item.png',
              name: 'طعام قطط رويال',
              price: '12.99',
              quantity: item1Quantity,
              onQuantityChanged: (value) {
                setState(() {
                  item1Quantity = value;
                });
              },
              onDelete: () {},
            ),
          ),
          SizedBox(height: 10),
          // Item 2: Beso Wet Cat Food
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: _buildCartItem(
              image: 'assets/images/png/product_item.png',
              name: 'طعام قطط رطب',
              price: '10.00',
              quantity: item2Quantity,
              onQuantityChanged: (value) {
                setState(() {
                  item2Quantity = value;
                });
              },
              onDelete: () {},
            ),
          ),
          SizedBox(height: 20),

          // Delivery Section
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Text(
              'التوصيل',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.symmetric(horizontal: 10.w),
            decoration: BoxDecoration(
              color: Color(0xFFF8F6F2),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColor.primary, width: 1),
            ),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      isDeliveryExpanded = !isDeliveryExpanded;
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'أختر طريقة التوصيل',
                        style: TextStyle(color: Colors.black87, fontSize: 16),
                      ),
                      Icon(
                        isDeliveryExpanded
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: AppColor.primary,
                      ),
                    ],
                  ),
                ),
                if (isDeliveryExpanded) ...[
                  Divider(height: 20),
                  _buildDeliveryOption('شركة بوسطة', true),
                  SizedBox(height: 8),
                  _buildDeliveryOption('استلم الطلب بنفسك من المتجر', false),
                ],
              ],
            ),
          ),

          Spacer(),

          // Payment Summary Section
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Text(
              'ملخص الدفع',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color(0xFFF8F6F2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                _buildSummaryRow(
                  'مجموع السلة',
                  '${(item1Quantity * 12.99 + item2Quantity * 10.00).toStringAsFixed(2)} ريال',
                ),
                SizedBox(height: 12),
                _buildSummaryRow('توصيل', '5.00 ريال'),
                Divider(height: 20),
                _buildSummaryRow(
                  'المبلغ الإجمالي',
                  '${(item1Quantity * 12.99 + item2Quantity * 10.00 + 5.00).toStringAsFixed(2)} ريال',
                  isTotal: true,
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      NavigationService().pushWidget(FinishOrderScreen());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'تنفيذ الطلب',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 30),

          // Checkout Button
        ],
      ),
    );
  }

  Widget _buildCartItem({
    required String image,
    required String name,
    required String price,
    required int quantity,
    required Function(int) onQuantityChanged,
    required VoidCallback onDelete,
  }) {
    return Container(
      width: double.infinity,
      height: 122,
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Color(0xFFF6F1E9),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(
              0.07,
            ), // #00000012 with 12/255 alpha ≈ 7% opacity
            offset: Offset(4, 4),
            blurRadius: 20,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: onDelete,
                icon: Icon(Icons.delete, color: Color(0xFFFE0A0A)),
              ),
              Spacer(),
              Container(
                width: 100,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColor.primary,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.add, color: Colors.white),
                    Text(
                      '1',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Icon(Icons.remove, color: Colors.white),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
            ],
          ),
          Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height: 10.h),
              Text(
                name,
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                  fontSize: 14,
                  height: 1.5,
                  letterSpacing: 0,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 45.h),
              Text(
                '$price ريال',
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                  fontSize: 18,
                  height: 1.0,
                  letterSpacing: 0,
                  color: Color(0xFF7140FD),
                ),
              ),
            ],
          ),
          SizedBox(width: 25),
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Image.asset(image),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryOption(String option, bool isSelected) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: isSelected ? Colors.green.withOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Radio<String>(
            value: option,
            groupValue: selectedDeliveryMethod,
            onChanged: (value) {
              setState(() {
                selectedDeliveryMethod = value!;
              });
            },
            activeColor: Colors.green,
          ),
          Text(option, style: TextStyle(color: Colors.black87, fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.black87,
            fontSize: isTotal ? 18 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: isTotal ? AppColor.primary : Colors.black87,
            fontSize: isTotal ? 18 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
