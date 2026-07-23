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
      color: Colors.transparent,
      child: Row(
        children: [
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
                  "Drip Society is dedicated to delivering premium coffee beans "
                  "for those who value quality in every cup. "
                  "We carefully source, roast, and package our coffee "
                  "to preserve its rich aroma and authentic flavor. "
                  " Every 200g bag reflects our passion for craftsmanship " 
                  "ensuring a smooth and memorable coffee experience "
                      "from the first sip to the last." ,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        height: 1.8,
                      ),
                )
                    .animate()
                    .fade(delay: 500.ms)
                    .slideX(begin: .2),

                const SizedBox(height: 40),

                const _Feature("Ultra Premium Coffee ")
                    .animate()
                    .fade(delay: 650.ms)
                    .slideX(begin: .2),

                const SizedBox(height: 18),

                const _Feature("Expert Beans Roasting")
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