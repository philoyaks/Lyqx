part of 'wishlist_bloc.dart';


abstract class WishlistEvent extends Equatable {
  const WishlistEvent();
}

class LoadWishlist extends WishlistEvent {
  @override
  List<Object> get props => [];
}

class AddToWishlist extends WishlistEvent {
  final Product product;
  const AddToWishlist(this.product);
  @override
  List<Object> get props => [product];
}

class RemoveFromWishlist extends WishlistEvent {
  final int productId;
  const RemoveFromWishlist(this.productId);
  @override
  List<Object> get props => [productId];
}
