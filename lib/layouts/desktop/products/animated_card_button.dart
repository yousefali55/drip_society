import 'package:drip_society/layouts/desktop/cart/cubit/cart_item_cubit.dart';
import 'package:drip_society/layouts/desktop/cart/cubit/cart_item_state.dart';
import 'package:drip_society/layouts/desktop/products/data/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnimatedCartButton extends StatelessWidget {
  final ProductModel product;
  final String label;

  const AnimatedCartButton({
    super.key,
    required this.product,
    required String productId,
    this.label = 'Add',
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        final quantity = context.read<CartCubit>().quantity(product.id);

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) {
            return ScaleTransition(
              scale: animation,
              child: FadeTransition(opacity: animation, child: child),
            );
          },
          child: quantity == 0
              ? _buildButton(context)
              : _buildCounter(context, quantity),
        );
      },
    );
  }

  Widget _buildButton(BuildContext context) {
    return SizedBox(
      key: const ValueKey(0),
      width: double.infinity,
      child: FilledButton(
        onPressed: () {
          context.read<CartCubit>().add(product);
        },
        child: Text(label),
      ),
    );
  }

  Widget _buildCounter(BuildContext context, int quantity) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      key: const ValueKey(1),
      height: 52,
      decoration: BoxDecoration(
        color: colorScheme.primary,
        borderRadius: BorderRadius.circular(14),
      ),

      child: Row(
        children: [
          Expanded(
            child: IconButton(
              onPressed: () {
                context.read<CartCubit>().decrease(product);
              },
              icon: Icon(Icons.remove, color: colorScheme.onPrimary),
            ),
          ),

          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: Text(
              "$quantity",
              key: ValueKey(quantity),
              style: TextStyle(
                color: colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 19,
              ),
            ),
          ),

          Expanded(
            child: IconButton(
              onPressed: () {
                context.read<CartCubit>().increase(product);
              },
              icon: Icon(Icons.add, color: colorScheme.onPrimary),
            ),
          ),
        ],
      ),
    );
  }
}
