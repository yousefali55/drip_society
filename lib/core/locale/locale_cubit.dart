import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleCubit extends Cubit<Locale> {
  LocaleCubit({Locale initialLocale = const Locale('en')})
    : super(initialLocale);

  static const _preferenceKey = 'app_language';

  static Future<Locale> loadSavedLocale() async {
    final preferences = await SharedPreferences.getInstance();
    final languageCode = preferences.getString(_preferenceKey);
    return languageCode == 'ar' ? const Locale('ar') : const Locale('en');
  }

  Future<void> toggleLocale() async {
    final locale = state.languageCode == 'ar'
        ? const Locale('en')
        : const Locale('ar');
    emit(locale);

    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_preferenceKey, locale.languageCode);
  }
}
