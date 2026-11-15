import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:drip_society/l10n/generated/app_localizations.dart';

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
    final l10n = AppLocalizations.of(context)!;
    final textDirection = isArabic ? TextDirection.rtl : TextDirection.ltr;
    final crossAxisAlignment = isArabic
        ? CrossAxisAlignment.end
        : CrossAxisAlignment.start;
    final imageHeight = compact
        ? 180.0
        : (width * .82).clamp(230.0, 360.0).toDouble();
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
              l10n.aboutEyebrow,
              textAlign: isArabic ? TextAlign.right : TextAlign.left,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
                letterSpacing: 3,
              ),
            ).animate().fade(delay: 120.ms).slideY(begin: .12),
            const SizedBox(height: 18),
            Text(
              l10n.aboutHeadline,
              textAlign: isArabic ? TextAlign.right : TextAlign.left,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                height: 1.15,
              ),
            ).animate().fade(delay: 220.ms).slideY(begin: .12),
            const SizedBox(height: 24),
            Text(
              l10n.aboutDescription,
              textAlign: isArabic ? TextAlign.right : TextAlign.left,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(height: 1.8),
            ).animate().fade(delay: 320.ms).slideY(begin: .12),
            const SizedBox(height: 28),
            _Feature(
              l10n.featurePremiumBeans,
            ).animate().fade(delay: 420.ms).slideY(begin: .12),
            const SizedBox(height: 14),
            _Feature(
              l10n.featureExpertCoffee,
            ).animate().fade(delay: 520.ms).slideY(begin: .12),
            const SizedBox(height: 14),
            _Feature(
              l10n.featureFreshDaily,
            ).animate().fade(delay: 620.ms).slideY(begin: .12),
            if (showActionButton) ...[
              const SizedBox(height: 28),
              SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () async {
                        final url = Uri.parse(
                          'https://www.facebook.com/dripsociety.eg',
                        );
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Text(l10n.discoverMore),
                      ),
                    ),
                  )
                  .animate()
                  .fade(delay: 720.ms)
                  .scale(begin: const Offset(.96, .96)),
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
