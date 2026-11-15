import 'package:drip_society/core/locale/locale_cubit.dart';
import 'package:drip_society/core/widgets/language_switch_button.dart';
import 'package:drip_society/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('language switch updates direction and persists selection', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    final localeCubit = LocaleCubit();

    await tester.pumpWidget(
      BlocProvider.value(
        value: localeCubit,
        child: BlocBuilder<LocaleCubit, Locale>(
          builder: (context, locale) => MaterialApp(
            locale: locale,
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            home: const Scaffold(
              body: Column(
                children: [LanguageSwitchButton(), DirectionalityProbe()],
              ),
            ),
          ),
        ),
      ),
    );

    expect(find.text('العربية'), findsOneWidget);
    expect(find.byKey(const ValueKey(TextDirection.ltr)), findsOneWidget);

    await tester.tap(find.text('العربية'));
    await tester.pumpAndSettle();

    expect(find.text('English'), findsOneWidget);
    expect(find.byKey(const ValueKey(TextDirection.rtl)), findsOneWidget);

    final preferences = await SharedPreferences.getInstance();
    expect(preferences.getString('app_language'), 'ar');

    final restoredLocale = await LocaleCubit.loadSavedLocale();
    expect(restoredLocale.languageCode, 'ar');

    await localeCubit.close();
  });
}

class DirectionalityProbe extends StatelessWidget {
  const DirectionalityProbe({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(key: ValueKey(Directionality.of(context)));
  }
}
