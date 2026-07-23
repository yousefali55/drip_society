import 'package:flutter/material.dart';

class MobileLogo extends StatelessWidget {
  const MobileLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withValues(alpha: .12),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.coffee_rounded,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(width: 12),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'DRIP.',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.4,
                height: 1,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              'Society',
              style: TextStyle(
                fontSize: 11,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                letterSpacing: 4,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
