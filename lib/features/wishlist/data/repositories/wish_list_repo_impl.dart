import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:lyqx/core/constants/app_storage_keys.dart';
import 'package:lyqx/features/home/domain/entities/product.dart';
import 'package:lyqx/features/wishlist/domain/repositories/wish_list_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton(as: WishlistRepository)
class WishlistRepositoryImpl implements WishlistRepository {
  final SharedPreferences prefs;
  static const _wishlistKey = AppStorageKeys.wishlist;

  WishlistRepositoryImpl(this.prefs);

  @override
  Future<List<Product>> getWishlist() async {
    final jsonString = prefs.getString(_wishlistKey);
    if (jsonString == null) return [];

    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((json) => Product.fromJson(json)).toList();
  }

  @override
  Future<void> addToWishlist(Product product) async {
    final wishlist = await getWishlist();
    if (wishlist.any((item) => item.id == product.id)) return;

    wishlist.add(product);
    await _saveWishlist(wishlist);
  }

  @override
  Future<void> removeFromWishlist(int productId) async {
    final wishlist = await getWishlist();
    wishlist.removeWhere((item) => item.id == productId);
    await _saveWishlist(wishlist);
  }

  Future<void> _saveWishlist(List<Product> wishlist) async {
    final jsonList = wishlist.map((item) => item.toJson()).toList();
    await prefs.setString(_wishlistKey, jsonEncode(jsonList));
  }
}
