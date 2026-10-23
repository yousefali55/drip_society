import 'package:drip_society/core/responsive/responsive_layout.dart';
import 'package:drip_society/layouts/desktop/products/data/cubit/products_cubit.dart';
import 'package:drip_society/layouts/desktop/products/data/product_model.dart';
import 'package:drip_society/layouts/desktop/products/data/products_skeleton_data.dart';
import 'package:drip_society/layouts/desktop/products/widgets/error_view.dart';
import 'package:drip_society/layouts/desktop/products/widgets/products_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductsSection extends StatelessWidget {
  const ProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      color: Colors.transparent,
      child: BlocBuilder<ProductsCubit, ProductsState>(
        builder: (context, state) {
          final isLoading = state is ProductsLoading;
          final isError = state is ProductsFailure;
          final isSuccess = state is ProductsSuccess;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'OUR PRODUCTS',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  letterSpacing: 3,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                'Premium Coffee Collection',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Text(
                    'Discover handcrafted premium coffee beans carefully roasted to bring unforgettable flavor in every cup.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 30, height: 1.8),
                  )
                  .animate(onPlay: (c) => c.repeat(reverse: true))
                  .scale(
                    begin: const Offset(1, 1),
                    end: const Offset(1.02, 1.02),
                    duration: 2200.ms,
                  )
                  .fade(duration: 500.ms),
              const SizedBox(height: 24),
              Padding(padding: const EdgeInsets.symmetric(horizontal: 24)),
              const SizedBox(height: 32),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 350),
                switchInCurve: Curves.easeOutCubic,
                switchOutCurve: Curves.easeInCubic,
                transitionBuilder: (child, animation) {
                  return FadeTransition(opacity: animation, child: child);
                },
                child: isLoading
                    ? const _ProductsSkeletonGrid(key: ValueKey('loading'))
                    : isError
                    ? ErrorView(
                        key: const ValueKey('error'),
                        message: state.exception.message,
                        onRetry: () =>
                            context.read<ProductsCubit>().getProducts(),
                      )
                    : isSuccess && state.products.isEmpty
                    ? const _EmptyProductsView(key: ValueKey('no-products'))
                    : isSuccess
                    ? _ProductsGridContent(
                        key: const ValueKey('products'),
                        products: state.products,
                      )
                    : const SizedBox.shrink(key: ValueKey('empty')),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ProductsSkeletonGrid extends StatelessWidget {
  const _ProductsSkeletonGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: IgnorePointer(
        child: _ProductsGridContent(products: productsSkeletonData),
      ),
    );
  }
}

class _ProductsGridContent extends StatelessWidget {
  const _ProductsGridContent({super.key, required this.products});

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: ProductsGrid(products: products, crossAxisCount: 2),
      desktop: ProductsGrid(products: products, crossAxisCount: 4),
    );
  }
}

class _EmptyProductsView extends StatelessWidget {
  const _EmptyProductsView({super.key});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(24),
    child: Text(
      'No products are available right now.',
      style: Theme.of(context).textTheme.bodyLarge,
      textAlign: TextAlign.center,
    ),
  );
}
