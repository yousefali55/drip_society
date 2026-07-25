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

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Your cart is empty')));
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
    final mediaQuery = MediaQuery.of(context);
    final bottomInset = mediaQuery.viewInsets.bottom;
    final topGap = mediaQuery.padding.top + 20;
    final bottomGap = mediaQuery.padding.bottom + 18 + bottomInset;
    final colorScheme = Theme.of(context).colorScheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        final sheetHeight = (constraints.maxHeight - topGap - bottomGap)
            .clamp(0.0, constraints.maxHeight)
            .toDouble();

        return TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0, end: 1),
          duration: const Duration(milliseconds: 360),
          curve: Curves.easeOutCubic,
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(0, (1 - value) * 28),
                child: child,
              ),
            );
          },
          child: Padding(
            padding: EdgeInsets.fromLTRB(18, topGap, 18, bottomGap),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: sheetHeight,
                width: double.infinity,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.20),
                        blurRadius: 42,
                        spreadRadius: -8,
                        offset: const Offset(0, 24),
                      ),
                      BoxShadow(
                        color: colorScheme.shadow.withValues(alpha: 0.10),
                        blurRadius: 18,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Material(
                    color: colorScheme.surface,
                    borderRadius: BorderRadius.circular(28),
                    clipBehavior: Clip.antiAlias,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(18, 10, 18, 18),
                      child: Column(
                        children: [
                          Container(
                            width: 44,
                            height: 5,
                            decoration: BoxDecoration(
                              color: colorScheme.onSurfaceVariant.withValues(
                                alpha: 0.28,
                              ),
                              borderRadius: BorderRadius.circular(999),
                            ),
                          ),
                          const SizedBox(height: 18),
                          Row(
                            children: [
                              const Text(
                                'Your Cart',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Spacer(),
                              IconButton.filledTonal(
                                onPressed: () => Navigator.of(context).pop(),
                                icon: const Icon(Icons.close_rounded),
                              ),
                            ],
                          ),

                          const SizedBox(height: 12),

                          if (isEmpty)
                            Expanded(
                              child: EmptyCartWidget(
                                onContinueShopping: () =>
                                    Navigator.of(context).pop(),
                              ),
                            )
                          else
                            Expanded(
                              child: ListView(
                                physics: const BouncingScrollPhysics(),
                                padding: EdgeInsets.zero,
                                children: [
                                  ...state.items.map(
                                    (item) => CartItemCard(item: item),
                                  ),

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
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
