import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

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
              'CONTACT',
              textAlign: isArabic ? TextAlign.right : TextAlign.left,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
                letterSpacing: 3,
              ),
            ),
            const SizedBox(height: 14),
            Text(
              'Ready for your next cup?',
              textAlign: isArabic ? TextAlign.right : TextAlign.left,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                height: 1.15,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Order your favorite Drip Society roast and enjoy a premium '
              'coffee ritual at home.',
              textAlign: isArabic ? TextAlign.right : TextAlign.left,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.7),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: Align(
                alignment: isArabic ? Alignment.centerRight : Alignment.centerLeft,
                child: FilledButton(
                  onPressed: () => _showContactSnackBar(context),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Text('Contact Us'),
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

    return SizedBox(width: double.infinity, child: content)
        .animate()
        .fade(duration: 500.ms)
        .slideY(begin: .12);
  }

  void _showContactSnackBar(BuildContext context) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Contact coming soon')));
  }
}
