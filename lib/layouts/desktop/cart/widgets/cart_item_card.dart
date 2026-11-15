import 'package:drip_society/layouts/desktop/cart/cubit/cart_item_cubit.dart';
import 'package:drip_society/layouts/desktop/cart/models/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:drip_society/l10n/generated/app_localizations.dart';

class CartItemCard extends StatelessWidget {
  const CartItemCard({super.key, required this.item});

  final CartItem item;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final l10n = AppLocalizations.of(context)!;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.network(
              item.product.imageUrl,
              width: 72,
              height: 72,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isArabic && item.product.nameAr.trim().isNotEmpty
                      ? item.product.nameAr
                      : item.product.nameEn,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                const SizedBox(height: 8),
                Text(
                  '${item.product.price.toStringAsFixed(0)} ${l10n.currencyEgp}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  IconButton(
                    tooltip: l10n.decreaseQuantity,
                    onPressed: () =>
                        context.read<CartCubit>().decrease(item.product),
                    icon: const Icon(Icons.remove_circle_outline),
                  ),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: Text(
                      '${item.quantity}',
                      key: ValueKey(item.quantity),
                    ),
                  ),
                  IconButton(
                    tooltip: l10n.increaseQuantity,
                    onPressed: () =>
                        context.read<CartCubit>().increase(item.product),
                    icon: const Icon(Icons.add_circle_outline),
                  ),
                ],
              ),
              IconButton(
                tooltip: l10n.removeItem,
                onPressed: () =>
                    context.read<CartCubit>().remove(item.product.id),
                icon: Icon(Icons.delete_outline, color: colorScheme.error),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
