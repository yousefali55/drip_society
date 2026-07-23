import 'package:flutter/material.dart';

class HeroIndicator extends StatelessWidget {
  const HeroIndicator({
    super.key,
    required this.currentIndex,
    required this.itemCount,
  });

  final int currentIndex;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(itemCount, (index) {
        final active = index == currentIndex;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.only(right: 8),
          height: 3,
          width: active ? 42 : 26,
          decoration: BoxDecoration(
            color: active
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.outlineVariant,
            borderRadius: BorderRadius.circular(999),
          ),
        );
      }),
    );
  }
}
