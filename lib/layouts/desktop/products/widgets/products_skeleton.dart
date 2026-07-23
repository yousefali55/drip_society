import 'package:flutter/material.dart';

class ProductsSkeleton extends StatelessWidget {
  const ProductsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 6,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: 0.72,
      ),
      itemBuilder: (context, index) => Container(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withValues(alpha: 0.06),
              blurRadius: 12,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Container(height: 16, color: colorScheme.surfaceContainerHighest),
              const SizedBox(height: 8),
              Container(
                height: 12,
                width: 120,
                color: colorScheme.surfaceContainerHighest,
              ),
              const SizedBox(height: 12),
              Container(
                height: 16,
                width: 80,
                color: colorScheme.surfaceContainerHighest,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
