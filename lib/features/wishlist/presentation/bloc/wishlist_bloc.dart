import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:lyqx/features/home/domain/entities/product.dart';
import 'package:lyqx/features/wishlist/domain/repositories/wish_list_repo.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

@injectable
class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  final WishlistRepository repository;

  WishlistBloc(this.repository) : super(WishlistInitial()) {
    on<LoadWishlist>(_onLoadWishlist);
    on<AddToWishlist>(_onAddToWishlist);
    on<RemoveFromWishlist>(_onRemoveFromWishlist);
  }

  Future<void> _onLoadWishlist(
    LoadWishlist event,
    Emitter<WishlistState> emit,
  ) async {
    emit(WishlistLoading());
    try {
      final wishlist = await repository.getWishlist();
      emit(WishlistLoaded(wishlist));
    } catch (e) {
      emit(WishlistError(e.toString()));
    }
  }

  Future<void> _onAddToWishlist(
    AddToWishlist event,
    Emitter<WishlistState> emit,
  ) async {
    try {
      await repository.addToWishlist(event.product);
      final wishlist = await repository.getWishlist();
      emit(WishlistLoaded(wishlist));
    } catch (e) {
      emit(WishlistError(e.toString()));
    }
  }

  Future<void> _onRemoveFromWishlist(
    RemoveFromWishlist event,
    Emitter<WishlistState> emit,
  ) async {
    try {
      await repository.removeFromWishlist(event.productId);
      final wishlist = await repository.getWishlist();
      emit(WishlistLoaded(wishlist));
    } catch (e) {
      emit(WishlistError(e.toString()));
    }
  }
}
