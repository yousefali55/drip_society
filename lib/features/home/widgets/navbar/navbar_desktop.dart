import 'package:drip_society/core/theme/theme_switch.dart';
import 'package:flutter/material.dart';

class DesktopNavbar extends StatelessWidget {
  const DesktopNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      padding: const EdgeInsets.symmetric(horizontal: 80),
      child: Row(
        children: [
          /// Logo
          const _Logo(),

          const Spacer(),

          /// Navigation
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

          const SizedBox(width: 25),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff5B3924),
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            onPressed: () {},
            child: const Text("Order Now"),
          ),
        ],
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo();

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "DRIP.",
          style: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        Text(
          "Society",
          style: TextStyle(fontSize: 12, letterSpacing: 5, color: Colors.grey),
        ),
      ],
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
              color: hovering ? Theme.of(context).primaryColor : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          widget.title,
          style: TextStyle(
            fontSize: 16,
            color: hovering ? const Color(0xff5B3924) : Theme.of(context).textTheme.bodyLarge?.color,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
