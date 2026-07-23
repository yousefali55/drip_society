import 'dart:async';

import 'package:drip_society/layouts/desktop/hero/data/hero_data.dart';
import 'package:drip_society/layouts/desktop/hero/widgets/hero_content.dart';
import 'package:drip_society/layouts/desktop/hero/widgets/hero_image.dart';
import 'package:flutter/material.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key, required this.onExplore});

  final VoidCallback onExplore;

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {
  int currentIndex = 0;

  Timer? timer;

  @override
  void initState() {
    super.initState();

    if (!const bool.fromEnvironment('FLUTTER_TEST')) {
      timer = Timer.periodic(const Duration(seconds: 5), (_) {
        if (!mounted) return;
        setState(() {
          currentIndex = (currentIndex + 1) % heroItems.length;
        });
      });
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final item = heroItems[currentIndex];
    final compact = MediaQuery.of(context).size.width < 900;

    return SizedBox(
      height: MediaQuery.of(context).size.height - 90,
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: compact ? 24 : 80),
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
          child: compact
              ? Column(
                  key: ValueKey(currentIndex),
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: HeroContent(
                        item: item,
                        currentIndex: currentIndex,
                        itemCount: heroItems.length,
                        onExplore: widget.onExplore,
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      height: 220,
                      width: double.infinity,
                      child: HeroImage(image: item.image),
                    ),
                  ],
                )
              : Row(
                  key: ValueKey(currentIndex),
                  children: [
                    Expanded(
                      flex: 5,
                      child: HeroContent(
                        item: item,
                        currentIndex: currentIndex,
                        itemCount: heroItems.length,
                        onExplore: widget.onExplore,
                      ),
                    ),
                    const SizedBox(width: 40),
                    Expanded(flex: 5, child: HeroImage(image: item.image)),
                  ],
                ),
        ),
      ),
    );
  }
}
