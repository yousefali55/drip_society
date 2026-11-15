import 'package:drip_society/core/locale/locale_cubit.dart';
import 'package:drip_society/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageSwitchButton extends StatelessWidget {
  const LanguageSwitchButton({super.key, this.compact = false});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return OutlinedButton(
      onPressed: () => context.read<LocaleCubit>().toggleLocale(),
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(0, 40),
        padding: EdgeInsets.symmetric(
          horizontal: compact ? 8 : 14,
          vertical: 10,
        ),
        side: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      child: Text(
        isArabic
            ? localizations.languageSwitchEnglish
            : localizations.languageSwitchArabic,
        style: const TextStyle(fontWeight: FontWeight.w700),
      ),
    );
  }
}
