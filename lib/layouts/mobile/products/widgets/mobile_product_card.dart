import 'package:drip_society/layouts/desktop/products/animated_card_button.dart';
import 'package:drip_society/layouts/desktop/products/data/product_model.dart';
import 'package:drip_society/layouts/desktop/products/widgets/product_image.dart';
import 'package:drip_society/layouts/desktop/products/widgets/product_price.dart';
import 'package:drip_society/layouts/desktop/products/widgets/product_title.dart';
import 'package:flutter/material.dart';

class MobileProductCard extends StatelessWidget {
  const MobileProductCard({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: .07),
            blurRadius: 22,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: ProductImage(imageUrl: product.imageUrl)),
            const SizedBox(height: 12),
            ProductTitle(
              englishName: product.nameEn,
              arabicName: product.nameAr,
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Theme.of(
                  context,
                ).colorScheme.primary.withValues(alpha: .1),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                '200g',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w800,
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(height: 10),
            ProductPrice(price: product.price),
            const SizedBox(height: 12),
            AnimatedCartButton(
              product: product,
              productId: product.id,
              label: 'Add To Cart',
            ),
          ],
        ),
      ),
    );
  }
}
