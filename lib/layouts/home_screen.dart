import 'package:drip_society/core/responsive/responsive_layout.dart';
import 'package:drip_society/layouts/desktop/home_desktop_layout.dart';
import 'package:drip_society/layouts/mobile/home_mobile_layout.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: const MobileHomeLayout(),
      desktop: const HomeDesktopLayout(),
    );
  }
}
