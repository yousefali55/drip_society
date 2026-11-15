import 'package:drip_society/layouts/desktop/hero/model/hero_model.dart';
import 'package:drip_society/l10n/generated/app_localizations.dart';

const heroItemCount = 3;

List<HeroModel> heroItems(AppLocalizations l10n) => [
  HeroModel(
    title: l10n.heroBeanTitle,
    subtitle: l10n.heroBeanSubtitle,
    description: l10n.heroBeanDescription,
    image: 'assets/images/land1.png',
  ),
  HeroModel(
    title: l10n.heroBrewTitle,
    subtitle: l10n.heroBrewSubtitle,
    description: l10n.heroBrewDescription,
    image: 'assets/images/land2.png',
  ),
  HeroModel(
    title: l10n.heroPureTitle,
    subtitle: l10n.heroPureSubtitle,
    description: l10n.heroPureDescription,
    image: 'assets/images/land3.png',
  ),
];
