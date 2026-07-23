import 'package:flutter/material.dart';

class EmptyCartWidget extends StatelessWidget {
  const EmptyCartWidget({super.key, required this.onContinueShopping});

  final VoidCallback onContinueShopping;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.shopping_cart_outlined, size: 72, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 16),
            const Text('Your cart is empty', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('Add some premium coffee to continue.', textAlign: TextAlign.center),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: onContinueShopping,
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
              label: const Text('Continue Shopping'),
            ),
          ],
        ),
      ),
    );
  }
}
