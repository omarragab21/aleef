import 'package:aleef/modules/user/services/views/store_screens/finish_order_screen.dart';
import 'package:aleef/modules/user/services/view_models/cart_view_model.dart';
import 'package:aleef/modules/user/services/models/cart_item_model.dart';
import 'package:aleef/shared/assets/app_color.dart';
import 'package:aleef/shared/routes/navigation_routes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
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
          'shopping_cart'.tr(),
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
      body: Consumer<CartViewModel>(
        builder: (context, cartViewModel, child) {
          if (cartViewModel.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 100,
                    color: Colors.grey[400],
                  ),
                  SizedBox(height: 20),
                  Text(
                    'cart_is_empty'.tr(),
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                      fontFamily: 'Cairo',
                    ),
                  ),
                ],
              ),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Shopping Cart Items Section
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 10.h,
                  ),
                  itemCount: cartViewModel.cartItems.length,
                  itemBuilder: (context, index) {
                    final cartItem = cartViewModel.cartItems[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: 10.h),
                      child: _buildCartItem(
                        cartItem: cartItem,
                        onQuantityChanged: (value) {
                          cartViewModel.updateQuantity(
                            cartItem.product.id,
                            value,
                          );
                        },
                        onDelete: () {
                          cartViewModel.removeFromCart(cartItem.product.id);
                        },
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),

              // Delivery Section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Text(
                  'delivery'.tr(),
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    fontFamily: 'Cairo',
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
                            'choose_delivery_method'.tr(),
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 16,
                              fontFamily: 'Cairo',
                            ),
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
                      _buildDeliveryOption('bosta_company'.tr(), true),
                      SizedBox(height: 8),
                      _buildDeliveryOption('pickup_from_store'.tr(), false),
                    ],
                  ],
                ),
              ),

              Spacer(),

              // Payment Summary Section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Text(
                  'payment_summary'.tr(),
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    fontFamily: 'Cairo',
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
                      'cart_total'.tr(),
                      '${cartViewModel.totalPrice.toStringAsFixed(2)} ريال',
                    ),
                    SizedBox(height: 12),
                    _buildSummaryRow('delivery_fee'.tr(), '5.00 ريال'),
                    Divider(height: 20),
                    _buildSummaryRow(
                      'total_amount'.tr(),
                      '${(cartViewModel.totalPrice + 5.00).toStringAsFixed(2)} ريال',
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
                          'place_order'.tr(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cairo',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 30),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCartItem({
    required CartItemModel cartItem,
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
                    GestureDetector(
                      onTap: () => onQuantityChanged(cartItem.quantity + 1),
                      child: Icon(Icons.add, color: Colors.white),
                    ),
                    Text(
                      cartItem.quantity.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (cartItem.quantity > 1) {
                          onQuantityChanged(cartItem.quantity - 1);
                        } else {
                          onDelete();
                        }
                      },
                      child: Icon(Icons.remove, color: Colors.white),
                    ),
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
                cartItem.product.name,
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
                '${cartItem.product.price} ريال',
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
            child: cartItem.product.image.isNotEmpty
                ? Image.network(
                    cartItem.product.image,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset('assets/images/png/product_item.png');
                    },
                  )
                : Image.asset('assets/images/png/product_item.png'),
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
