import 'package:drip_society/core/di/service_locator.dart';
import 'package:drip_society/core/network/api_service.dart';
import 'package:drip_society/drip_society_app.dart';
import 'package:drip_society/layouts/desktop/products/data/cubit/products_cubit.dart';
import 'package:drip_society/layouts/desktop/products/data/product_model.dart';
import 'package:drip_society/layouts/desktop/products/data/products_response_model.dart';
import 'package:drip_society/layouts/desktop/products/data/repository/products_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('English storefront renders navigation and products', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    await getIt.reset();
    getIt.registerFactory<ProductsCubit>(
      () => ProductsCubit(_ProductsRepository()),
    );
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(1440, 900);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(const DripSocietyApp());
    await tester.pump();

    expect(tester.takeException(), isNull);
    expect(find.text('Home'), findsWidgets);
    expect(find.text('About Us'), findsWidgets);
    expect(find.text('Products'), findsWidgets);
    expect(find.text('Contact'), findsWidgets);
    expect(find.text('Every Bean'), findsOneWidget);
    expect(find.text('Premium Coffee Collection'), findsOneWidget);
    expect(find.text('House Blend Coffee'), findsOneWidget);

    await tester.pump(const Duration(seconds: 2));
    await tester.pumpWidget(const SizedBox.shrink());
    await getIt.reset();
  });
}

class _ProductsRepository extends ProductsRepository {
  _ProductsRepository() : super(_ApiService());

  @override
  Future<List<ProductModel>> getProducts() async => const [
    ProductModel(
      id: 'widget-test-coffee',
      nameEn: 'House Blend Coffee',
      nameAr: 'خلطة القهوة',
      description: 'A balanced house blend.',
      price: 120,
      imageUrl: '',
      isFeatured: true,
    ),
  ];
}

class _ApiService implements ApiService {
  @override
  Future<ProductsResponseModel> getProducts() async =>
      ProductsResponseModel(isSuccess: true, message: '', data: const []);
}
