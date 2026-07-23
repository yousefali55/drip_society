import 'package:drip_society/layouts/desktop/cart/widgets/cart_drawer.dart';
import 'package:drip_society/layouts/desktop/products/data/cubit/products_cubit.dart';
import 'package:drip_society/layouts/desktop/products/data/products_repo.dart';
import 'package:drip_society/layouts/mobile/about_us/widgets/mobile_about_section.dart';
import 'package:drip_society/layouts/mobile/hero/widgets/mobile_hero_section.dart';
import 'package:drip_society/layouts/mobile/products/mobile_products_section.dart';
import 'package:drip_society/layouts/mobile/widgets/mobile_navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';

class MobileHomeLayout extends StatefulWidget {
  const MobileHomeLayout({super.key});

  @override
  State<MobileHomeLayout> createState() => _MobileHomeLayoutState();
}

class _MobileHomeLayoutState extends State<MobileHomeLayout> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _productsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollTo(GlobalKey key) {
    final context = key.currentContext;
    if (context == null) return;

    Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 850),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductsCubit(ProductsRepository()),
      child: Scaffold(
        drawer: MobileNavigationDrawer(
          onHome: () => _scrollTo(_homeKey),
          onAbout: () => _scrollTo(_aboutKey),
          onProducts: () => _scrollTo(_productsKey),
          onContact: () => _scrollTo(_contactKey),
          onCart: () => _openCart(context),
        ),
        body: Builder(
          builder: (scaffoldContext) {
            return SingleChildScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    key: _homeKey,
                    child: MobileHeroSection(
                      onMenuTap: () =>
                          Scaffold.of(scaffoldContext).openDrawer(),
                      onExplore: () => _scrollTo(_productsKey),
                    ),
                  ),
                  SizedBox(key: _aboutKey, child: const MobileAboutSection()),
                  SizedBox(
                    key: _productsKey,
                    child: const MobileProductsSection(),
                  ),
                  SizedBox(
                    key: _contactKey,
                    child: const _MobileContactSection(),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _openCart(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => const CartDrawer(),
    );
  }
}

class _MobileContactSection extends StatelessWidget {
  const _MobileContactSection();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final horizontalPadding = (width * .07).clamp(20.0, 30.0).toDouble();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        horizontalPadding,
        44,
        horizontalPadding,
        36,
      ),
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'CONTACT',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
              letterSpacing: 3,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            'Ready for your next cup?',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              height: 1.15,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Order your favorite Drip Society roast and enjoy a premium '
            'coffee ritual at home.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.7),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () => _showContactSnackBar(context),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Text('Contact Us'),
              ),
            ),
          ),
        ],
      ),
    ).animate().fade(duration: 500.ms).slideY(begin: .12);
  }

  void _showContactSnackBar(BuildContext context) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Contact coming soon')));
  }
}
