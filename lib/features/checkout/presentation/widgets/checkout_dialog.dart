import 'package:drip_society/features/auth/data/models/customer_model.dart';
import 'package:drip_society/layouts/desktop/cart/cubit/cart_item_cubit.dart';
import 'package:drip_society/layouts/desktop/cart/cubit/cart_item_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class CheckoutDialog extends StatefulWidget {
  const CheckoutDialog({super.key, required this.customer});

  final CustomerModel customer;

  @override
  State<CheckoutDialog> createState() => _CheckoutDialogState();
}

class _CheckoutDialogState extends State<CheckoutDialog> {
  late final TextEditingController _addressController;
  late final TextEditingController _cityController;
  // late final TextEditingController _postalController;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _addressController = TextEditingController(text: '23 El Gomhoria St');
    _cityController = TextEditingController(text: widget.customer.city);
    // _postalController = TextEditingController(text: widget.customer.postalCode);
  }

  @override
  void dispose() {
    _addressController.dispose();
    _cityController.dispose();
    // _postalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 720, maxHeight: 760),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              final subtotal = state.totalPrice;
              final total = subtotal;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text('Checkout', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
                      ),
                      IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.close_rounded)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _infoCard(context),
                          const SizedBox(height: 16),
                          _buildSectionTitle('Delivery Information'),
                          const SizedBox(height: 8),
                          TextField(controller: _cityController, decoration: const InputDecoration(labelText: 'City', border: OutlineInputBorder())),
                          const SizedBox(height: 12),
                          TextField(controller: _addressController, maxLines: 2, decoration: const InputDecoration(labelText: 'Address', border: OutlineInputBorder())),
                          // TextField(controller: _postalController, decoration: const InputDecoration(labelText: 'Postal Code', border: OutlineInputBorder())),
                          const SizedBox(height: 20),
                          _buildSectionTitle('Order Summary'),
                          const SizedBox(height: 8),
                          ...state.items.map((item) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(child: Text('${item.product.nameEn} ×${item.quantity}')),
                                Text('${(item.product.price * item.quantity).toStringAsFixed(0)} EGP'),
                              ],
                            ),
                          )),
                          const SizedBox(height: 8),
                          const Divider(),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('Subtotal'), Text('${subtotal.toStringAsFixed(0)} EGP')]),
                          const SizedBox(height: 6),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('Total'), Text('${total.toStringAsFixed(0)} EGP', style: TextStyle(fontWeight: FontWeight.bold))]),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: _isSubmitting ? null : () => _confirmOrder(context, state),
                      icon: _isSubmitting
                          ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                          : const Icon(Icons.send_rounded),
                      label: Padding(padding: const EdgeInsets.symmetric(vertical: 12), child: Text(_isSubmitting ? 'Opening WhatsApp...' : 'Confirm Order')),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _infoCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Customer', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Text(widget.customer.fullName),
          Text(widget.customer.phoneNumber),
          Text(widget.customer.city),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(title, style: const TextStyle(fontWeight: FontWeight.w700));
  }

  Future<void> _confirmOrder(BuildContext context, CartState state) async {
    if (state.items.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Your cart is empty')));
      return;
    }

    setState(() => _isSubmitting = true);

    final message = _buildMessage(state);
    final encodedMessage = Uri.encodeComponent(message);
    final phone = widget.customer.phoneNumber.replaceFirst(RegExp(r'^0'), '20');
    final uri = Uri.parse('https://wa.me/$phone?text=$encodedMessage');
    final navigator = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);

    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
      await context.read<CartCubit>().clear();
      if (!mounted) return;
      navigator.pop();
      messenger.showSnackBar(const SnackBar(content: Text('WhatsApp opened with your order')));
    } catch (_) {
      if (!mounted) return;
      messenger.showSnackBar(const SnackBar(content: Text('Unable to open WhatsApp right now')));
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  String _buildMessage(CartState state) {
    final subtotal = state.totalPrice;
    final total = subtotal;
    final lines = <String>[
      '--------------------------------',
      '☕ *Drip Society Order*',
      '',
      'Customer:',
      '👤 ${widget.customer.fullName}',
      '',
      '📞 ${widget.customer.phoneNumber}',
      '',
      '📍 ${_cityController.text}',
      '',
      '🏠 Address:',
      _addressController.text,
      '',
      // 'Postal Code:',
      // _postalController.text,
      // '',
      '--------------------------',
      'Order',
      '',
      ...state.items.map((item) => '• ${item.product.nameEn}\n${item.product.description} ${item.product.price.toStringAsFixed(0)} EGP ×${item.quantity}\n${(item.product.price * item.quantity).toStringAsFixed(0)} EGP'),
      '',
      '--------------------------',
      'Total',
      '',
      '${total.toStringAsFixed(0)} EGP',
      '',
      'Thank you ❤️',
      '--------------------------------',
    ];
    return lines.join('\n');
  }
}
