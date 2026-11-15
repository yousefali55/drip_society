import 'package:drip_society/core/theme/theme_switch.dart';
import 'package:drip_society/layouts/desktop/cart/widgets/cart_badge.dart';
import 'package:drip_society/layouts/desktop/cart/widgets/cart_drawer.dart';
import 'package:drip_society/layouts/widgets/logo_app.dart';
import 'package:drip_society/core/widgets/language_switch_button.dart';
import 'package:drip_society/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';

class DesktopNavbar extends StatelessWidget {
  const DesktopNavbar({
    super.key,
    required this.onHomeTap,
    required this.onAboutTap,
    required this.onProductsTap,
    required this.onContactTap,
  });

  final VoidCallback onHomeTap;
  final VoidCallback onAboutTap;
  final VoidCallback onProductsTap;
  final VoidCallback onContactTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 1200;
        final cart = CartBadge(
          onTap: () {
            showModalBottomSheet<void>(
              context: context,
              isScrollControlled: true,
              builder: (_) => const CartDrawer(),
            );
          },
        );
        final language = const LanguageSwitchButton();
        final theme = const ThemeSwitch();
        final home = IconButton.filledTonal(
          onPressed: onHomeTap,
          tooltip: l10n.navHome,
          icon: const Icon(Icons.home_rounded),
        );
        final menu = PopupMenuButton<_NavTarget>(
          tooltip: l10n.navNavigation,
          icon: const Icon(Icons.menu_rounded),
          onSelected: (target) {
            switch (target) {
              case _NavTarget.about:
                onAboutTap();
              case _NavTarget.products:
                onProductsTap();
              case _NavTarget.contact:
                onContactTap();
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              value: _NavTarget.about,
              child: Text(l10n.navAboutUs),
            ),
            PopupMenuItem(
              value: _NavTarget.products,
              child: Text(l10n.navProducts),
            ),
            PopupMenuItem(
              value: _NavTarget.contact,
              child: Text(l10n.navContact),
            ),
          ],
        );
        final links = compact
            ? <Widget>[menu, const SizedBox(width: 10), home]
            : <Widget>[
                _NavItem(title: l10n.navHome, onTap: onHomeTap),
                const SizedBox(width: 40),
                _NavItem(title: l10n.navAboutUs, onTap: onAboutTap),
                const SizedBox(width: 40),
                _NavItem(title: l10n.navProducts, onTap: onProductsTap),
                const SizedBox(width: 40),
                _NavItem(title: l10n.navContact, onTap: onContactTap),
              ];
        final orderButton = ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          onPressed: onProductsTap,
          child: Text(l10n.orderNow),
        );
        final children = compact
            ? isArabic
                  ? <Widget>[
                      cart,
                      const SizedBox(width: 12),
                      language,
                      const SizedBox(width: 12),
                      theme,
                      const SizedBox(width: 12),
                      ...links,
                      const Spacer(),
                      orderButton,
                    ]
                  : <Widget>[
                      home,
                      const SizedBox(width: 10),
                      menu,
                      const Spacer(),
                      theme,
                      const SizedBox(width: 12),
                      cart,
                      const SizedBox(width: 12),
                      language,
                      const SizedBox(width: 12),
                      orderButton,
                    ]
            : isArabic
            ? <Widget>[
                cart,
                const SizedBox(width: 20),
                language,
                const SizedBox(width: 20),
                theme,
                const SizedBox(width: 50),
                ...links,
                const Spacer(),
                const LogoApp(),
              ]
            : <Widget>[
                const LogoApp(),
                const Spacer(),
                ...links,
                const SizedBox(width: 50),
                theme,
                const SizedBox(width: 20),
                cart,
                const SizedBox(width: 12),
                language,
              ];

        return Container(
          height: 90,
          padding: EdgeInsets.symmetric(horizontal: compact ? 24 : 80),
          child: Row(children: children),
        );
      },
    );
  }
}

enum _NavTarget { about, products, contact }

class _NavItem extends StatefulWidget {
  final String title;
  final VoidCallback onTap;

  const _NavItem({required this.title, required this.onTap});

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => hovering = true),
      onExit: (_) => setState(() => hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.only(bottom: 4),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: hovering
                    ? Theme.of(context).primaryColor
                    : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Text(
            widget.title,
            style: TextStyle(
              fontSize: 16,
              color: hovering
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).textTheme.bodyLarge?.color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
