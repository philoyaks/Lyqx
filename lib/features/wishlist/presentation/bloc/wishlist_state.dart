part of 'wishlist_bloc.dart';


abstract class WishlistState extends Equatable {
  const WishlistState();
}

class WishlistInitial extends WishlistState {
  @override
  List<Object> get props => [];
}

class WishlistLoading extends WishlistState {
  @override
  List<Object> get props => [];
}

class WishlistLoaded extends WishlistState {
  final List<Product> wishlist;
  const WishlistLoaded(this.wishlist);
  @override
  List<Object> get props => [wishlist];
}

class WishlistError extends WishlistState {
  final String message;
  const WishlistError(this.message);
  @override
  List<Object> get props => [message];
}
