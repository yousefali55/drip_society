import 'package:drip_society/core/di/service_locator.dart';
import 'package:drip_society/layouts/desktop/about_us/widgets/about_section.dart';
import 'package:drip_society/layouts/desktop/hero/widgets/hero_section.dart';
import 'package:drip_society/layouts/desktop/products/data/cubit/products_cubit.dart';
import 'package:drip_society/layouts/desktop/products/products_section.dart';
import 'package:drip_society/layouts/desktop/widgets/desktop_footer.dart';
import 'package:drip_society/layouts/widgets/navbar_desktop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeDesktopLayout extends StatefulWidget {
  const HomeDesktopLayout({super.key});

  @override
  State<HomeDesktopLayout> createState() => _HomeDesktopLayoutState();
}

class _HomeDesktopLayoutState extends State<HomeDesktopLayout> {
  final ScrollController _controller = ScrollController();

  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _productsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  @override
  void dispose() {
    _controller.dispose();
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
    return Scaffold(
      body: SingleChildScrollView(
        controller: _controller,
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            DesktopNavbar(
              onHomeTap: () => _scrollTo(_homeKey),
              onAboutTap: () => _scrollTo(_aboutKey),
              onProductsTap: () => _scrollTo(_productsKey),
              onContactTap: () => _scrollTo(_contactKey),
            ),
            SizedBox(
              key: _homeKey,
              child: HeroSection(onExplore: () => _scrollTo(_productsKey)),
            ),
            SizedBox(key: _aboutKey, child: const AboutSection()),
            const SizedBox(height: 24),
            SizedBox(
              key: _productsKey,
              child: BlocProvider(
                create: (context) => getIt<ProductsCubit>()..getProducts(),
                child: const ProductsSection(),
              ),
            ),
            const SizedBox(height: 72),
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
      ),
    );
  }
}
