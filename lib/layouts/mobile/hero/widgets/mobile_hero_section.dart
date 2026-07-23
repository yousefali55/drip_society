import 'dart:async';

import 'package:drip_society/layouts/desktop/hero/data/hero_data.dart';
import 'package:drip_society/layouts/widgets/logo_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class MobileHeroSection extends StatefulWidget {
  const MobileHeroSection({
    super.key,
    required this.onMenuTap,
    required this.onExplore,
  });

  final VoidCallback onMenuTap;
  final VoidCallback onExplore;

  @override
  State<MobileHeroSection> createState() => _MobileHeroSectionState();
}

class _MobileHeroSectionState extends State<MobileHeroSection> {
  Timer? _timer;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    if (!const bool.fromEnvironment('FLUTTER_TEST')) {
      _timer = Timer.periodic(const Duration(seconds: 5), (_) {
        if (!mounted) return;
        setState(() {
          _currentIndex = (_currentIndex + 1) % heroItems.length;
        });
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final horizontalPadding = (width * .06).clamp(20.0, 30.0).toDouble();
    final item = heroItems[_currentIndex];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        horizontalPadding,
        14,
        horizontalPadding,
        46,
      ),
      color: Colors.transparent,
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const LogoApp(),
                const Spacer(),
                IconButton.filledTonal(
                  onPressed: widget.onMenuTap,
                  icon: const Icon(Icons.menu_rounded),
                ),
              ],
            ).animate().fade(duration: 450.ms).slideY(begin: -.16),
            const SizedBox(height: 38),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 650),
              switchInCurve: Curves.easeOutCubic,
              switchOutCurve: Curves.easeInCubic,
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(.06, .04),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  ),
                );
              },
              child: Column(
                key: ValueKey(item.image),
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title.toUpperCase(),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 3,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    item.subtitle,
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontSize: 56,
                      height: .95,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    item.description,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(height: 1.7, fontSize: 16),
                  ),
                  const SizedBox(height: 28),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: widget.onExplore,
                      icon: const Icon(Icons.local_cafe_rounded),
                      label: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Text('Explore Products'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 34),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final imageHeight = (constraints.maxWidth * .72)
                          .clamp(220.0, 330.0)
                          .toDouble();

                      return Center(
                        child: SizedBox(
                          height: imageHeight,
                          child: Image.asset(item.image, fit: BoxFit.contain)
                              .animate()
                              .fade(duration: 500.ms)
                              .scale(
                                begin: const Offset(.94, .94),
                                curve: Curves.easeOutCubic,
                              ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
