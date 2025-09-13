import 'package:aleef/shared/assets/app_color.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PriceFilterDialog extends StatefulWidget {
  final double? currentMinPrice;
  final double? currentMaxPrice;
  final Function(double? minPrice, double? maxPrice) onApply;
  final bool isCategoryFilter;
  final int? categoryId;

  const PriceFilterDialog({
    super.key,
    this.currentMinPrice,
    this.currentMaxPrice,
    required this.onApply,
    this.isCategoryFilter = false,
    this.categoryId,
  });

  @override
  State<PriceFilterDialog> createState() => _PriceFilterDialogState();
}

class _PriceFilterDialogState extends State<PriceFilterDialog> {
  late TextEditingController _minPriceController;
  late TextEditingController _maxPriceController;
  RangeValues _rangeValues = const RangeValues(0, 1000);

  @override
  void initState() {
    super.initState();
    _minPriceController = TextEditingController(
      text: widget.currentMinPrice?.toString() ?? '',
    );
    _maxPriceController = TextEditingController(
      text: widget.currentMaxPrice?.toString() ?? '',
    );

    // Set initial range values
    _rangeValues = RangeValues(
      widget.currentMinPrice ?? 0,
      widget.currentMaxPrice ?? 1000,
    );
  }

  @override
  void dispose() {
    _minPriceController.dispose();
    _maxPriceController.dispose();
    super.dispose();
  }

  void _updateRangeFromText() {
    final minPrice = double.tryParse(_minPriceController.text) ?? 0;
    final maxPrice = double.tryParse(_maxPriceController.text) ?? 1000;

    setState(() {
      _rangeValues = RangeValues(
        minPrice.clamp(0, 1000),
        maxPrice.clamp(minPrice, 1000),
      );
    });
  }

  void _updateTextFromRange() {
    _minPriceController.text = _rangeValues.start.round().toString();
    _maxPriceController.text = _rangeValues.end.round().toString();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'price_range'.tr(),
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                    fontFamily: 'Cairo',
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close, color: Colors.grey),
                ),
              ],
            ),
            SizedBox(height: 20.h),

            // Price Range Slider
            Text(
              'select_price_range'.tr(),
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontFamily: 'Cairo',
              ),
            ),
            SizedBox(height: 16.h),

            RangeSlider(
              values: _rangeValues,
              min: 0,
              max: 1000,
              divisions: 100,
              activeColor: AppColor.primary,
              inactiveColor: Colors.grey[300],
              onChanged: (values) {
                setState(() {
                  _rangeValues = values;
                });
                _updateTextFromRange();
              },
            ),

            // Price Input Fields
            SizedBox(height: 20.h),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'min_price'.tr(),
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontFamily: 'Cairo',
                        ),
                      ),
                      SizedBox(height: 8.h),
                      TextField(
                        controller: _minPriceController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: '0',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: AppColor.primary),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 12.h,
                          ),
                        ),
                        onChanged: (value) => _updateRangeFromText(),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'max_price'.tr(),
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontFamily: 'Cairo',
                        ),
                      ),
                      SizedBox(height: 8.h),
                      TextField(
                        controller: _maxPriceController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: '1000',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: AppColor.primary),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 12.h,
                          ),
                        ),
                        onChanged: (value) => _updateRangeFromText(),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 24.h),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      _minPriceController.clear();
                      _maxPriceController.clear();
                      setState(() {
                        _rangeValues = const RangeValues(0, 1000);
                      });
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: AppColor.primary),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                    child: Text(
                      'clear'.tr(),
                      style: TextStyle(
                        color: AppColor.primary,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Cairo',
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      final minPrice = double.tryParse(
                        _minPriceController.text,
                      );
                      final maxPrice = double.tryParse(
                        _maxPriceController.text,
                      );

                      widget.onApply(minPrice, maxPrice);
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                    child: Text(
                      'apply'.tr(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Cairo',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
