import 'package:drip_society/core/theme/app_theme.dart';
import 'package:drip_society/core/theme/cubit/theme_changer_cubit.dart';
import 'package:drip_society/features/home/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DripSocietyApp extends StatelessWidget {
  const DripSocietyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Drip Society',

            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeMode,

            home: Scaffold(body: const HomeScreen()),
          );
        },
      ),
    );
  }
}
