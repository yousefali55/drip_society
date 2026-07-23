import 'package:drip_society/core/theme/theme_switch.dart';
import 'package:drip_society/features/auth/presentation/widgets/auth_menu_button.dart';
import 'package:drip_society/layouts/desktop/cart/widgets/cart_badge.dart';
import 'package:drip_society/layouts/widgets/logo_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class MobileNavigationDrawer extends StatelessWidget {
  const MobileNavigationDrawer({
    super.key,
    required this.onHome,
    required this.onAbout,
    required this.onProducts,
    required this.onContact,
    required this.onCart,
  });

  final VoidCallback onHome;
  final VoidCallback onAbout;
  final VoidCallback onProducts;
  final VoidCallback onContact;
  final VoidCallback onCart;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(22, 18, 22, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const LogoApp(),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close_rounded),
                  ),
                ],
              ),
              const SizedBox(height: 36),
              _DrawerItem(
                icon: Icons.home_rounded,
                label: 'Home',
                onTap: () => _navigate(context, onHome),
              ),
              _DrawerItem(
                icon: Icons.info_rounded,
                label: 'About',
                onTap: () => _navigate(context, onAbout),
              ),
              _DrawerItem(
                icon: Icons.local_cafe_rounded,
                label: 'Products',
                onTap: () => _navigate(context, onProducts),
              ),
              _DrawerItem(
                icon: Icons.call_rounded,
                label: 'Contact',
                onTap: () => _navigate(context, onContact),
              ),
              const SizedBox(height: 28),
              const AuthMenuButton(compact: true),
              const SizedBox(height: 16),
              Divider(color: Theme.of(context).dividerColor),
              const SizedBox(height: 18),
              Row(
                children: [
                  Icon(
                    Icons.contrast_rounded,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 14),
                  Text(
                    'Theme',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Spacer(),
                  const ThemeSwitch(),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  Text(
                    'Cart',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Spacer(),
                  CartBadge(onTap: () => _openCart(context)),
                ],
              ),
            ],
          ),
        ),
      ),
    ).animate().fade(duration: 300.ms).slideX(begin: -.08);
  }

  void _navigate(BuildContext context, VoidCallback onTap) {
    Navigator.of(context).pop();
    onTap();
  }

  void _openCart(BuildContext context) {
    Navigator.of(context).pop();
    Future<void>.delayed(const Duration(milliseconds: 180), onCart);
  }
}

class _DrawerItem extends StatelessWidget {
  const _DrawerItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          child: Row(
            children: [
              Icon(icon, color: Theme.of(context).colorScheme.primary),
              const SizedBox(width: 16),
              Text(
                label,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
