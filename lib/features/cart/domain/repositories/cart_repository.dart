import 'package:lyqx/features/cart/domain/entities/cart_items.dart';
import 'package:lyqx/features/home/domain/entities/product.dart';

abstract class CartRepository {
  Future<List<CartItem>> getCart();
  Future<void> addToCart(Product product);
  Future<void> removeFromCart(int productId);
  Future<void> clearCart();
    Future<void> increaseQuantity(int productId);
  Future<void> decreaseQuantity(int productId);
}
