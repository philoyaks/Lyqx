import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lyqx/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:lyqx/features/cart/presentation/widgets/cart_item_card.dart';
import 'package:lyqx/shared/widgets/header.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Header(
            title: 'Cart',
          ),
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if (state is CartLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is CartError) {
                return Center(child: Text(state.message));
              }

              if (state is CartLoaded && state.items.isNotEmpty) {
                final items = state.items;

                return Expanded(
                  child: ListView.builder(
                      itemCount: items.length,
                      padding: EdgeInsets.only(top: 30),
                      itemBuilder: (context, index) {
                        final item = state.items[index];
                        return SwipeableCartItemCard(
                          cartItem: item,
                          key: ValueKey(items[index]),
                          onDelete: () {
                            context
                                .read<CartBloc>()
                                .add(RemoveFromCart(item.product.id));
                          },
                          onDecrease: () {
                            context
                                .read<CartBloc>()
                                .add(DecreaseQuantity(item.product.id));
                          },
                          onIncrease: () {
                            context
                                .read<CartBloc>()
                                .add(IncreaseQuantity(item.product.id));
                          },
                        );
                      }),
                );
              }
              return Expanded(
                  child: const Center(child: Text('Your cart is empty')));
            },
          )
        ],
      ),
    );
  }
}
