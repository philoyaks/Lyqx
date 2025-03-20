import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lyqx/core/constants/app_assets.dart';
import 'package:lyqx/features/cart/domain/entities/cart_items.dart';

class SwipeableCartItemCard extends StatelessWidget {
  final VoidCallback? onDecrease;
  final VoidCallback? onIncrease;
  final VoidCallback? onDelete;
  final CartItem cartItem;

  const SwipeableCartItemCard({
    super.key,
    this.onDecrease,
    this.onIncrease,
    this.onDelete,
    required this.cartItem,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: key ?? UniqueKey(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20, left: 20),
        color: Colors.red,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 30,
        ),
      ),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.endToStart) {
          // Return false to prevent full dismissal
          if (onDelete != null) {
            onDelete!();
          }
          return false;
        }
        return false;
      },
      // Allow only right to left swipe (revealing delete from right side)
      direction: DismissDirection.endToStart,
      child: CartItemCard(
        onDecrease: onDecrease,
        onIncrease: onIncrease,
        cartItem: cartItem,
      ),
    );
  }
}

class CartItemCard extends StatelessWidget {
  final VoidCallback? onDecrease;
  final VoidCallback? onIncrease;
  final CartItem cartItem;
  const CartItemCard(
      {super.key, this.onDecrease, this.onIncrease, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16),
      margin: EdgeInsets.only(bottom: 24),
      child: Row(
        spacing: 0,
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child: CachedNetworkImage(
              imageUrl: cartItem.product.image,
              fit: BoxFit.contain,
              placeholder: (context, url) =>
                  Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Icon(Icons.error, size: 40),
            ),
          ),
          SizedBox(
            width: 16,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 170,
                child: Text(
                  cartItem.product.title,
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w600,
                    height: 1.25,
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                height: 36,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 1,
                      color: Colors.black.withValues(alpha: 26),
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 12,
                  children: [
                    GestureDetector(
                      onTap: onDecrease,
                      child: SvgPicture.asset(
                        AppAssets.minusCircle,
                        height: 20,
                        width: 20,
                      ),
                    ),
                    Container(
                      width: 1,
                      height: double.infinity,
                      decoration: BoxDecoration(color: const Color(0xFFD9D9D9)),
                    ),
                    SizedBox(
                      width: 20,
                      child: Text(
                        cartItem.quantity.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xFF252425),
                          fontSize: 14,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w600,
                          height: 1.43,
                        ),
                      ),
                    ),
                    Container(
                      width: 1,
                      height: double.infinity,
                      decoration: BoxDecoration(color: const Color(0xFFD9D9D9)),
                    ),
                    GestureDetector(
                        onTap: onIncrease,
                        child: SvgPicture.asset(
                          AppAssets.plusCircle,
                          height: 20,
                          width: 20,
                        )),
                  ],
                ),
              ),
            ],
          ),
          Spacer(),
          Opacity(
            opacity: 0.90,
            child: Text(
              '\$${cartItem.product.price.toStringAsFixed(2)}',
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w600,
                height: 1.25,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
