import 'package:drip_society/features/home/desktop/about_us/widgets/about_section.dart';
import 'package:drip_society/features/home/desktop/hero/widgets/hero_section.dart';
import 'package:drip_society/features/home/widgets/navbar/navbar_desktop.dart';
import 'package:flutter/material.dart';

class HomeDesktopLayout extends StatefulWidget {
  const HomeDesktopLayout({super.key});

  @override
  State<HomeDesktopLayout> createState() => _HomeDesktopLayoutState();
}

class _HomeDesktopLayoutState extends State<HomeDesktopLayout> {
  final ScrollController controller = ScrollController();

  final aboutKey = GlobalKey();

  void scrollToAbout() {
    if (aboutKey.currentContext != null) {
      Scrollable.ensureVisible(
        aboutKey.currentContext!,
        duration: const Duration(milliseconds: 900),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: controller,
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const DesktopNavbar(),

            HeroSection(
              onExplore: scrollToAbout,
            ),

            AboutSection(
              key: aboutKey,
            ),
          ],
        ),
      ),
    );
  }
}