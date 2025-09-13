import 'package:aleef/modules/user/services/view_models/cart_view_model.dart';
import 'package:aleef/modules/user/services/views/store_screens/cart_screen.dart';
import 'package:aleef/shared/routes/navigation_routes.dart';
import 'package:aleef/shared/widgets/cart_badge.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:aleef/shared/assets/app_color.dart';
import 'package:aleef/shared/assets/app_text_styles.dart';
import 'package:aleef/shared/widgets/quantity_selector.dart';
import 'package:aleef/modules/user/services/models/product_model.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductModel? product;

  const ProductDetailsScreen({super.key, this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int _quantity = 1;

  // Sample product data - in real app this would come from API
  late ProductModel _product;

  @override
  void initState() {
    super.initState();
    _product =
        widget.product ??
        ProductModel(
          id: 1,
          name: 'طعام قطط رويال',
          price: '12.99',
          image: 'assets/images/png/product_item.png',
          hasVariants: false,
          description:
              'طعام متكامل مصمم خصيصًا لتلبية احتياجات القطط البالغة. مصنوع من مكونات طبيعية عالية الجودة، ويحتوي على نسبة بروتين معتدلة لدعم الصحة العامة والعضلات، مع مذاق شهي يحبه القطط.',
          category: 'طعام الحيوانات',
          brand: 'ROYAL CANIN',
          isAvailable: true,
          stockQuantity: 50,
        );
  }

  void _onQuantityChanged(int quantity) {
    setState(() {
      _quantity = quantity;
    });
  }

  void _addToCart() {
    // TODO: Implement add to cart functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'product_added_to_cart'
              .tr()
              .replaceAll('{quantity}', _quantity.toString())
              .replaceAll('{productName}', _product.name),
        ),
        backgroundColor: AppColor.primary,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColor.primary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'product_details'.tr(),
          style: AppTextStyles.titleLarge.copyWith(
            color: AppColor.title,
            fontWeight: FontWeight.w700,
            fontSize: 24,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 2.0),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Consumer<CartViewModel>(
                builder: (context, cartViewModel, child) {
                  return GestureDetector(
                    onTap: () {
                      NavigationService().pushWidget(CartScreen());
                    },
                    child: CartBadge(
                      count: cartViewModel.itemCount,
                      child: SvgPicture.asset(
                        'assets/images/svg/shopping_cart.svg',
                        width: 28,
                        height: 28,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(width: 12),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Container(
              width: double.infinity,
              height: 350,
              decoration: BoxDecoration(
                color: AppColor.secondary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: _product.imageUrl != null
                    ? _product.imageUrl!.startsWith('http')
                          ? Image.network(
                              _product.imageUrl!,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: AppColor.secondary,
                                  child: Icon(
                                    Icons.image_not_supported,
                                    size: 80,
                                    color: AppColor.lightGray,
                                  ),
                                );
                              },
                            )
                          : Image.asset(
                              _product.imageUrl!,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: AppColor.secondary,
                                  child: Icon(
                                    Icons.image_not_supported,
                                    size: 80,
                                    color: AppColor.lightGray,
                                  ),
                                );
                              },
                            )
                    : Container(
                        color: AppColor.secondary,
                        child: Icon(
                          Icons.image_not_supported,
                          size: 80,
                          color: AppColor.lightGray,
                        ),
                      ),
              ),
            ),

            const SizedBox(height: 24),

            // Product Name
            Text(
              _product.name,
              style: AppTextStyles.displaySmall.copyWith(
                color: AppColor.title,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 16),

            // Product Description
            Text(
              _product.description ?? '',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColor.title,
                height: 1.6,
              ),
            ),

            const SizedBox(height: 24),

            // Quantity Selector and Price Row
            Row(
              children: [
                // Quantity Selector

                // Price
                Text(
                  '${_product.price} ريال',
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                    fontSize: 20,
                    height: 1.5,
                    letterSpacing: 0,
                    color: Color(0xFF2D2D2D),
                  ),
                ),
                const Spacer(),
                QuantitySelector(
                  initialQuantity: _quantity,
                  onQuantityChanged: _onQuantityChanged,
                ),
              ],
            ),

            const Spacer(),

            // Add to Cart Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _product.isAvailable == true ? _addToCart : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  disabledBackgroundColor: AppColor.lightGray,
                ),
                child: Text(
                  'add_to_cart'.tr(),
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                    fontSize: 20,
                    height: 1.0,
                    letterSpacing: 0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
