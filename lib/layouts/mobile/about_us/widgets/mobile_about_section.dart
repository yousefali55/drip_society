import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class MobileAboutSection extends StatelessWidget {
  const MobileAboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final horizontalPadding = (width * .07).clamp(20.0, 30.0).toDouble();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        horizontalPadding,
        70,
        horizontalPadding,
        76,
      ),
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image.asset(
              'assets/images/coffeecup-1.png',
              height: (width * .82).clamp(230.0, 360.0).toDouble(),
              fit: BoxFit.contain,
            ),
          ).animate().fade(duration: 650.ms).slideY(begin: .12),
          const SizedBox(height: 42),
          Text(
            'ABOUT US',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
              letterSpacing: 3,
            ),
          ).animate().fade(delay: 120.ms).slideY(begin: .12),
          const SizedBox(height: 18),
          Text(
            'Brewing Experiences,\nNot Just Coffee.',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              height: 1.15,
            ),
          ).animate().fade(delay: 220.ms).slideY(begin: .12),
          const SizedBox(height: 24),
          Text(
            "At Drip Society, we don't simply serve coffee. "
            'We create an experience that inspires focus, creativity, '
            'and meaningful conversations. Every cup is crafted with '
            'care using premium beans and exceptional brewing techniques.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.8),
          ).animate().fade(delay: 320.ms).slideY(begin: .12),
          const SizedBox(height: 34),
          const _Feature(
            'Premium Coffee Beans',
          ).animate().fade(delay: 420.ms).slideY(begin: .12),
          const SizedBox(height: 16),
          const _Feature(
            'Expert Baristas',
          ).animate().fade(delay: 520.ms).slideY(begin: .12),
          const SizedBox(height: 16),
          const _Feature(
            'Freshly Brewed Everyday',
          ).animate().fade(delay: 620.ms).slideY(begin: .12),
          const SizedBox(height: 36),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () {},
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Text('Discover More'),
              ),
            ),
          ).animate().fade(delay: 720.ms).scale(begin: const Offset(.96, .96)),
        ],
      ),
    );
  }
}

class _Feature extends StatelessWidget {
  const _Feature(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.check_circle_rounded,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Text(title, style: Theme.of(context).textTheme.titleMedium),
        ),
      ],
    );
  }
}
