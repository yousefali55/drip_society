import 'package:drip_society/core/locale/locale_cubit.dart';
import 'package:drip_society/core/di/service_locator.dart';
import 'package:drip_society/drip_society_app.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupDependencies();
  final locale = await LocaleCubit.loadSavedLocale();
  runApp(DripSocietyApp(initialLocale: locale));
}
