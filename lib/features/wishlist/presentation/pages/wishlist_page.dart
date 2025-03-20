import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lyqx/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:lyqx/shared/widgets/header.dart';
import 'package:lyqx/features/wishlist/presentation/widgets/wish_list_item.dart';
import 'package:lyqx/features/wishlist/presentation/bloc/wishlist_bloc.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartBloc, CartState>(
      listener: (context, state) {
        if (state is CartLoaded) {
          if (state.successMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.successMessage ?? '')),
            );
          }
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Header(
              title: 'Wishlist',
            ),
            BlocBuilder<WishlistBloc, WishlistState>(
              builder: (context, wishlistState) {
                if (wishlistState is WishlistLoaded) {
                  return Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.only(top: 30),
                      itemCount: wishlistState.wishlist.length,
                      itemBuilder: (context, index) {
                        final product = wishlistState.wishlist[index];
                        final isWishlisted = wishlistState.wishlist
                            .any((item) => item.id == product.id);

                        return WishListItem(
                          isLiked: isWishlisted,
                          addorrRemoveFromWishList: () {
                            if (isWishlisted) {
                              context
                                  .read<WishlistBloc>()
                                  .add(RemoveFromWishlist(product.id));
                            } else {
                              context
                                  .read<WishlistBloc>()
                                  .add(AddToWishlist(product));
                            }
                          },
                          addToCart: () {
                            context.read<CartBloc>().add(AddToCart(product));
                          },
                          product: product,
                        );
                      },
                    ),
                  );
                } else {
                  return Expanded(
                      child: Center(child: Text('You have no Wishlist Yet')));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
