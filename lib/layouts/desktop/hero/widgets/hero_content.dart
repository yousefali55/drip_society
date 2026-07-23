import 'package:drip_society/layouts/desktop/hero/model/hero_model.dart';
import 'package:drip_society/layouts/desktop/hero/widgets/hero_indicator.dart';
import 'package:flutter/material.dart';

class HeroContent extends StatelessWidget {
  const HeroContent({
    super.key,
    required this.item,
    required this.onExplore,
    required this.currentIndex,
    required this.itemCount,
  });

  final HeroModel item;
  final VoidCallback onExplore;
  final int currentIndex;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final compact = width < 900;
    final subtitleSize = compact ? 46.0 : 74.0;

    return Padding(
      padding: EdgeInsets.only(left: compact ? 0 : 80),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.title,
            style: const TextStyle(fontSize: 22, letterSpacing: 4),
          ),
          const SizedBox(height: 15),
          Text(
            item.subtitle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: subtitleSize,
              fontWeight: FontWeight.bold,
              height: 1,
            ),
          ),
          const SizedBox(height: 30),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Text(
              item.description,
              style: const TextStyle(fontSize: 18, height: 1.7),
            ),
          ),
          const SizedBox(height: 45),
          FilledButton(
            onPressed: onExplore,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 18),
              child: Text("Explore Products"),
            ),
          ),
          const SizedBox(height: 24),
          HeroIndicator(currentIndex: currentIndex, itemCount: itemCount),
        ],
      ),
    );
  }
}
