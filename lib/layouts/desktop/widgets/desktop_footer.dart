import 'package:drip_society/layouts/widgets/contact_section.dart';
import 'package:drip_society/layouts/widgets/logo_app.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:drip_society/l10n/generated/app_localizations.dart';

class DesktopFooter extends StatelessWidget {
  const DesktopFooter({super.key, required this.onNavTap});

  static const _linkedInUrl = 'https://www.linkedin.com/in/yousefali55/';
  static const _facebookUrl = 'https://www.facebook.com/yousef.alii.76179';
  static const _githubUrl = 'https://github.com/yousefali55';

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
                          const SizedBox(height: 26),
                          Divider(
                            color: colorScheme.outlineVariant.withValues(
                              alpha: 0.75,
                            ),
                          ),
                          const SizedBox(height: 20),
                          const _FooterBottom(),
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

class _FooterBottom extends StatelessWidget {
  const _FooterBottom();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final credit = Text(
      l10n.footerCredit,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
        color: Theme.of(context).colorScheme.onSurfaceVariant,
        fontWeight: FontWeight.w600,
      ),
    );
    final socialLinks = Wrap(
      textDirection: Directionality.of(context),
      alignment: WrapAlignment.start,
      spacing: 12,
      runSpacing: 12,
      children: [
        _SocialIcon(
          tooltip: 'Facebook',
          icon: Icons.facebook_rounded,
          url: DesktopFooter._facebookUrl,
        ),
        _SocialIcon(
          tooltip: 'LinkedIn',
          icon: Icons.work_rounded,
          url: DesktopFooter._linkedInUrl,
        ),
        _SocialIcon(
          tooltip: 'GitHub',
          icon: Icons.code_rounded,
          url: DesktopFooter._githubUrl,
        ),
      ],
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return Column(
            children: [
              Center(child: socialLinks),
              const SizedBox(height: 16),
              SizedBox(width: double.infinity, child: credit),
            ],
          );
        }

        return Row(
          textDirection: Directionality.of(context),
          children: [
            Expanded(
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: socialLinks,
              ),
            ),
            Expanded(child: Center(child: credit)),
            const Expanded(child: SizedBox.shrink()),
          ],
        );
      },
    );
  }
}

class _SocialIcon extends StatefulWidget {
  const _SocialIcon({
    required this.tooltip,
    required this.icon,
    required this.url,
  });

  final String tooltip;
  final IconData icon;
  final String url;

  @override
  State<_SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<_SocialIcon> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Tooltip(
      message: widget.tooltip,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hovering = true),
        onExit: (_) => setState(() => _hovering = false),
        child: GestureDetector(
          onTap: _openLink,
          child: AnimatedScale(
            scale: _hovering ? 1.1 : 1,
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOutCubic,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: _hovering
                    ? colorScheme.primary.withValues(alpha: 0.12)
                    : colorScheme.surface.withValues(alpha: 0.58),
                borderRadius: BorderRadius.circular(999),
                border: Border.all(
                  color: _hovering
                      ? colorScheme.primary.withValues(alpha: 0.35)
                      : colorScheme.outlineVariant.withValues(alpha: 0.55),
                ),
              ),
              child: Icon(
                widget.icon,
                color: _hovering
                    ? colorScheme.primary
                    : colorScheme.onSurfaceVariant,
                size: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _openLink() async {
    final uri = Uri.parse(widget.url);

    if (kIsWeb) {
      final launched = await launchUrl(uri, webOnlyWindowName: '_blank');
      if (!launched) {
        throw Exception('Could not launch ${widget.url}');
      }
      return;
    }

    final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!launched) {
      throw Exception('Could not launch ${widget.url}');
    }
  }
}
