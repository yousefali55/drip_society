import 'package:drip_society/core/theme/theme_switch.dart';
import 'package:drip_society/features/auth/presentation/widgets/auth_menu_button.dart';
import 'package:drip_society/layouts/desktop/cart/widgets/cart_badge.dart';
import 'package:drip_society/layouts/desktop/cart/widgets/cart_drawer.dart';
import 'package:drip_society/layouts/widgets/logo_app.dart';
import 'package:flutter/material.dart';

class DesktopNavbar extends StatelessWidget {
  const DesktopNavbar({super.key});

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
                    const Spacer(),
                    const ThemeSwitch(),
                    const SizedBox(width: 12),
                    const AuthMenuButton(compact: true),
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
                      onPressed: () {},
                      child: const Text("Order Now"),
                    ),
                  ],
                )
              : Row(
                  children: [
                    const LogoApp(),

                    const Spacer(),

                    const _NavItem(title: "Home"),
                    const SizedBox(width: 40),

                    const _NavItem(title: "About"),
                    const SizedBox(width: 40),

                    const _NavItem(title: "Products"),
                    const SizedBox(width: 40),

                    const _NavItem(title: "Contact"),

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

                    const AuthMenuButton(),
                    const SizedBox(width: 12),


                  ],
                ),
        );
      },
    );
  }
}

class _NavItem extends StatefulWidget {
  final String title;

  const _NavItem({required this.title});

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
    );
  }
}
