import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget desktop;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    required this.desktop,
  });

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= 600 && width < 1024;
  }

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1024;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width >= 1024) {
      return desktop;
    }
    return mobile;
  }
}
