

import 'package:drip_society/layouts/desktop/hero/widgets/hero_section.dart';
import 'package:drip_society/layouts/desktop/products/data/cubit/products_cubit.dart';
import 'package:drip_society/layouts/desktop/products/data/products_repo.dart';
import 'package:drip_society/layouts/desktop/products/products_section.dart';
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

  final GlobalKey _productsKey = GlobalKey();

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
            const DesktopNavbar(),
            HeroSection(onExplore: () => _scrollTo(_productsKey)),
            const SizedBox(height: 24),
            SizedBox(
              key: _productsKey,
              child: BlocProvider(
                create: (context) =>
                    ProductsCubit(ProductsRepository())..getProducts(),
                child: const ProductsSection(),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
