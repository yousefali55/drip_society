import 'package:flutter/material.dart';
import 'package:drip_society/l10n/generated/app_localizations.dart';

class EgyptianGovernorateDropdown extends StatefulWidget {
  const EgyptianGovernorateDropdown({
    super.key,
    required this.controller,
    this.labelText,
    this.validator,
  });

  static const governorates = <String>[
    'Cairo',
    'Giza',
    'Alexandria',
    'Dakahlia',
    'Red Sea',
    'Beheira',
    'Fayoum',
    'Gharbia',
    'Ismailia',
    'Menofia',
    'Minya',
    'Qalyubia',
    'New Valley',
    'Suez',
    'Aswan',
    'Assiut',
    'Beni Suef',
    'Port Said',
    'Damietta',
    'Sharqia',
    'South Sinai',
    'Kafr El Sheikh',
    'Matrouh',
    'Luxor',
    'Qena',
    'North Sinai',
    'Sohag',
  ];

  final TextEditingController controller;
  final String? labelText;
  final String? Function(String?)? validator;

  @override
  State<EgyptianGovernorateDropdown> createState() =>
      _EgyptianGovernorateDropdownState();

  static String localizedName(AppLocalizations l10n, String code) =>
      switch (code) {
        'Cairo' => l10n.governorateCairo,
        'Giza' => l10n.governorateGiza,
        'Alexandria' => l10n.governorateAlexandria,
        'Dakahlia' => l10n.governorateDakahlia,
        'Red Sea' => l10n.governorateRedSea,
        'Beheira' => l10n.governorateBeheira,
        'Fayoum' => l10n.governorateFayoum,
        'Gharbia' => l10n.governorateGharbia,
        'Ismailia' => l10n.governorateIsmailia,
        'Menofia' => l10n.governorateMenofia,
        'Minya' => l10n.governorateMinya,
        'Qalyubia' => l10n.governorateQalyubia,
        'New Valley' => l10n.governorateNewValley,
        'Suez' => l10n.governorateSuez,
        'Aswan' => l10n.governorateAswan,
        'Assiut' => l10n.governorateAssiut,
        'Beni Suef' => l10n.governorateBeniSuef,
        'Port Said' => l10n.governoratePortSaid,
        'Damietta' => l10n.governorateDamietta,
        'Sharqia' => l10n.governorateSharqia,
        'South Sinai' => l10n.governorateSouthSinai,
        'Kafr El Sheikh' => l10n.governorateKafrElSheikh,
        'Matrouh' => l10n.governorateMatrouh,
        'Luxor' => l10n.governorateLuxor,
        'Qena' => l10n.governorateQena,
        'North Sinai' => l10n.governorateNorthSinai,
        'Sohag' => l10n.governorateSohag,
        _ => code,
      };

  static String? validate(String? value, AppLocalizations l10n) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) {
      return l10n.selectGovernorateValidation;
    }
    return null;
  }
}

class _EgyptianGovernorateDropdownState
    extends State<EgyptianGovernorateDropdown> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final selectedGovernorate = widget.controller.text;
    return TextFormField(
      key: ValueKey('${l10n.localeName}_$selectedGovernorate'),
      initialValue: selectedGovernorate.isEmpty
          ? null
          : EgyptianGovernorateDropdown.localizedName(
              l10n,
              selectedGovernorate,
            ),
      readOnly: true,
      validator:
          widget.validator ??
          (value) => EgyptianGovernorateDropdown.validate(value, l10n),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onTap: () => _selectGovernorate(context),
      decoration: InputDecoration(
        labelText: widget.labelText ?? l10n.governorate,
        prefixIcon: const Icon(Icons.location_city_rounded),
        suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }

  Future<void> _selectGovernorate(BuildContext context) async {
    final selected = await _showPicker(context);
    if (selected == null || !context.mounted) return;

    widget.controller.text = selected;
    setState(() {});
    Form.maybeOf(context)?.validate();
  }

  Future<String?> _showPicker(BuildContext context) {
    final isWide = MediaQuery.sizeOf(context).width >= 600;

    if (isWide) {
      return showDialog<String>(
        context: context,
        builder: (_) => Dialog(
          insetPadding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420, maxHeight: 560),
            child: _GovernoratePicker(selectedValue: widget.controller.text),
          ),
        ),
      );
    }

    return showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withValues(alpha: 0.35),
      builder: (_) {
        final mediaQuery = MediaQuery.of(context);
        return Padding(
          padding: EdgeInsets.fromLTRB(
            16,
            mediaQuery.padding.top + 24,
            16,
            mediaQuery.padding.bottom + 16,
          ),
          child: Material(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(28),
            clipBehavior: Clip.antiAlias,
            child: SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.72,
              child: _GovernoratePicker(selectedValue: widget.controller.text),
            ),
          ),
        );
      },
    );
  }
}

class _GovernoratePicker extends StatefulWidget {
  const _GovernoratePicker({required this.selectedValue});

  final String selectedValue;

  @override
  State<_GovernoratePicker> createState() => _GovernoratePickerState();
}

class _GovernoratePickerState extends State<_GovernoratePicker> {
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;
    final filteredGovernorates = EgyptianGovernorateDropdown.governorates.where(
      (governorateCode) {
        return EgyptianGovernorateDropdown.localizedName(
          l10n,
          governorateCode,
        ).toLowerCase().contains(_query.toLowerCase());
      },
    ).toList();

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 12, 18, 18),
        child: Column(
          children: [
            Container(
              width: 44,
              height: 5,
              decoration: BoxDecoration(
                color: colorScheme.onSurfaceVariant.withValues(alpha: 0.28),
                borderRadius: BorderRadius.circular(999),
              ),
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Expanded(
                  child: Text(
                    l10n.selectGovernorate,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                IconButton.filledTonal(
                  onPressed: () => Navigator.of(context).pop(),
                  tooltip: l10n.close,
                  icon: const Icon(Icons.close_rounded),
                ),
              ],
            ),
            const SizedBox(height: 14),
            TextField(
              controller: _searchController,
              onChanged: (value) => setState(() => _query = value),
              decoration: InputDecoration(
                hintText: l10n.searchGovernorates,
                prefixIcon: const Icon(Icons.search_rounded),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemCount: filteredGovernorates.length,
                separatorBuilder: (_, _) => const SizedBox(height: 4),
                itemBuilder: (context, index) {
                  final governorateCode = filteredGovernorates[index];
                  final governorate = EgyptianGovernorateDropdown.localizedName(
                    l10n,
                    governorateCode,
                  );
                  final isSelected = governorateCode == widget.selectedValue;

                  return ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    selected: isSelected,
                    selectedTileColor: colorScheme.primaryContainer.withValues(
                      alpha: 0.45,
                    ),
                    leading: Icon(
                      Icons.location_on_outlined,
                      color: isSelected
                          ? colorScheme.primary
                          : colorScheme.onSurfaceVariant,
                    ),
                    title: Text(
                      governorate,
                      style: TextStyle(
                        fontWeight: isSelected
                            ? FontWeight.w800
                            : FontWeight.w600,
                      ),
                    ),
                    trailing: isSelected
                        ? Icon(
                            Icons.check_circle_rounded,
                            color: colorScheme.primary,
                          )
                        : null,
                    onTap: () => Navigator.of(context).pop(governorateCode),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
