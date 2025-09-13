import 'package:flutter/material.dart';
import '../models/cart_item_model.dart';
import '../models/product_model.dart';

class CartViewModel extends ChangeNotifier {
  final List<CartItemModel> _cartItems = [];

  List<CartItemModel> get cartItems => List.unmodifiable(_cartItems);

  int get itemCount => _cartItems.fold(0, (sum, item) => sum + item.quantity);

  double get totalPrice =>
      _cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);

  bool get isEmpty => _cartItems.isEmpty;

  bool get isNotEmpty => _cartItems.isNotEmpty;

  void addToCart(ProductModel product, {int quantity = 1}) {
    final existingIndex = _cartItems.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (existingIndex == -1) {
      // Only add if product doesn't exist in cart
      _cartItems.add(CartItemModel(product: product, quantity: quantity));
      notifyListeners();
    }
    // If product already exists, do nothing
  }

  void removeFromCart(int productId) {
    _cartItems.removeWhere((item) => item.product.id == productId);
    notifyListeners();
  }

  void updateQuantity(int productId, int quantity) {
    if (quantity <= 0) {
      removeFromCart(productId);
      return;
    }

    final existingIndex = _cartItems.indexWhere(
      (item) => item.product.id == productId,
    );

    if (existingIndex != -1) {
      _cartItems[existingIndex] = _cartItems[existingIndex].copyWith(
        quantity: quantity,
      );
      notifyListeners();
    }
  }

  void incrementQuantity(int productId) {
    final existingIndex = _cartItems.indexWhere(
      (item) => item.product.id == productId,
    );

    if (existingIndex != -1) {
      _cartItems[existingIndex] = _cartItems[existingIndex].copyWith(
        quantity: _cartItems[existingIndex].quantity + 1,
      );
      notifyListeners();
    }
  }

  void decrementQuantity(int productId) {
    final existingIndex = _cartItems.indexWhere(
      (item) => item.product.id == productId,
    );

    if (existingIndex != -1) {
      final currentQuantity = _cartItems[existingIndex].quantity;
      if (currentQuantity > 1) {
        _cartItems[existingIndex] = _cartItems[existingIndex].copyWith(
          quantity: currentQuantity - 1,
        );
      } else {
        removeFromCart(productId);
      }
      notifyListeners();
    }
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  int getProductQuantity(int productId) {
    final existingIndex = _cartItems.indexWhere(
      (item) => item.product.id == productId,
    );
    return existingIndex != -1 ? _cartItems[existingIndex].quantity : 0;
  }

  bool isInCart(int productId) {
    return _cartItems.any((item) => item.product.id == productId);
  }
}
