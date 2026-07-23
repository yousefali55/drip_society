import 'package:drip_society/layouts/desktop/cart/cubit/cart_item_state.dart';
import 'package:flutter/material.dart';

class CartSummary extends StatelessWidget {
  const CartSummary({super.key, required this.state});

  final CartState state;

  @override
  Widget build(BuildContext context) {
    final subtotal = state.totalPrice;
    const delivery = 0.0;
    final total = subtotal + delivery;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.25),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          _summaryRow('Subtotal', '${subtotal.toStringAsFixed(0)} EGP'),
          const SizedBox(height: 8),
          _summaryRow('Delivery', 'Free'),
          const Divider(height: 20),
          _summaryRow('Total', '${total.toStringAsFixed(0)} EGP', isBold: true),
        ],
      ),
    );
  }

  Widget _summaryRow(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.w500)),
        Text(value, style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.w500)),
      ],
    );
  }
}
