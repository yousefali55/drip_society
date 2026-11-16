import 'package:drip_society/layouts/widgets/contact_section.dart';
import 'package:drip_society/layouts/widgets/logo_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:drip_society/l10n/generated/app_localizations.dart';

class DesktopFooter extends StatelessWidget {
  const DesktopFooter({super.key, required this.onNavTap});

  final void Function(FooterNavTarget target) onNavTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final width = MediaQuery.sizeOf(context).width;
    final isNarrow = width < 860;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final textDirection = isArabic ? TextDirection.rtl : TextDirection.ltr;

    return Directionality(
      textDirection: textDirection,
      child:
          Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: isArabic ? Alignment.topRight : Alignment.topLeft,
                    end: isArabic
                        ? Alignment.bottomLeft
                        : Alignment.bottomRight,
                    colors: [
                      colorScheme.surface.withValues(alpha: 0.96),
                      colorScheme.surfaceContainerHighest.withValues(
                        alpha: 0.28,
                      ),
                    ],
                  ),
                  border: Border(
                    top: BorderSide(
                      color: colorScheme.outlineVariant.withValues(alpha: 0.65),
                    ),
                  ),
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1240),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                        isNarrow ? 24 : 36,
                        isNarrow ? 48 : 64,
                        isNarrow ? 24 : 36,
                        isNarrow ? 32 : 40,
                      ),
                      child: Column(
                        crossAxisAlignment: isArabic
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(
                              isNarrow ? 24 : 30,
                              isNarrow ? 26 : 32,
                              isNarrow ? 24 : 30,
                              isNarrow ? 26 : 32,
                            ),
                            decoration: BoxDecoration(
                              color: colorScheme.surface.withValues(
                                alpha: 0.84,
                              ),
                              borderRadius: BorderRadius.circular(28),
                              border: Border.all(
                                color: colorScheme.outlineVariant.withValues(
                                  alpha: 0.55,
                                ),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: colorScheme.shadow.withValues(
                                    alpha: 0.08,
                                  ),
                                  blurRadius: 28,
                                  offset: const Offset(0, 16),
                                ),
                              ],
                            ),
                            child: isNarrow
                                ? Column(
                                    crossAxisAlignment: isArabic
                                        ? CrossAxisAlignment.end
                                        : CrossAxisAlignment.start,
                                    children: [
                                      _BrandColumn(onNavTap: onNavTap),
                                      const SizedBox(height: 24),
                                      const _FooterContactPanel(),
                                    ],
                                  )
                                : Row(
                                    textDirection: textDirection,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex: 5,
                                        child: _BrandColumn(onNavTap: onNavTap),
                                      ),
                                      const SizedBox(width: 40),
                                      const Expanded(
                                        flex: 6,
                                        child: _FooterContactPanel(),
                                      ),
                                    ],
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
              .animate()
              .fade(duration: 650.ms)
              .slideY(begin: .08, curve: Curves.easeOutCubic),
    );
  }
}

enum FooterNavTarget { home, about, products, contact }

class _BrandColumn extends StatelessWidget {
  const _BrandColumn({required this.onNavTap});

  final void Function(FooterNavTarget target) onNavTap;

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: isArabic
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        const LogoApp(),
        const SizedBox(height: 18),
        Text(
          l10n.footerBrandDescription,
          textAlign: isArabic ? TextAlign.right : TextAlign.left,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.8),
        ),
        const SizedBox(height: 24),
        Wrap(
          textDirection: Directionality.of(context),
          alignment: isArabic ? WrapAlignment.end : WrapAlignment.start,
          spacing: 12,
          runSpacing: 10,
          children: [
            _FooterNavButton(
              label: l10n.navHome,
              onTap: () => onNavTap(FooterNavTarget.home),
            ),
            _FooterNavButton(
              label: l10n.navAboutUs,
              onTap: () => onNavTap(FooterNavTarget.about),
            ),
            _FooterNavButton(
              label: l10n.navProducts,
              onTap: () => onNavTap(FooterNavTarget.products),
            ),
            _FooterNavButton(
              label: l10n.navContact,
              onTap: () => onNavTap(FooterNavTarget.contact),
            ),
          ],
        ),
      ],
    );
  }
}

class _FooterContactPanel extends StatelessWidget {
  const _FooterContactPanel();

  @override
  Widget build(BuildContext context) {
    return const ContactSection(
      horizontalPadding: 0,
      verticalPadding: EdgeInsets.zero,
    );
  }
}

class _FooterNavButton extends StatefulWidget {
  const _FooterNavButton({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  State<_FooterNavButton> createState() => _FooterNavButtonState();
}

class _FooterNavButtonState extends State<_FooterNavButton> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: _hovering
                ? colorScheme.primary.withValues(alpha: 0.10)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: _hovering
                  ? colorScheme.primary.withValues(alpha: 0.35)
                  : colorScheme.outlineVariant.withValues(alpha: 0.45),
            ),
          ),
          child: Text(
            widget.label,
            style: TextStyle(
              color: _hovering ? colorScheme.primary : colorScheme.onSurface,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
