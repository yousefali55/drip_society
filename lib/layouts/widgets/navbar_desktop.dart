import 'package:drip_society/core/theme/theme_switch.dart';
import 'package:drip_society/layouts/desktop/cart/widgets/cart_badge.dart';
import 'package:drip_society/layouts/desktop/cart/widgets/cart_drawer.dart';
import 'package:drip_society/layouts/widgets/logo_app.dart';
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
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 1000;

        return Container(
          height: 90,
          padding: EdgeInsets.symmetric(horizontal: compact ? 24 : 80),
          child: compact
              ? Row(
                  children: [
                    IconButton.filledTonal(
                      onPressed: onHomeTap,
                      tooltip: 'Home',
                      icon: const Icon(Icons.home_rounded),
                    ),
                    const SizedBox(width: 10),
                    PopupMenuButton<_NavTarget>(
                      tooltip: 'Navigation',
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
                      itemBuilder: (context) => const [
                        PopupMenuItem(
                          value: _NavTarget.about,
                          child: Text('About Us'),
                        ),
                        PopupMenuItem(
                          value: _NavTarget.products,
                          child: Text('Products'),
                        ),
                        PopupMenuItem(
                          value: _NavTarget.contact,
                          child: Text('Contact'),
                        ),
                      ],
                    ),
                    const Spacer(),
                    const ThemeSwitch(),
                    const SizedBox(width: 12),
                    const SizedBox(width: 12),
                    CartBadge(
                      onTap: () {
                        showModalBottomSheet<void>(
                          context: context,
                          isScrollControlled: true,
                          builder: (_) => const CartDrawer(),
                        );
                      },
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Theme.of(
                          context,
                        ).colorScheme.onPrimary,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: onProductsTap,
                      child: const Text("Order Now"),
                    ),
                  ],
                )
              : Row(
                  children: [
                    const LogoApp(),

                    const Spacer(),

                    _NavItem(title: "Home", onTap: onHomeTap),
                    const SizedBox(width: 40),

                    _NavItem(title: "About Us", onTap: onAboutTap),
                    const SizedBox(width: 40),

                    _NavItem(title: "Products", onTap: onProductsTap),
                    const SizedBox(width: 40),

                    _NavItem(title: "Contact", onTap: onContactTap),

                    const SizedBox(width: 50),

                    /// Theme
                    const ThemeSwitch(),

                    const SizedBox(width: 20),

                    CartBadge(
                      onTap: () {
                        showModalBottomSheet<void>(
                          context: context,
                          isScrollControlled: true,
                          builder: (_) => const CartDrawer(),
                        );
                      },
                    ),

                    const SizedBox(width: 25),
                    const SizedBox(width: 12),
                  ],
                ),
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
