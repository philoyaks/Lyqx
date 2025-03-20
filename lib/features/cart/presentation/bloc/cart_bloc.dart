import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:lyqx/features/cart/domain/entities/cart_items.dart';
import 'package:lyqx/features/cart/domain/repositories/cart_repository.dart';
import 'package:lyqx/features/home/domain/entities/product.dart';

part 'cart_event.dart';
part 'cart_state.dart';

@injectable
class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository repository;

  CartBloc(this.repository) : super(CartInitial()) {
    on<LoadCart>(_onLoadCart);
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<IncreaseQuantity>(_onIncreaseQuantity);
    on<DecreaseQuantity>(_onDecreaseQuantity);
  }

  Future<void> _onLoadCart(LoadCart event, Emitter<CartState> emit) async {
    emit(CartLoading());
    try {
      final cart = await repository.getCart();
      emit(CartLoaded(cart, _calculateTotal(cart)));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> _onAddToCart(AddToCart event, Emitter<CartState> emit) async {
    try {
      await repository.addToCart(event.product);
      final cart = await repository.getCart();
      emit(CartLoaded(cart, _calculateTotal(cart),
          successMessage: 'Added cart Successfully'));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> _onRemoveFromCart(
      RemoveFromCart event, Emitter<CartState> emit) async {
    try {
      await repository.removeFromCart(event.productId);
      final cart = await repository.getCart();
      emit(CartLoaded(cart, _calculateTotal(cart)));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> _onIncreaseQuantity(
      IncreaseQuantity event, Emitter<CartState> emit) async {
    try {
      await repository.increaseQuantity(event.productId);
      final cart = await repository.getCart();
      emit(CartLoaded(cart, _calculateTotal(cart)));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> _onDecreaseQuantity(
      DecreaseQuantity event, Emitter<CartState> emit) async {
    try {
      final currentCart = await repository.getCart();
      final item =
          currentCart.firstWhere((item) => item.product.id == event.productId);

      if (item.quantity > 1) {
        await repository.decreaseQuantity(event.productId);
      } else {
        await repository.removeFromCart(event.productId);
      }

      final updatedCart = await repository.getCart();
      emit(CartLoaded(updatedCart, _calculateTotal(updatedCart)));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  double _calculateTotal(List<CartItem> items) {
    return items.fold(
        0.0, (total, item) => total + (item.product.price * item.quantity));
  }
}
