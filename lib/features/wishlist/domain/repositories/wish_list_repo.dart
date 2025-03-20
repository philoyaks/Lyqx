import 'package:lyqx/features/home/domain/entities/product.dart';

abstract class WishlistRepository {
  Future<List<Product>> getWishlist();
  Future<void> addToWishlist(Product product);
  Future<void> removeFromWishlist(int productId);
}
