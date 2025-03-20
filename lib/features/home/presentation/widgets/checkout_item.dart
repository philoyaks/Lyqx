import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lyqx/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:lyqx/shared/widgets/app_button.dart';

class CheckoutItem extends StatelessWidget {
  const CheckoutItem({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoaded) {
          final amount = state.totalAmount;
          if (amount <= 0) {
            return SizedBox();
          }

          return Container(
            height: 96,
            padding: const EdgeInsets.all(24),
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                    width: 1,
                    strokeAlign: BorderSide.strokeAlignCenter,
                    color: Color(0x1A000000)),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Cart total',
                      style: TextStyle(
                        color: const Color(0xFF616161),
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        height: 1,
                      ),
                    ),
                    Text(
                      '\$${amount.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: const Color(0xFF3A3A3A),
                        fontSize: 20,
                        fontFamily: 'Lora',
                        fontWeight: FontWeight.w600,
                        height: 1.20,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  width: 24,
                ),
                Expanded(child: AppButton(label: 'Checkout', onPressed: () {}))
              ],
            ),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}
