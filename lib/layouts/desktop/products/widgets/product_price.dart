import 'package:flutter/material.dart';
import 'package:drip_society/l10n/generated/app_localizations.dart';

class ProductPrice extends StatelessWidget {
  const ProductPrice({super.key, required this.price});

  final double price;

  @override
  Widget build(BuildContext context) {
    return Text(
      '${price.toStringAsFixed(0)} ${AppLocalizations.of(context)!.currencyEgp}',
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
      textAlign: TextAlign.center,
    );
  }
}
