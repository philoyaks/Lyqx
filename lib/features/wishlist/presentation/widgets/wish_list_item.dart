import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lyqx/core/constants/app_assets.dart';
import 'package:lyqx/features/home/domain/entities/product.dart';

class WishListItem extends StatelessWidget {
  final bool isLiked;
  final Product product;
  final VoidCallback? addorrRemoveFromWishList;
  final VoidCallback? addToCart;
  const WishListItem({super.key, this.isLiked = false, required this.product, this.addToCart, this.addorrRemoveFromWishList});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.only(
        bottom: 8,
      ),
      padding: EdgeInsets.only(left: 21, right: 16, top: 12, bottom: 12),
      decoration: ShapeDecoration(
        color: Color(0x0D000000),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: CachedNetworkImage(
                imageUrl: product.image,
                fit: BoxFit.contain,
                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) =>
                    Center(child: Icon(Icons.error, size: 40)),
              ),
            ),
          ),
          SizedBox(
            width: 21,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        product.title,
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: 8), // Small spacing between text and icon
                    GestureDetector(
                      onTap: addorrRemoveFromWishList,
                      child: SvgPicture.asset(
                          !isLiked ? AppAssets.heart : AppAssets.unionIcon),
                    )
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Opacity(
                  opacity: 0.90,
                  child: Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: Color(0xBF000000),
                      fontSize: 12,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: addToCart,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 71, vertical: 8),
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
                    ),
                    child: Text(
                      'Add to cart',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
