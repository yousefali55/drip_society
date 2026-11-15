import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:drip_society/l10n/generated/app_localizations.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final horizontalPadding = (width * .07).clamp(42.0, 100.0).toDouble();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        horizontalPadding,
        110,
        horizontalPadding,
        118,
      ),
      color: Colors.transparent,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1180),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isNarrow = constraints.maxWidth < 860;
              final image = Center(
                child: Image.asset(
                  'assets/images/coffeecup-1.png',
                  height: isNarrow ? 340 : 500,
                  fit: BoxFit.contain,
                ),
              ).animate().fade(duration: 650.ms).slideY(begin: .12);

              final copy = _AboutCopy(isNarrow: isNarrow);

              if (isNarrow) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [image, const SizedBox(height: 42), copy],
                );
              }

              return Row(
                children: [
                  Expanded(child: image),
                  const SizedBox(width: 92),
                  Expanded(child: copy),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _AboutCopy extends StatelessWidget {
  const _AboutCopy({required this.isNarrow});

  final bool isNarrow;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.aboutEyebrow,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
            letterSpacing: 3,
          ),
        ).animate().fade(delay: 120.ms).slideY(begin: .12),
        const SizedBox(height: 18),
        Text(
          l10n.aboutHeadline,
          style:
              (isNarrow
                      ? Theme.of(context).textTheme.headlineMedium
                      : Theme.of(context).textTheme.displaySmall)
                  ?.copyWith(fontWeight: FontWeight.bold, height: 1.15),
        ).animate().fade(delay: 220.ms).slideY(begin: .12),
        const SizedBox(height: 24),
        Text(
          l10n.aboutDescription,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.8),
        ).animate().fade(delay: 320.ms).slideY(begin: .12),
        const SizedBox(height: 34),
        _Feature(
          l10n.featurePremiumBeans,
        ).animate().fade(delay: 420.ms).slideY(begin: .12),
        const SizedBox(height: 16),
        _Feature(
          l10n.featureExpertCoffee,
        ).animate().fade(delay: 520.ms).slideY(begin: .12),
        const SizedBox(height: 16),
        _Feature(
          l10n.featureFreshDaily,
        ).animate().fade(delay: 620.ms).slideY(begin: .12),
        const SizedBox(height: 36),
        FilledButton(
          onPressed: () async {
            final url = Uri.parse('https://www.facebook.com/dripsociety.eg');
            if (await canLaunchUrl(url)) {
              await launchUrl(url);
            }
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 18),
            child: Text(l10n.discoverMore),
          ),
        ).animate().fade(delay: 720.ms).scale(begin: const Offset(.96, .96)),
      ],
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
