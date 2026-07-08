import 'package:flutter/material.dart';

class HeroImage extends StatelessWidget {

  final String image;

  const HeroImage({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {

    return AnimatedSwitcher(

      duration: const Duration(milliseconds: 700),

      transitionBuilder: (child, animation) {

        return SlideTransition(

          position: Tween(
            begin: const Offset(.3, 0),
            end: Offset.zero,
          ).animate(animation),

          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );

      },

      child: Image.asset(
        image,
        key: ValueKey(image),
        fit: BoxFit.contain,
      ),
    );
  }
}