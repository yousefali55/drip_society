import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 100,
        vertical: 120,
      ),
      color: Theme.of(context).colorScheme.surface,
      child: Row(
        children: [
          /// الصورة
          Expanded(
            child: Image.asset(
              "assets/images/about_beans.png",
              height: 550,
              fit: BoxFit.contain,
            )
                .animate()
                .fade(duration: 700.ms)
                .slideX(begin: -.3),
          ),

          const SizedBox(width: 90),

          /// النص
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "ABOUT US",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3,
                  ),
                )
                    .animate()
                    .fade(delay: 200.ms)
                    .slideX(begin: .2),

                const SizedBox(height: 20),

                Text(
                  "Brewing Experiences,\nNot Just Coffee.",
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall
                      ?.copyWith(
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                )
                    .animate()
                    .fade(delay: 350.ms)
                    .slideX(begin: .2),

                const SizedBox(height: 30),

                Text(
                  "At Drip Society, we don't simply serve coffee. "
                  "We create an experience that inspires focus, creativity, "
                  "and meaningful conversations. Every cup is crafted with "
                  "care using premium beans and exceptional brewing techniques.",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        height: 1.8,
                      ),
                )
                    .animate()
                    .fade(delay: 500.ms)
                    .slideX(begin: .2),

                const SizedBox(height: 40),

                const _Feature("Premium Coffee Beans")
                    .animate()
                    .fade(delay: 650.ms)
                    .slideX(begin: .2),

                const SizedBox(height: 18),

                const _Feature("Expert Baristas")
                    .animate()
                    .fade(delay: 800.ms)
                    .slideX(begin: .2),

                const SizedBox(height: 18),

                const _Feature("Freshly Brewed Everyday")
                    .animate()
                    .fade(delay: 950.ms)
                    .slideX(begin: .2),

                const SizedBox(height: 45),

                FilledButton(
                  onPressed: () {},
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 18,
                    ),
                    child: Text("Discover More"),
                  ),
                )
                    .animate()
                    .scale(
                      begin: const Offset(.8, .8),
                      delay: 1100.ms,
                    )
                    .fade(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Feature extends StatelessWidget {
  final String title;

  const _Feature(this.title);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.check_circle_rounded,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(width: 15),
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }
}