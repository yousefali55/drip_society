import 'package:drip_society/core/widgets/egyptian_governorate_dropdown.dart';
import 'package:drip_society/layouts/desktop/cart/cubit/cart_item_cubit.dart';
import 'package:drip_society/layouts/desktop/cart/cubit/cart_item_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:drip_society/l10n/generated/app_localizations.dart';

class CheckoutDialog extends StatefulWidget {
  const CheckoutDialog({super.key});

  @override
  State<CheckoutDialog> createState() => _CheckoutDialogState();
}

class _CheckoutDialogState extends State<CheckoutDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _addressController;
  late final TextEditingController _cityController;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _addressController = TextEditingController();
    _cityController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
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
              return Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            l10n.checkout,
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                        ),
                        IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          tooltip: l10n.close,
                          icon: const Icon(Icons.close_rounded),
                        ),
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
                            _buildSectionTitle(l10n.deliveryInformation),
                            const SizedBox(height: 8),
                            EgyptianGovernorateDropdown(
                              controller: _cityController,
                            ),
                            const SizedBox(height: 12),
                            TextField(
                              controller: _addressController,
                              maxLines: 2,
                              decoration: InputDecoration(
                                labelText: l10n.address,
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 20),
                            _buildSectionTitle(l10n.orderSummary),
                            const SizedBox(height: 8),
                            ...state.items.map(
                              (item) => Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        '${Localizations.localeOf(context).languageCode == 'ar' && item.product.nameAr.trim().isNotEmpty ? item.product.nameAr : item.product.nameEn} ×${item.quantity}',
                                      ),
                                    ),
                                    Text(
                                      '${(item.product.price * item.quantity).toStringAsFixed(0)} ${l10n.currencyEgp}',
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(l10n.subtotal),
                                Text(
                                  '${subtotal.toStringAsFixed(0)} ${l10n.currencyEgp}',
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(l10n.total),
                                Text(
                                  '${total.toStringAsFixed(0)} ${l10n.currencyEgp}',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: _isSubmitting
                            ? null
                            : () => _confirmOrder(context, state),
                        icon: _isSubmitting
                            ? const SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Icon(Icons.send_rounded),
                        label: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Text(
                            _isSubmitting
                                ? l10n.openingWhatsApp
                                : l10n.confirmOrder,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _infoCard(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(
          context,
        ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.contactInformation,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(labelText: l10n.fullName),
            validator: (value) => value == null || value.trim().isEmpty
                ? l10n.enterFullName
                : null,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(labelText: l10n.phoneNumber),
            validator: (value) => value == null || value.trim().isEmpty
                ? l10n.enterPhoneNumber
                : null,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(title, style: const TextStyle(fontWeight: FontWeight.w700));
  }

  Future<void> _confirmOrder(BuildContext context, CartState state) async {
    final l10n = AppLocalizations.of(context)!;
    if (state.items.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.emptyCartMessage)));
      return;
    }
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    final message = _buildMessage(state);
    final encodedMessage = Uri.encodeComponent(message);
    final phone = '01281966367'.replaceFirst(RegExp(r'^0'), '20');
    final uri = Uri.parse('https://wa.me/$phone?text=$encodedMessage');
    final cartCubit = context.read<CartCubit>();
    final navigator = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);

    try {
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
      if (!launched) {
        messenger.showSnackBar(SnackBar(content: Text(l10n.whatsappUnable)));
        return;
      }
      await cartCubit.clear();
      if (!mounted) return;
      navigator.pop();
      messenger.showSnackBar(SnackBar(content: Text(l10n.whatsappOpened)));
    } catch (_) {
      if (!mounted) return;
      messenger.showSnackBar(SnackBar(content: Text(l10n.whatsappUnable)));
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  String _buildMessage(CartState state) {
    final l10n = AppLocalizations.of(context)!;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final subtotal = state.totalPrice;
    final total = subtotal;
    final lines = <String>[
      '--------------------------------',
      '☕ *Drip Society Order*',
      '',
      '${l10n.orderCustomer}:',
      '👤 ${_nameController.text}',
      '',
      '📞 ${_phoneController.text}',
      '',
      '📍 ${EgyptianGovernorateDropdown.localizedName(l10n, _cityController.text)}',
      '',
      '🏠 ${l10n.orderAddress}:',
      _addressController.text,
      '--------------------------',
      l10n.orderItems,
      '',
      ...state.items.map((item) {
        final productName = isArabic && item.product.nameAr.trim().isNotEmpty
            ? item.product.nameAr
            : item.product.nameEn;
        final productDetails = isArabic || item.product.description.isEmpty
            ? ''
            : '\n${item.product.description}';
        return '• $productName$productDetails ${item.product.price.toStringAsFixed(0)} ${l10n.currencyEgp} ×${item.quantity}\n${(item.product.price * item.quantity).toStringAsFixed(0)} ${l10n.currencyEgp}';
      }),
      '',
      '--------------------------',
      l10n.total,
      '',
      '${total.toStringAsFixed(0)} ${l10n.currencyEgp}',
      '',
      '${l10n.thankYou} ❤️',
      '--------------------------------',
    ];
    return lines.join('\n');
  }
}
