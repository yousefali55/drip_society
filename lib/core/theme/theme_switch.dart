import 'package:drip_society/core/theme/cubit/theme_changer_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeSwitch extends StatelessWidget {
  const ThemeSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        final isDark = themeMode == ThemeMode.dark;
        final colorScheme = Theme.of(context).colorScheme;

        return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              context.read<ThemeCubit>().toggleTheme();
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 350),
              curve: Curves.easeInOut,
              width: 78,
              height: 42,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: isDark
                    ? colorScheme.surfaceContainerHighest
                    : colorScheme.primary.withValues(alpha: .14),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Center(
                          child: AnimatedOpacity(
                            duration: const Duration(milliseconds: 250),
                            opacity: isDark ? .4 : 1,
                            child: Icon(
                              Icons.wb_sunny_rounded,
                              size: 18,
                              color: colorScheme.secondary,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: AnimatedOpacity(
                            duration: const Duration(milliseconds: 250),
                            opacity: isDark ? 1 : .4,
                            child: Icon(
                              Icons.nightlight_round,
                              size: 18,
                              color: colorScheme.onPrimary,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  AnimatedAlign(
                    duration: const Duration(milliseconds: 350),
                    curve: Curves.easeInOut,
                    alignment: isDark
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        color: colorScheme.surface,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 10,
                            color: colorScheme.shadow.withValues(alpha: 0.18),
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),

                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder: (child, animation) {
                          return RotationTransition(
                            turns: animation,
                            child: FadeTransition(
                              opacity: animation,
                              child: child,
                            ),
                          );
                        },
                        child: Icon(
                          isDark
                              ? Icons.nightlight_round
                              : Icons.wb_sunny_rounded,
                          key: ValueKey(isDark),
                          size: 18,
                          color: isDark
                              ? colorScheme.primary
                              : colorScheme.secondary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
