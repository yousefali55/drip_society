import 'package:flutter/material.dart';

class ProductTitle extends StatelessWidget {
  const ProductTitle({
    super.key,
    required this.englishName,
    required this.arabicName,
  });

  final String englishName;
  final String arabicName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          englishName,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        Text(
          arabicName,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            fontSize: 13,
          ),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
