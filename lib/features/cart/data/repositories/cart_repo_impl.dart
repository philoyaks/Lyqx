import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:lyqx/core/constants/app_storage_keys.dart';
import 'package:lyqx/features/cart/domain/entities/cart_items.dart';
import 'package:lyqx/features/cart/domain/repositories/cart_repository.dart';
import 'package:lyqx/features/home/domain/entities/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton(as: CartRepository)
class CartRepositoryImpl implements CartRepository {
  final SharedPreferences prefs;
  static const _cartKey = AppStorageKeys.cart;

  CartRepositoryImpl(this.prefs);

  @override
  Future<List<CartItem>> getCart() async {
    final jsonString = prefs.getString(_cartKey);
    if (jsonString == null) return [];

    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((item) {
      return CartItem(
        product: Product.fromJson(item['product']),
        quantity: item['quantity'],
      );
    }).toList();
  }

  @override
  Future<void> increaseQuantity(int productId) async {
    final cart = await getCart();
    final index = cart.indexWhere((item) => item.product.id == productId);
    if (index == -1) return;

    cart[index] = cart[index].copyWith(quantity: cart[index].quantity + 1);
    await _saveCart(cart);
  }

  @override
  Future<void> decreaseQuantity(int productId) async {
    final cart = await getCart();
    final index = cart.indexWhere((item) => item.product.id == productId);
    if (index == -1) return;

    cart[index] = cart[index].copyWith(quantity: cart[index].quantity - 1);
    await _saveCart(cart);
  }

  @override
  Future<void> addToCart(Product product) async {
    final cart = await getCart();
    final index = cart.indexWhere((item) => item.product.id == product.id);

    if (index != -1) {
      cart[index] = cart[index].copyWith(quantity: cart[index].quantity + 1);
    } else {
      cart.add(CartItem(product: product));
    }

    await _saveCart(cart);
  }

  @override
  Future<void> removeFromCart(int productId) async {
    final cart = await getCart();
    cart.removeWhere((item) => item.product.id == productId);
    await _saveCart(cart);
  }

  Future<void> _saveCart(List<CartItem> cart) async {
    final jsonList = cart
        .map((item) => {
              'product': item.product.toJson(),
              'quantity': item.quantity,
            })
        .toList();

    await prefs.setString(_cartKey, jsonEncode(jsonList));
  }

  @override
  Future<void> clearCart() async {
    await prefs.remove(_cartKey);
  }
}
