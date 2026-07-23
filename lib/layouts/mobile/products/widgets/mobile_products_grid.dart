import 'package:drip_society/layouts/desktop/products/data/product_model.dart';
import 'package:drip_society/layouts/mobile/products/widgets/mobile_product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class MobileProductsGrid extends StatelessWidget {
  const MobileProductsGrid({super.key, required this.products});

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth < 360 ? 1 : 2;
        final spacing = constraints.maxWidth < 360 ? 16.0 : 14.0;
        final aspectRatio = crossAxisCount == 1 ? .78 : .55;

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: products.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: spacing,
            mainAxisSpacing: spacing,
            childAspectRatio: aspectRatio,
          ),
          itemBuilder: (context, index) {
            return MobileProductCard(product: products[index])
                .animate(delay: (index * 55).ms)
                .fade(duration: 380.ms)
                .slideY(begin: .08);
          },
        );
      },
    );
  }
}
