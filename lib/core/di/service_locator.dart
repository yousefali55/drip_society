import 'package:dio/dio.dart';
import 'package:drip_society/core/network/api_service.dart';
import 'package:drip_society/core/network/dio_factory.dart';
import 'package:drip_society/layouts/desktop/products/data/cubit/products_cubit.dart';
import 'package:drip_society/layouts/desktop/products/data/repository/products_repository.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerLazySingleton<Dio>(() => DioFactory.createDio());
  getIt.registerLazySingleton<ApiService>(() => ApiService(getIt<Dio>()));
  getIt.registerLazySingleton<ProductsRepository>(
    () => ProductsRepository(getIt<ApiService>()),
  );
  getIt.registerFactory<ProductsCubit>(
    () => ProductsCubit(getIt<ProductsRepository>()),
  );
}
