import 'package:drip_society/layouts/desktop/products/data/product_model.dart';
import 'package:drip_society/layouts/desktop/products/widgets/product_card.dart';
import 'package:flutter/material.dart';

class ProductsGrid extends StatelessWidget {
  const ProductsGrid({
    super.key,
    required this.products,
    required this.crossAxisCount,
  });

  final List<ProductModel> products;
  final int crossAxisCount;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxCrossAxisExtent = constraints.maxWidth;
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: products.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: maxCrossAxisExtent > 1000 ? 0.73 : 0.72,
          ),
          itemBuilder: (context, index) => ProductCard(product: products[index]),
        );
      },
    );
  }
}
