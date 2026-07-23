import 'package:drip_society/layouts/desktop/products/animated_card_button.dart';
import 'package:drip_society/layouts/desktop/products/data/product_model.dart';
import 'package:drip_society/layouts/desktop/products/widgets/product_image.dart';
import 'package:drip_society/layouts/desktop/products/widgets/product_price.dart';
import 'package:drip_society/layouts/desktop/products/widgets/product_title.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({super.key, required this.product});

  final ProductModel product;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return MouseRegion(
      onEnter: (_) => setState(() => hover = true),
      onExit: (_) => setState(() => hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        transform: Matrix4.translationValues(0, hover ? -10 : 0, 0),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withValues(alpha: hover ? 0.12 : 0.05),
              blurRadius: hover ? 30 : 15,
              offset: const Offset(0, 15),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: AnimatedScale(
                  scale: hover ? 1.04 : 1,
                  duration: const Duration(milliseconds: 250),
                  child: ProductImage(imageUrl: widget.product.imageUrl),
                ),
              ),
              const SizedBox(height: 14),
              ProductTitle(
                englishName: widget.product.nameEn,
                arabicName: widget.product.nameAr,
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  widget.product.stock > 0 ? 'In Stock' : 'Out of Stock',
                  style: TextStyle(color: colorScheme.primary),
                ),
              ),
              const SizedBox(height: 14),
              ProductPrice(price: widget.product.price),
              const Spacer(),
              AnimatedCartButton(
                product: widget.product,
                productId: widget.product.id,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
