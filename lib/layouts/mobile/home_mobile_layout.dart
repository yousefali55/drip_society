import 'package:drip_society/layouts/desktop/cart/widgets/cart_drawer.dart';
import 'package:drip_society/layouts/desktop/products/data/cubit/products_cubit.dart';
import 'package:drip_society/layouts/desktop/products/data/products_repo.dart';
import 'package:drip_society/layouts/desktop/widgets/desktop_footer.dart';
import 'package:drip_society/layouts/mobile/about_us/widgets/mobile_about_section.dart';
import 'package:drip_society/layouts/mobile/hero/widgets/mobile_hero_section.dart';
import 'package:drip_society/layouts/mobile/products/mobile_products_section.dart';
import 'package:drip_society/layouts/mobile/widgets/mobile_navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                      onCart: () => _openCart(context),
                    ),
                  ),
                  SizedBox(key: _aboutKey, child: const MobileAboutSection()),
                  SizedBox(
                    key: _productsKey,
                    child: const MobileProductsSection(),
                  ),
                  SizedBox(
                    key: _contactKey,
                    child: DesktopFooter(
                      onNavTap: (target) {
                        switch (target) {
                          case FooterNavTarget.home:
                            _scrollTo(_homeKey);
                          case FooterNavTarget.about:
                            _scrollTo(_aboutKey);
                          case FooterNavTarget.products:
                            _scrollTo(_productsKey);
                          case FooterNavTarget.contact:
                            _scrollTo(_contactKey);
                        }
                      },
                    ),
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
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withValues(alpha: 0.35),
      elevation: 0,
      builder: (_) => const CartDrawer(),
    );
  }
}
