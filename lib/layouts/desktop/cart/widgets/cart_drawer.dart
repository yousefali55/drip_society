import 'package:drip_society/core/responsive/responsive_layout.dart';
import 'package:drip_society/features/auth/cubit/auth_cubit.dart';
import 'package:drip_society/features/auth/presentation/widgets/auth_form_dialog.dart';
import 'package:drip_society/features/checkout/presentation/widgets/checkout_dialog.dart';
import 'package:drip_society/layouts/desktop/cart/cubit/cart_item_cubit.dart';
import 'package:drip_society/layouts/desktop/cart/cubit/cart_item_state.dart';
import 'package:drip_society/layouts/desktop/cart/widgets/cart_item_card.dart';
import 'package:drip_society/layouts/desktop/cart/widgets/cart_summary.dart';
import 'package:drip_society/layouts/desktop/cart/widgets/confirm_order_button.dart';
import 'package:drip_society/layouts/desktop/cart/widgets/empty_cart_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartDrawer extends StatefulWidget {
  const CartDrawer({super.key});

  @override
  State<CartDrawer> createState() => _CartDrawerState();
}

class _CartDrawerState extends State<CartDrawer> {
  bool _isSubmitting = false;

  Future<void> _submitOrder(BuildContext context) async {
    final cubit = context.read<CartCubit>();
    if (cubit.state.items.isEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Your cart is empty')));
      return;
    }

    final authState = context.read<AuthCubit>().state;
    if (!authState.isAuthenticated || authState.customer == null) {
      if (!mounted) return;
      await showDialog<void>(
        context: context,
        builder: (_) => const AuthFormDialog(mode: AuthMode.login),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      await showDialog<void>(
        context: context,
        builder: (_) => CheckoutDialog(customer: authState.customer!),
      );
      if (!mounted) return;
      if (!context.mounted) return;
      Navigator.of(context).pop();
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        final isEmpty = state.items.isEmpty;
        return ResponsiveLayout(
          mobile: _buildSheet(context, state, isEmpty),
          desktop: _buildDrawer(context, state, isEmpty),
        );
      },
    );
  }

  Widget _buildDrawer(BuildContext context, CartState state, bool isEmpty) {
    return Drawer(
      width: 420,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'Your Cart',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              if (isEmpty)
                Expanded(
                  child: EmptyCartWidget(
                    onContinueShopping: () => Navigator.of(context).pop(),
                  ),
                )
              else
                Expanded(
                  child: ListView(
                    children: [
                      ...state.items.map((item) => CartItemCard(item: item)),
                      const SizedBox(height: 12),
                      CartSummary(state: state),
                      const SizedBox(height: 16),
                      ConfirmOrderButton(
                        onPressed: () => _submitOrder(context),
                        isLoading: _isSubmitting,
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSheet(BuildContext context, CartState state, bool isEmpty) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Text(
                  'Your Cart',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            if (isEmpty)
              Expanded(
                child: EmptyCartWidget(
                  onContinueShopping: () => Navigator.of(context).pop(),
                ),
              )
            else
              Expanded(
                child: ListView(
                  children: [
                    ...state.items.map((item) => CartItemCard(item: item)),
                    const SizedBox(height: 12),
                    CartSummary(state: state),
                    const SizedBox(height: 16),
                    ConfirmOrderButton(
                      onPressed: () => _submitOrder(context),
                      isLoading: _isSubmitting,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
