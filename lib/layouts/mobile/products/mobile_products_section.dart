import 'package:drip_society/layouts/desktop/products/data/cubit/products_cubit.dart';
import 'package:drip_society/layouts/desktop/products/data/products_repo.dart';
import 'package:drip_society/layouts/desktop/products/widgets/error_view.dart';
import 'package:drip_society/layouts/mobile/products/widgets/mobile_products_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
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
      child: BlocProvider(
        create: (context) => ProductsCubit(ProductsRepository())..getProducts(),
        child: BlocBuilder<ProductsCubit, ProductsState>(
          builder: (context, state) {
            final isLoading = state is ProductsLoading;
            final isError = state is ProductsError;
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
                    style: GoogleFonts.roboto(fontSize: 20, height: 1.8),
                  )
                  .animate(onPlay: (c) => c.repeat(reverse: true))
                  .scale(
                    begin: const Offset(1, 1),
                    end: const Offset(1.02, 1.02),
                    duration: 2200.ms,
                  )
                  .fade(duration: 500.ms),
                const SizedBox(height: 34),
                if (isLoading)
                  const Skeletonizer(child: MobileProductsGrid(products: []))
                else if (isError)
                  ErrorView(
                    message: state.errorMessage,
                    onRetry: () => context.read<ProductsCubit>().getProducts(),
                  )
                else if (isSuccess)
                  MobileProductsGrid(products: state.products)
                else
                  const SizedBox.shrink(),
              ],
            );
          },
        ),
      ),
    );
  }
}
