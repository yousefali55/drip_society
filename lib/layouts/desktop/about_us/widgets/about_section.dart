import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final horizontalPadding = (width * .07).clamp(42.0, 100.0).toDouble();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        horizontalPadding,
        110,
        horizontalPadding,
        118,
      ),
      color: Colors.transparent,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1180),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isNarrow = constraints.maxWidth < 860;
              final image = Center(
                child: Image.asset(
                  'assets/images/coffeecup-1.png',
                  height: isNarrow ? 340 : 500,
                  fit: BoxFit.contain,
                ),
              ).animate().fade(duration: 650.ms).slideY(begin: .12);

              final copy = _AboutCopy(isNarrow: isNarrow);

              if (isNarrow) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    image,
                    const SizedBox(height: 42),
                    copy,
                  ],
                );
              }

              return Row(
                children: [
                  Expanded(child: image),
                  const SizedBox(width: 92),
                  Expanded(child: copy),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _AboutCopy extends StatelessWidget {
  const _AboutCopy({required this.isNarrow});

  final bool isNarrow;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
          style: (isNarrow
                  ? Theme.of(context).textTheme.headlineMedium
                  : Theme.of(context).textTheme.displaySmall)
              ?.copyWith(fontWeight: FontWeight.bold, height: 1.15),
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
          'Expert Coffee',
        ).animate().fade(delay: 520.ms).slideY(begin: .12),
        const SizedBox(height: 16),
        const _Feature(
          'Freshly Brewed Everyday',
        ).animate().fade(delay: 620.ms).slideY(begin: .12),
        const SizedBox(height: 36),
        FilledButton(
          onPressed: () {},
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 18),
            child: Text('Discover More'),
          ),
        ).animate().fade(delay: 720.ms).scale(begin: const Offset(.96, .96)),
      ],
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
