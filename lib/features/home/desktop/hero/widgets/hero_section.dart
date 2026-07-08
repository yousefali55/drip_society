import 'dart:async';

import 'package:drip_society/features/home/desktop/hero/data/hero_data.dart';
import 'package:drip_society/features/home/desktop/hero/widgets/hero_content.dart';
import 'package:drip_society/features/home/desktop/hero/widgets/hero_image.dart';
import 'package:flutter/material.dart';

class HeroSection extends StatefulWidget {
  final VoidCallback onExplore;

  const HeroSection({
    super.key,
    required this.onExplore,
  });

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {
  int currentIndex = 0;

  Timer? timer;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(seconds: 5), (_) {
      setState(() {
        currentIndex = (currentIndex + 1) % heroItems.length;
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final item = heroItems[currentIndex];

    return SizedBox(
      height: MediaQuery.of(context).size.height - 90,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 80),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 700),
          switchInCurve: Curves.easeOutCubic,
          switchOutCurve: Curves.easeInCubic,
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.08, 0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
            );
          },
          child: Row(
            key: ValueKey(currentIndex),
            children: [
              Expanded(
                flex: 5,
                child: HeroContent(
                  item: item,
                  onExplore: widget.onExplore,
                  currentIndex: currentIndex,
                ),
              ),

              const SizedBox(width: 40),

              Expanded(
                flex: 5,
                child: HeroImage(
                  image: item.image,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}