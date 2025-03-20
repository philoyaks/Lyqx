import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:lyqx/core/constants/app_assets.dart';
import 'package:lyqx/core/constants/app_route_paths.dart';
import 'package:lyqx/features/home/domain/entities/product.dart';

class ProductCardItem extends StatelessWidget {
  final bool isLiked;
  final Product product;
  final VoidCallback? addorrRemoveFromWishList;
  const ProductCardItem(
      {super.key,
      this.isLiked = false,
      required this.product,
      this.addorrRemoveFromWishList});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(AppRoutePaths.productDetailsRoute, extra: product);
      },
      child: Container(
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
                      Icon(Icons.error, size: 40),
                ),
              ),
            ),
            SizedBox(
              width: 37,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 170,
                        child: Text(
                          product.title,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: addorrRemoveFromWishList,
                        child: SvgPicture.asset(
                            !isLiked ? AppAssets.heart : AppAssets.unionIcon),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  SizedBox(
                    width: 170,
                    child: Text(
                      product.category,
                      style: TextStyle(
                        color: Colors.black.withValues(alpha: 128),
                        fontSize: 12,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(AppAssets.starIcon),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        product.rating.rate.toStringAsFixed(2),
                        style: TextStyle(
                          color: const Color(0xFF303539),
                          fontSize: 12,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Opacity(
                    opacity: 0.90,
                    child: Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Colors.black.withValues(alpha: 191),
                        fontSize: 14,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
