import 'package:drip_society/layouts/desktop/products/data/cubit/products_cubit.dart';
import 'package:drip_society/layouts/desktop/products/data/products_skeleton_data.dart';
import 'package:drip_society/layouts/desktop/products/widgets/error_view.dart';
import 'package:drip_society/layouts/mobile/products/widgets/mobile_products_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MobileProductsSection extends StatelessWidget {
  const MobileProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final horizontalPadding = (width * .05).clamp(16.0, 24.0).toDouble();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        horizontalPadding,
        66,
        horizontalPadding,
        78,
      ),
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
              ).animate().fade(duration: 450.ms).slideY(begin: .12),
              const SizedBox(height: 14),
              Text(
                'Premium Coffee Collection',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  height: 1.15,
                ),
              ).animate().fade(delay: 100.ms).slideY(begin: .12),
              const SizedBox(height: 12),
              Text(
                    'Discover handcrafted premium coffee beans carefully roasted to bring unforgettable flavor in every cup.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 20, height: 1.8),
                  )
                  .animate(onPlay: (c) => c.repeat(reverse: true))
                  .scale(
                    begin: const Offset(1, 1),
                    end: const Offset(1.02, 1.02),
                    duration: 2200.ms,
                  )
                  .fade(duration: 500.ms),
              const SizedBox(height: 34),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 350),
                switchInCurve: Curves.easeOutCubic,
                switchOutCurve: Curves.easeInCubic,
                transitionBuilder: (child, animation) =>
                    FadeTransition(opacity: animation, child: child),
                child: isLoading
                    ? Skeletonizer(
                        key: const ValueKey('loading'),
                        enabled: true,
                        child: IgnorePointer(
                          child: MobileProductsGrid(
                            products: productsSkeletonData,
                          ),
                        ),
                      )
                    : isError
                    ? ErrorView(
                        key: const ValueKey('error'),
                        message: state.exception.message,
                        onRetry: () =>
                            context.read<ProductsCubit>().getProducts(),
                      )
                    : isSuccess && state.products.isEmpty
                    ? const Padding(
                        key: ValueKey('no-products'),
                        padding: EdgeInsets.all(24),
                        child: Text(
                          'No products are available right now.',
                          textAlign: TextAlign.center,
                        ),
                      )
                    : isSuccess
                    ? MobileProductsGrid(
                        key: const ValueKey('products'),
                        products: state.products,
                      )
                    : const SizedBox.shrink(key: ValueKey('initial')),
              ),
            ],
          );
        },
      ),
    );
  }
}
