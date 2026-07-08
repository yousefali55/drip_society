import 'package:drip_society/features/home/desktop/hero/model/hero_model.dart';
import 'package:drip_society/features/home/desktop/hero/widgets/hero_indicator.dart';
import 'package:flutter/material.dart';

class HeroContent extends StatelessWidget {
  final HeroModel item;
  final VoidCallback onExplore;
  final int currentIndex;

  const HeroContent({
    super.key,
    required this.item,
    required this.onExplore,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 80),

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

            style: const TextStyle(
              fontSize: 74,
              fontWeight: FontWeight.bold,
              height: 1,
            ),
          ),

          const SizedBox(height: 30),

          SizedBox(
            width: 520,

            child: Text(
              item.description,

              style: const TextStyle(fontSize: 18, height: 1.7),
            ),
          ),

          const SizedBox(height: 45),

          FilledButton(
            onPressed: () {},

            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 18),
              child: Text("Explore Menu"),
            ),
          ),

          const SizedBox(height: 70),

          HeroIndicator(),
        ],
      ),
    );
  }
}
