import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lyqx/features/home/presentation/bloc/product_bloc.dart';
import 'package:lyqx/shared/widgets/header.dart';
import 'package:lyqx/features/home/presentation/widgets/product_card.dart';
import 'package:lyqx/features/wishlist/presentation/bloc/wishlist_bloc.dart';

// Placeholder Screens
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Header(title: 'Welcome, \nUsername'),
          SizedBox(
            height: 32,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Fake Store',
              style: TextStyle(
                color: const Color(0xFF252425),
                fontSize: 28,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w600,
                height: 1.25,
              ),
            ),
          ),
          BlocBuilder<ProductsBloc, ProductsState>(
            builder: (context, state) {
              if (state is ProductsLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is ProductsLoaded) {
                return Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.only(top: 30),
                    itemCount: state.products.length,
                    itemBuilder: (context, index) {
                      final product = state.products[index];

                      return BlocBuilder<WishlistBloc, WishlistState>(
                        builder: (context, state) {
                          final isWishlisted = state is WishlistLoaded &&
                              state.wishlist
                                  .any((item) => item.id == product.id);

                          return ProductCardItem(
                            product: product,
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
                          );
                        },
                      );
                    },
                  ),
                );
              }
              if (state is ProductsError) {
                return Center(child: Text(state.message));
              }
              return const Center(child: Text('No products loaded'));
            },
          ),
        ],
      ),
    );
  }
}
