import 'package:aleef/modules/user/services/views/store_screens/cart_screen.dart';
import 'package:aleef/modules/user/services/views/store_screens/product_details_screen.dart';
import 'package:aleef/shared/assets/app_color.dart';
import 'package:aleef/modules/user/services/views/store_screens/category_screen.dart';
import 'package:aleef/shared/routes/navigation_routes.dart';
import 'package:aleef/modules/user/services/view_models/services_view_model.dart';
import 'package:aleef/modules/user/services/view_models/cart_view_model.dart';
import 'package:aleef/shared/widgets/price_filter_dialog.dart';
import 'package:aleef/shared/widgets/cart_badge.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Fetch products and categories when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ServicesViewModel>().getProducts();
      context.read<ServicesViewModel>().getCategories();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
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
        ],
        title: Text(
          'products'.tr(),
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
                child: Consumer<ServicesViewModel>(
                  builder: (context, servicesViewModel, child) {
                    return TextField(
                      controller: _searchController,
                      onChanged: (value) {
                        // Clear search when text is empty
                        if (value.isEmpty) {
                          context.read<ServicesViewModel>().clearSearch();
                        }
                      },
                      onSubmitted: (value) {
                        // Search when user presses enter
                        if (value.isNotEmpty) {
                          context.read<ServicesViewModel>().searchProducts(
                            value,
                          );
                        }
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
                          icon: const Icon(
                            Icons.search,
                            color: Color(0xFF6D9773),
                          ),
                          onPressed: () {
                            // Search when search icon is pressed
                            final query = _searchController.text.trim();
                            if (query.isNotEmpty) {
                              context.read<ServicesViewModel>().searchProducts(
                                query,
                              );
                            }
                          },
                        ),
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (servicesViewModel.searchQuery.isNotEmpty)
                              IconButton(
                                icon: const Icon(
                                  Icons.clear,
                                  color: Color(0xFF6D9773),
                                ),
                                onPressed: () {
                                  _searchController.clear();
                                  context
                                      .read<ServicesViewModel>()
                                      .clearSearch();
                                },
                              ),
                            IconButton(
                              icon: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: SvgPicture.asset(
                                  'assets/images/svg/fliter_icon.svg',
                                  width: 24,
                                  height: 24,
                                ),
                              ),
                              onPressed: () {
                                // Show price filter dialog
                                showDialog(
                                  context: context,
                                  builder: (context) =>
                                      Consumer<ServicesViewModel>(
                                        builder:
                                            (
                                              context,
                                              servicesViewModel,
                                              child,
                                            ) {
                                              return PriceFilterDialog(
                                                currentMinPrice:
                                                    servicesViewModel.minPrice,
                                                currentMaxPrice:
                                                    servicesViewModel.maxPrice,
                                                onApply: (minPrice, maxPrice) {
                                                  servicesViewModel
                                                      .applyPriceFilter(
                                                        minPrice: minPrice,
                                                        maxPrice: maxPrice,
                                                      );
                                                },
                                              );
                                            },
                                      ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18.0),
              child: Text(
                'shopping_categories'.tr(),
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 16.h),
            SizedBox(
              height: 140, // To accommodate container height + shadow
              child: Consumer<ServicesViewModel>(
                builder: (context, servicesViewModel, child) {
                  if (servicesViewModel.isLoadingCategories) {
                    return Center(
                      child: CircularProgressIndicator(color: AppColor.primary),
                    );
                  }

                  if (servicesViewModel.categoriesError != null) {
                    return Center(
                      child: Text(
                        'error_loading_categories'.tr(),
                        style: TextStyle(fontSize: 16, color: Colors.red),
                      ),
                    );
                  }

                  if (servicesViewModel.categories.isEmpty) {
                    return Center(
                      child: Text(
                        'no_categories_available'.tr(),
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    );
                  }

                  return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                    separatorBuilder: (context, index) => SizedBox(width: 12.w),
                    itemCount: servicesViewModel.categories.length,
                    itemBuilder: (context, index) {
                      final category = servicesViewModel.categories[index];
                      return GestureDetector(
                        onTap: () {
                          NavigationService().pushWidget(
                            CategoryScreen(
                              categoryName: category.name,
                              categoryId: category.id,
                            ),
                          );
                        },
                        child: Container(
                          width: 110,
                          height: 140,
                          padding: const EdgeInsets.all(19),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: Color(0xFFB0B0B0),
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0x40000000),
                                offset: const Offset(0, 4),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                category.name,
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 16,
                                  height: 1.0,
                                  letterSpacing: 0,
                                  color: Color(0xFF2D2D2D),
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 8),
                              Expanded(
                                child: category.image.isNotEmpty
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.network(
                                          category.image,
                                          fit: BoxFit.contain,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                                return Image.asset(
                                                  'assets/images/png/categort_temp.png',
                                                  fit: BoxFit.contain,
                                                );
                                              },
                                        ),
                                      )
                                    : Image.asset(
                                        'assets/images/png/categort_temp.png',
                                        fit: BoxFit.contain,
                                      ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 30.h),
            // Row title with plus icon in a circle

            // GridView of products
            Expanded(
              child: Consumer<ServicesViewModel>(
                builder: (context, servicesViewModel, child) {
                  if (servicesViewModel.isLoadingProducts) {
                    return Center(
                      child: CircularProgressIndicator(color: AppColor.primary),
                    );
                  }

                  if (servicesViewModel.productsError != null) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 64,
                            color: Colors.red,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'error_loading_products'.tr(),
                            style: TextStyle(fontSize: 16, color: Colors.red),
                          ),
                          SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              servicesViewModel.getProducts();
                            },
                            child: Text('retry'.tr()),
                          ),
                        ],
                      ),
                    );
                  }

                  if (servicesViewModel.products.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.inventory_2_outlined,
                            size: 64,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'no_products_available'.tr(),
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ],
                      ),
                    );
                  }

                  return GridView.builder(
                    padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: servicesViewModel.products.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 30,
                      childAspectRatio: 156 / 210,
                    ),
                    itemBuilder: (context, index) {
                      final product = servicesViewModel.products[index];
                      return GestureDetector(
                        onTap: () {
                          NavigationService().pushWidget(
                            ProductDetailsScreen(product: product),
                          );
                        },
                        child: Container(
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
                              SizedBox(height: 16),
                              Center(
                                child: Container(
                                  width: 120,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: product.image.isNotEmpty
                                        ? Image.network(
                                            product.image,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                                  return Image.asset(
                                                    'assets/images/png/product_item.png',
                                                    fit: BoxFit.cover,
                                                  );
                                                },
                                          )
                                        : Image.asset(
                                            'assets/images/png/product_item.png',
                                            fit: BoxFit.cover,
                                          ),
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
                                  product.name,
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
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${product.price} ريال',
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
                                    Consumer<CartViewModel>(
                                      builder: (context, cartViewModel, child) {
                                        final isInCart = cartViewModel.isInCart(
                                          product.id,
                                        );

                                        return GestureDetector(
                                          onTap: () {
                                            if (!isInCart) {
                                              cartViewModel.addToCart(product);
                                            }
                                            // If already in cart, do nothing
                                          },
                                          child: Container(
                                            width: 36,
                                            height: 36,
                                            decoration: BoxDecoration(
                                              color: isInCart
                                                  ? Colors.grey
                                                  : AppColor.primary,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Icon(
                                              isInCart
                                                  ? Icons.check
                                                  : Icons.add,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
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
