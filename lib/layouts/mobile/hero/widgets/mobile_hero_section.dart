import 'dart:async';

import 'package:drip_society/layouts/desktop/cart/widgets/cart_badge.dart';
import 'package:drip_society/layouts/desktop/hero/data/hero_data.dart';
import 'package:drip_society/layouts/widgets/logo_app.dart';
import 'package:drip_society/core/widgets/language_switch_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:drip_society/l10n/generated/app_localizations.dart';

class MobileHeroSection extends StatefulWidget {
  const MobileHeroSection({
    super.key,
    required this.onMenuTap,
    required this.onExplore,
    required this.onCart,
  });

  final VoidCallback onMenuTap;
  final VoidCallback onExplore;
  final VoidCallback onCart;

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
          _currentIndex = (_currentIndex + 1) % heroItemCount;
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
    final l10n = AppLocalizations.of(context)!;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final item = heroItems(l10n)[_currentIndex];

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
              children: isArabic
                  ? [
                      IconButton.filledTonal(
                        onPressed: widget.onMenuTap,
                        tooltip: l10n.navNavigation,
                        icon: const Icon(Icons.menu_rounded),
                      ),
                      CartBadge(onTap: widget.onCart),
                      const SizedBox(width: 10),
                      const LanguageSwitchButton(compact: true),
                      const Spacer(),
                      const LogoApp(),
                    ]
                  : [
                      const LogoApp(),
                      const Spacer(),
                      CartBadge(onTap: widget.onCart),
                      const SizedBox(width: 10),
                      const LanguageSwitchButton(compact: true),
                      const SizedBox(width: 10),
                      IconButton.filledTonal(
                        onPressed: widget.onMenuTap,
                        tooltip: l10n.navNavigation,
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
                      begin: Offset(isArabic ? -.06 : .06, .04),
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
                      label: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Text(l10n.exploreProducts),
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
