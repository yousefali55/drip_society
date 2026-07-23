import 'package:drip_society/core/theme/cubit/theme_changer_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogoApp extends StatelessWidget {
  const LogoApp({super.key});

  static const double _logoHeight = 90;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, themeMode) {
        final logoAsset = themeMode == ThemeMode.dark
            ? 'assets/images/whitelogo.png'
            : 'assets/images/blackLogo.png';

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 350),
          switchInCurve: Curves.easeOutCubic,
          switchOutCurve: Curves.easeInCubic,
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: ScaleTransition(
                scale: Tween<double>(begin: 0.92, end: 1.0).animate(animation),
                child: child,
              ),
            );
          },
          child: Image.asset(
            logoAsset,
            key: ValueKey(logoAsset),
            height: _logoHeight,
            fit: BoxFit.fitHeight,
          ),
        );
      },
    );
  }
}
