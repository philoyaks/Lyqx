part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();
}

class CartInitial extends CartState {
  @override
  List<Object> get props => [];
}

class CartLoading extends CartState {
  @override
  List<Object> get props => [];
}

class CartLoaded extends CartState {
  final List<CartItem> items;
  final double totalAmount;
  final String? successMessage; // Optional success message

  const CartLoaded(this.items, this.totalAmount, {this.successMessage});

  @override
  List<Object?> get props => [items, totalAmount, successMessage];
}

class CartError extends CartState {
  final String message;
  const CartError(this.message);
  @override
  List<Object> get props => [message];
}
