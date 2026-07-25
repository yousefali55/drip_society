import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class MobileAboutSection extends StatelessWidget {
  const MobileAboutSection({
    super.key,
    this.compact = false,
    this.showImage = true,
    this.showActionButton = true,
  });

  final bool compact;
  final bool showImage;
  final bool showActionButton;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final horizontalPadding = (width * .07).clamp(20.0, 30.0).toDouble();
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final textDirection = isArabic ? TextDirection.rtl : TextDirection.ltr;
    final crossAxisAlignment = isArabic
        ? CrossAxisAlignment.end
        : CrossAxisAlignment.start;
    final imageHeight = compact ? 180.0 : (width * .82).clamp(230.0, 360.0).toDouble();
    final topPadding = compact ? 24.0 : 70.0;
    final bottomPadding = compact ? 24.0 : 76.0;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        horizontalPadding,
        topPadding,
        horizontalPadding,
        bottomPadding,
      ),
      color: Colors.transparent,
      child: Directionality(
        textDirection: textDirection,
        child: Column(
          crossAxisAlignment: crossAxisAlignment,
          children: [
            if (showImage)
              Center(
                child: Image.asset(
                  'assets/images/coffeecup-1.png',
                  height: imageHeight,
                  fit: BoxFit.contain,
                ),
              ).animate().fade(duration: 650.ms).slideY(begin: .12),
            if (showImage) const SizedBox(height: 32),
            Text(
              'ABOUT US',
              textAlign: isArabic ? TextAlign.right : TextAlign.left,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
                letterSpacing: 3,
              ),
            ).animate().fade(delay: 120.ms).slideY(begin: .12),
            const SizedBox(height: 18),
            Text(
              'Brewing Experiences,\nNot Just Coffee.',
              textAlign: isArabic ? TextAlign.right : TextAlign.left,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                height: 1.15,
              ),
            ).animate().fade(delay: 220.ms).slideY(begin: .12),
            const SizedBox(height: 24),
            Text(
              "At Drip Society, we don't simply serve coffee. "
              'We create an experience that inspires focus, creativity, '
              'and meaningful conversations. Every cup is crafted with '
              'care using premium beans and exceptional brewing techniques.',
              textAlign: isArabic ? TextAlign.right : TextAlign.left,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.8),
            ).animate().fade(delay: 320.ms).slideY(begin: .12),
            const SizedBox(height: 28),
            const _Feature(
              'Premium Coffee Beans',
            ).animate().fade(delay: 420.ms).slideY(begin: .12),
            const SizedBox(height: 14),
            const _Feature(
              'Expert Coffee',
            ).animate().fade(delay: 520.ms).slideY(begin: .12),
            const SizedBox(height: 14),
            const _Feature(
              'Freshly Brewed Everyday',
            ).animate().fade(delay: 620.ms).slideY(begin: .12),
            if (showActionButton) ...[
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {},
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Text('Discover More'),
                  ),
                ),
              ).animate().fade(delay: 720.ms).scale(begin: const Offset(.96, .96)),
            ],
          ],
        ),
      ),
    );
  }
}

class _Feature extends StatelessWidget {
  const _Feature(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.check_circle_rounded,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Text(title, style: Theme.of(context).textTheme.titleMedium),
        ),
      ],
    );
  }
}
