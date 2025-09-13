import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aleef/shared/assets/app_color.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../view_models/cart_view_model.dart';

class FinishOrderScreen extends StatefulWidget {
  const FinishOrderScreen({super.key});

  @override
  State<FinishOrderScreen> createState() => _FinishOrderScreenState();
}

class _FinishOrderScreenState extends State<FinishOrderScreen> {
  String selectedPaymentMethod = 'card1';
  static const double deliveryFee = 5.00;

  @override
  Widget build(BuildContext context) {
    return Consumer<CartViewModel>(
      builder: (context, cartViewModel, child) {
        final subtotal = cartViewModel.totalPrice;
        final total = subtotal + deliveryFee;

        return _buildScaffold(context, cartViewModel, subtotal, total);
      },
    );
  }

  Widget _buildScaffold(
    BuildContext context,
    CartViewModel cartViewModel,
    double subtotal,
    double total,
  ) {
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
          'تنفيذ الطلب',
          style: TextStyle(
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w700,
            fontSize: 24,
            color: AppColor.title,
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        actions: [],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Delivery Address Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Color(0xFFF6F1E9),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'تغيير',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColor.title,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      Icon(
                        Icons.location_on,
                        color: AppColor.primary,
                        size: 24,
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'شارع النخيل، مبنى 25، طابق 2، شقة 203, ZAWLIYAH',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColor.title,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'خلف محطة البترول - المدخل يمين',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 12,
                      color: AppColor.lightGray,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'رقم الهاتف المتنقل : 96891234567+',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 12,
                      color: AppColor.lightGray,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16.h),

            // Add Address Button
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              decoration: BoxDecoration(
                color: AppColor.lightGreen,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add, color: Colors.white, size: 20),
                  SizedBox(width: 8.w),
                  Text(
                    'إضافة عنوان',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 24.h),

            // Cart Items Section
            if (cartViewModel.isNotEmpty) ...[
              Text(
                'عناصر الطلب',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColor.title,
                ),
              ),
              SizedBox(height: 16.h),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: AppColor.stroke2),
                ),
                child: Column(
                  children: cartViewModel.cartItems.map((cartItem) {
                    return Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: AppColor.stroke2,
                            width: 0.5,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 50.w,
                            height: 50.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              color: Colors.grey[200],
                            ),
                            child: cartItem.product.image.isNotEmpty
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(8.r),
                                    child: Image.network(
                                      cartItem.product.image,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                            return Icon(
                                              Icons.image,
                                              color: Colors.grey[400],
                                            );
                                          },
                                    ),
                                  )
                                : Icon(Icons.image, color: Colors.grey[400]),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  cartItem.product.name,
                                  style: TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.title,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  '${cartItem.product.price} ريال',
                                  style: TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 12,
                                    color: AppColor.lightGray,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                'الكمية: ${cartItem.quantity}',
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 12,
                                  color: AppColor.lightGray,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                '${cartItem.totalPrice.toStringAsFixed(2)} ريال',
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.title,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 24.h),
            ],

            // Payment Method Section
            Text(
              'الدفع من خلال',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColor.title,
              ),
            ),

            SizedBox(height: 16.h),

            // Payment Method Options
            Column(
              children: [
                _buildPaymentOption(
                  value: 'card1',
                  groupValue: selectedPaymentMethod,
                  onChanged: (value) {
                    setState(() {
                      selectedPaymentMethod = value!;
                    });
                  },
                  child: Row(
                    children: [
                      Radio<String>(
                        value: 'card1',
                        groupValue: selectedPaymentMethod,
                        onChanged: (value) {
                          setState(() {
                            selectedPaymentMethod = value!;
                          });
                        },
                        activeColor: AppColor.primary,
                      ),
                      Text(
                        'xxxx-4798',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColor.title,
                        ),
                      ),
                      Spacer(),
                      SvgPicture.asset('assets/images/svg/mastercard.svg'),
                    ],
                  ),
                ),

                SizedBox(height: 12.h),

                _buildPaymentOption(
                  value: 'newCard',
                  groupValue: selectedPaymentMethod,
                  onChanged: (value) {
                    setState(() {
                      selectedPaymentMethod = value!;
                    });
                  },
                  child: Row(
                    children: [
                      Radio<String>(
                        value: 'newCard',
                        groupValue: selectedPaymentMethod,
                        onChanged: (value) {
                          setState(() {
                            selectedPaymentMethod = value!;
                          });
                        },
                        activeColor: AppColor.primary,
                      ),
                      Text(
                        'أضف بطاقة جديدة',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColor.title,
                        ),
                      ),
                      Spacer(),
                      Icon(Icons.add, color: AppColor.primary, size: 20),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 24.h),

            // Payment Summary Section
            Text(
              'ملخص الدفع',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColor.title,
              ),
            ),

            SizedBox(height: 16.h),

            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
                children: [
                  _buildSummaryRow(
                    'مجموع السلة',
                    '${subtotal.toStringAsFixed(2)} ريال',
                  ),
                  SizedBox(height: 12.h),
                  _buildSummaryRow(
                    'توصيل',
                    '${deliveryFee.toStringAsFixed(2)} ريال',
                  ),
                  Divider(height: 24.h, color: AppColor.stroke2),
                  _buildSummaryRow(
                    'المبلغ الإجمالي',
                    '${total.toStringAsFixed(2)} ريال',
                    isTotal: true,
                  ),
                ],
              ),
            ),

            SizedBox(height: 32.h),

            // Execute Order Button
            GestureDetector(
              onTap: () => _executeOrder(cartViewModel),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 18.h),
                decoration: BoxDecoration(
                  color: AppColor.primary,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  'تنفيذ الطلب',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOption({
    required String value,
    required String groupValue,
    required ValueChanged<String?> onChanged,
    required Widget child,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(1),
        border: Border.all(color: Color(0xFF6D9773), width: 1.0),
        borderRadius: BorderRadius.circular(15),
      ),
      child: child,
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
            color: AppColor.title,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: isTotal ? 18 : 14,
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
            color: AppColor.title,
          ),
        ),
      ],
    );
  }

  void _executeOrder(CartViewModel cartViewModel) {
    if (cartViewModel.isEmpty) {
      _showSnackBar('السلة فارغة', isError: true);
      return;
    }

    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) =>
          Center(child: CircularProgressIndicator(color: AppColor.primary)),
    );

    // Simulate order processing
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pop(context); // Close loading dialog

      // Clear cart after successful order
      cartViewModel.clearCart();

      // Show success message
      _showSnackBar('تم تنفيذ الطلب بنجاح');

      // Navigate back or to order confirmation
      Navigator.pop(context);
    });
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(fontFamily: 'Cairo', color: Colors.white),
        ),
        backgroundColor: isError ? Colors.red : AppColor.primary,
        duration: Duration(seconds: 3),
      ),
    );
  }
}
