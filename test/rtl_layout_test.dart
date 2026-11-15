import 'package:drip_society/core/di/service_locator.dart';
import 'package:drip_society/core/locale/locale_cubit.dart';
import 'package:drip_society/core/network/api_service.dart';
import 'package:drip_society/drip_society_app.dart';
import 'package:drip_society/features/checkout/presentation/widgets/checkout_dialog.dart';
import 'package:drip_society/core/widgets/egyptian_governorate_dropdown.dart';
import 'package:drip_society/layouts/desktop/cart/cubit/cart_item_cubit.dart';
import 'package:drip_society/layouts/desktop/products/data/cubit/products_cubit.dart';
import 'package:drip_society/layouts/desktop/products/data/product_model.dart';
import 'package:drip_society/layouts/desktop/products/data/products_response_model.dart';
import 'package:drip_society/layouts/desktop/products/data/repository/products_repository.dart';
import 'package:drip_society/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'home stays overflow-free and switches direction at every width',
    (tester) async {
      SharedPreferences.setMockInitialValues({});
      await getIt.reset();
      getIt.registerFactory<ProductsCubit>(
        () => ProductsCubit(_EmptyProductsRepository()),
      );
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetDevicePixelRatio);
      addTearDown(tester.view.resetPhysicalSize);

      for (final width in [320.0, 390.0, 800.0, 1024.0, 1440.0]) {
        tester.view.physicalSize = Size(width, 900);
        await tester.pumpWidget(const DripSocietyApp());
        await tester.pump();

        expect(tester.takeException(), isNull, reason: 'English at $width px');
        expect(
          Directionality.of(tester.element(find.byType(Scaffold).first)),
          TextDirection.ltr,
        );
        expect(find.text('العربية'), findsOneWidget);
        expect(find.text('House Blend Coffee'), findsOneWidget);
        final englishCartX = tester.getCenter(find.byTooltip('Open cart')).dx;
        final englishLanguageX = tester.getCenter(find.text('العربية')).dx;
        expect(englishCartX, lessThan(englishLanguageX));
        if (width >= 1024) {
          expect(
            tester.getCenter(find.byTooltip('Theme')).dx,
            lessThan(englishCartX),
          );
        }
        _expectFooterOrder(tester, width, isArabic: false);

        if (width < 1024) {
          await tester.tap(find.byTooltip('Navigation'));
          await tester.pump(const Duration(milliseconds: 350));
          await tester.pump(const Duration(seconds: 1));
          expect(find.byType(Drawer), findsOneWidget);
          final drawerRect = tester.getRect(find.byType(Drawer));
          expect(drawerRect.left, closeTo(0, 1));
          await tester.tap(find.byTooltip('Close'));
          await tester.pump(const Duration(milliseconds: 350));
          await tester.pump(const Duration(seconds: 1));
        }

        await tester.tap(find.text('العربية'));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 350));

        expect(tester.takeException(), isNull, reason: 'Arabic at $width px');
        expect(
          Directionality.of(tester.element(find.byType(Scaffold).first)),
          TextDirection.rtl,
        );
        expect(find.text('English'), findsOneWidget);
        expect(find.text('خلطة القهوة'), findsOneWidget);
        final arabicCartX = tester.getCenter(find.byTooltip('افتح السلة')).dx;
        final arabicLanguageX = tester.getCenter(find.text('English')).dx;
        expect(arabicCartX, greaterThan(arabicLanguageX));
        if (width >= 1024) {
          expect(
            tester.getCenter(find.byTooltip('المظهر')).dx,
            lessThan(arabicLanguageX),
          );
        }
        _expectFooterOrder(tester, width, isArabic: true);

        await tester.tap(find.byTooltip('افتح السلة'));
        await tester.pump(const Duration(milliseconds: 350));
        await tester.pump(const Duration(seconds: 1));
        expect(find.text('سلتك'), findsOneWidget);
        expect(
          Directionality.of(tester.element(find.text('سلتك'))),
          TextDirection.rtl,
        );
        expect(find.byIcon(Icons.arrow_forward_ios_rounded), findsOneWidget);
        expect(tester.takeException(), isNull);
        await tester.tap(find.text('كمّل تسوّق'));
        await tester.pump(const Duration(seconds: 1));

        if (width < 1024) {
          await tester.tap(find.byTooltip('القائمة'));
          await tester.pump(const Duration(milliseconds: 350));
          await tester.pump(const Duration(seconds: 1));
          expect(find.byType(Drawer), findsOneWidget);
          expect(
            tester
                .state<ScaffoldState>(find.byType(Scaffold).last)
                .isDrawerOpen,
            isTrue,
          );
          final drawerRect = tester.getRect(find.byType(Drawer));
          expect(drawerRect.right, closeTo(width, 1));
          expect(tester.takeException(), isNull);
          await tester.tap(find.byTooltip('اقفل'));
          await tester.pump(const Duration(milliseconds: 350));
          await tester.pump(const Duration(seconds: 1));
        }

        await tester.pumpWidget(const SizedBox.shrink());
      }

      await getIt.reset();
    },
  );

  testWidgets('checkout and governorate picker follow locale direction', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);

    for (final width in [390.0, 1440.0]) {
      tester.view.physicalSize = Size(width, 900);
      final localeCubit = LocaleCubit(initialLocale: const Locale('ar'));
      await tester.pumpWidget(
        BlocProvider<LocaleCubit>.value(
          value: localeCubit,
          child: BlocProvider(
            create: (_) => CartCubit(),
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
                home: const Scaffold(body: CheckoutDialog()),
              ),
            ),
          ),
        ),
      );
      await tester.pump();

      expect(tester.takeException(), isNull);
      expect(
        Directionality.of(tester.element(find.byType(CheckoutDialog))),
        TextDirection.rtl,
      );
      expect(find.text('بيانات التوصيل'), findsOneWidget);

      await tester.tap(
        find.descendant(
          of: find.byType(EgyptianGovernorateDropdown),
          matching: find.byType(TextFormField),
        ),
      );
      await tester.pump(const Duration(milliseconds: 350));
      await tester.pump(const Duration(seconds: 1));
      expect(find.text('اختار محافظتك'), findsOneWidget);
      expect(tester.takeException(), isNull);

      await tester.tap(find.text('القاهرة'));
      await tester.pump(const Duration(milliseconds: 350));
      await tester.pump(const Duration(seconds: 1));
      expect(find.text('القاهرة'), findsOneWidget);

      await localeCubit.toggleLocale();
      await tester.pump();
      expect(
        Directionality.of(tester.element(find.byType(CheckoutDialog))),
        TextDirection.ltr,
      );
      expect(find.text('Cairo'), findsOneWidget);
      expect(tester.takeException(), isNull);

      await tester.pumpWidget(const SizedBox.shrink());
      await localeCubit.close();
    }
  });
}

void _expectFooterOrder(
  WidgetTester tester,
  double width, {
  required bool isArabic,
}) {
  final brandDescription = isArabic
      ? 'قهوتك المفضلة لصباح رايق، وتركيز أحسن، وقعدة حلوة مع اللي بتحبهم.'
      : 'Premium coffee rituals for slow mornings, focused work, and meaningful conversations.';
  final contactHeading = isArabic
      ? 'جاهز لفنجانك الجاي؟'
      : 'Ready for your next cup?';
  final developerCredit = isArabic
      ? 'تنفيذ يوسف علي'
      : 'Developed by Yousef Ali';
  final brandText = tester.widget<Text>(find.text(brandDescription));
  final contactText = tester.widget<Text>(find.text(contactHeading));
  final creditFinder = find.text(developerCredit);
  expect(creditFinder, findsOneWidget);
  expect(tester.getRect(creditFinder).center.dx, closeTo(width / 2, 1));

  if (width >= 860) {
    final brandX = tester.getRect(find.text(brandDescription)).center.dx;
    final contactX = tester.getRect(find.text(contactHeading)).center.dx;
    expect(
      isArabic ? brandX : contactX,
      greaterThan(isArabic ? contactX : brandX),
    );
  } else {
    expect(brandText.textAlign, isArabic ? TextAlign.right : TextAlign.left);
    expect(contactText.textAlign, isArabic ? TextAlign.right : TextAlign.left);
    final brandY = tester.getRect(find.text(brandDescription)).top;
    final contactY = tester.getRect(find.text(contactHeading)).top;
    expect(brandY, lessThan(contactY));
  }
}

class _EmptyProductsRepository extends ProductsRepository {
  _EmptyProductsRepository() : super(_EmptyApiService());

  @override
  Future<List<ProductModel>> getProducts() async => const [
    ProductModel(
      id: 'rtl-test-coffee',
      nameEn: 'House Blend Coffee',
      nameAr: 'خلطة القهوة',
      description: 'Coffee beans selected for a balanced cup.',
      price: 120,
      imageUrl: '',
      isFeatured: true,
    ),
  ];
}

class _EmptyApiService implements ApiService {
  @override
  Future<ProductsResponseModel> getProducts() async =>
      ProductsResponseModel(isSuccess: true, message: '', data: const []);
}
