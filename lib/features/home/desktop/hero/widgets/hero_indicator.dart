import 'package:flutter/material.dart';

class HeroIndicator extends StatelessWidget {
  const HeroIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Icon(Icons.remove, size: 40),
        SizedBox(width: 8),
        Icon(Icons.remove, size: 40),
        SizedBox(width: 8),
        Icon(Icons.remove, size: 40),
      ],
    );
  }
}