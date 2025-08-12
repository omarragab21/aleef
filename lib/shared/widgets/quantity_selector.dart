import 'package:flutter/material.dart';
import '../assets/app_color.dart';
import '../assets/app_text_styles.dart';

class QuantitySelector extends StatefulWidget {
  final int initialQuantity;
  final int minQuantity;
  final int maxQuantity;
  final Function(int) onQuantityChanged;

  const QuantitySelector({
    super.key,
    this.initialQuantity = 1,
    this.minQuantity = 1,
    this.maxQuantity = 99,
    required this.onQuantityChanged,
  });

  @override
  State<QuantitySelector> createState() => _QuantitySelectorState();
}

class _QuantitySelectorState extends State<QuantitySelector> {
  late int _quantity;

  @override
  void initState() {
    super.initState();
    _quantity = widget.initialQuantity;
  }

  void _decreaseQuantity() {
    if (_quantity > widget.minQuantity) {
      setState(() {
        _quantity--;
      });
      widget.onQuantityChanged(_quantity);
    }
  }

  void _increaseQuantity() {
    if (_quantity < widget.maxQuantity) {
      setState(() {
        _quantity++;
      });
      widget.onQuantityChanged(_quantity);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.primary,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: AppColor.stroke2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: _quantity > widget.minQuantity
                ? _decreaseQuantity
                : null,
            icon: Icon(
              Icons.remove,
              color: _quantity > widget.minQuantity
                  ? Colors.white
                  : AppColor.lightGray,
              size: 20,
            ),
            constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
          ),
          Container(
            width: 40,
            alignment: Alignment.center,
            child: Text(
              '$_quantity',
              style: AppTextStyles.titleMedium.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          IconButton(
            onPressed: _quantity < widget.maxQuantity
                ? _increaseQuantity
                : null,
            icon: Icon(
              Icons.add,
              color: _quantity < widget.maxQuantity
                  ? Colors.white
                  : AppColor.lightGray,
              size: 20,
            ),
            constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
          ),
        ],
      ),
    );
  }
}
