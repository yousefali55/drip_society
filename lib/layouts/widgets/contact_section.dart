import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:drip_society/l10n/generated/app_localizations.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({
    super.key,
    this.maxWidth,
    this.horizontalPadding,
    this.verticalPadding = const EdgeInsets.symmetric(vertical: 44),
  });

  final double? maxWidth;
  final double? horizontalPadding;
  final EdgeInsets verticalPadding;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final sidePadding =
        horizontalPadding ?? (width * .07).clamp(20.0, 30.0).toDouble();
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final l10n = AppLocalizations.of(context)!;
    final textDirection = isArabic ? TextDirection.rtl : TextDirection.ltr;
    final crossAxisAlignment = isArabic
        ? CrossAxisAlignment.end
        : CrossAxisAlignment.start;

    Widget content = Padding(
      padding: EdgeInsets.fromLTRB(
        sidePadding,
        verticalPadding.top,
        sidePadding,
        verticalPadding.bottom,
      ),
      child: Directionality(
        textDirection: textDirection,
        child: Column(
          crossAxisAlignment: crossAxisAlignment,
          children: [
            Text(
              l10n.contactEyebrow,
              textAlign: isArabic ? TextAlign.right : TextAlign.left,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
                letterSpacing: 3,
              ),
            ),
            const SizedBox(height: 14),
            Text(
              l10n.contactHeading,
              textAlign: isArabic ? TextAlign.right : TextAlign.left,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                height: 1.15,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              l10n.contactDescription,
              textAlign: isArabic ? TextAlign.right : TextAlign.left,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(height: 1.7),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: Align(
                alignment: AlignmentDirectional.centerStart,
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
                    child: Text(l10n.contactFacebook),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    if (maxWidth != null) {
      content = Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth!),
          child: content,
        ),
      );
    }

    return SizedBox(
      width: double.infinity,
      child: content,
    ).animate().fade(duration: 500.ms).slideY(begin: .12);
  }
}
