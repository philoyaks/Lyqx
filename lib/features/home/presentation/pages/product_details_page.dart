import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:lyqx/core/constants/app_assets.dart';
import 'package:lyqx/core/di/injection.config.dart';
import 'package:lyqx/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:lyqx/features/home/domain/entities/product.dart';
import 'package:lyqx/features/wishlist/presentation/bloc/wishlist_bloc.dart';
import 'package:lyqx/shared/widgets/app_button.dart';

class ProductDetailsPage extends StatelessWidget {
  final Product product;
  const ProductDetailsPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () => getIt<GoRouter>().pop(),
                    child: Icon(Icons.arrow_back)),
                BlocBuilder<WishlistBloc, WishlistState>(
                  builder: (context, state) {
                    final isLiked = state is WishlistLoaded
                        ? state.wishlist
                                .where((e) => e.id == product.id)
                                .firstOrNull !=
                            null
                        : false;

                    return GestureDetector(
                        onTap: () {
                          if (isLiked) {
                            context
                                .read<WishlistBloc>()
                                .add(RemoveFromWishlist(product.id));
                          } else {
                            context
                                .read<WishlistBloc>()
                                .add(AddToWishlist(product));
                          }
                        },
                        child: SvgPicture.asset(
                            !isLiked ? AppAssets.heart : AppAssets.unionIcon));
                  },
                )
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Container(
                width: 267,
                height: 204,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x26000000),
                      blurRadius: 7,
                      offset: const Offset(0, 7),
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: CachedNetworkImage(
                  imageUrl: product.image,
                  fit: BoxFit.contain,
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(
                      color: Colors.grey[300],
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey[200],
                    child: const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 40,
                    ),
                  ),
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 342,
                  child: Text(
                    product.title,
                    style: TextStyle(
                      color: Color(0xBF000000),
                      fontSize: 24,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  product.category,
                  style: TextStyle(
                    color: Color(0x80000000),
                    fontSize: 14,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  spacing: 2,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(AppAssets.starIcon),
                    Text(
                      product.rating.rate.toStringAsFixed(2),
                      style: TextStyle(
                        color: const Color(0xFF303539),
                        fontSize: 14,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '${product.rating.count} Reviews',
                      style: TextStyle(
                        color: const Color(0xFFA6A6AA),
                        fontSize: 14,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w600,
                        height: 1.14,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 24,
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(color: const Color(0xFFFFE8B2)),
            child: Row(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8,
                  children: [
                    Text(
                      'Price',
                      style: TextStyle(
                        color: const Color(0xFF616161),
                        fontSize: 12,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        height: 1,
                      ),
                    ),
                    Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: const Color(0xFF3A3A3A),
                        fontSize: 20,
                        fontFamily: 'Lora',
                        fontWeight: FontWeight.w600,
                        height: 1.20,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 24,
                ),
                Expanded(
                  child: AppButton(
                    label: 'Add to cart',
                    onPressed: () {
                      context.read<CartBloc>().add(AddToCart(product));
                    },
                  ),
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
