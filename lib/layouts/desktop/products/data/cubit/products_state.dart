part of 'products_cubit.dart';

@immutable
sealed class ProductsState {}

final class ProductsInitial extends ProductsState {}

final class ProductsLoading extends ProductsState {}

final class ProductsSuccess extends ProductsState {
  final List<ProductModel> products;

  ProductsSuccess({required this.products});
}

final class ProductsFailure extends ProductsState {
  final AppException exception;

  ProductsFailure({required this.exception});
}
