import 'package:drip_society/layouts/desktop/cart/cubit/cart_item_cubit.dart';
import 'package:drip_society/layouts/desktop/cart/cubit/cart_item_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBadge extends StatelessWidget {
  const CartBadge({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        final count = state.items.fold<int>(
          0,
          (sum, item) => sum + item.quantity,
        );
        return Center(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: InkWell(
              key: ValueKey(count),
              onTap: onTap,
              borderRadius: BorderRadius.circular(999),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Icon(Icons.shopping_cart_outlined, size: 24),
                  if (count > 0)
                    Positioned(
                      top: -2,
                      right: -2,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: colorScheme.error,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '$count',
                          style: TextStyle(
                            color: colorScheme.onError,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
