import 'package:bloc/bloc.dart';
import 'package:drip_society/core/network/api_error_handler.dart';
import 'package:drip_society/layouts/desktop/products/data/product_model.dart';
import 'package:drip_society/layouts/desktop/products/data/repository/products_repository.dart';
import 'package:meta/meta.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit(this.repository) : super(ProductsInitial());

  final ProductsRepository repository;

  Future<void> getProducts() async {
    emit(ProductsLoading());
    try {
      final products = await repository.getProducts();
      emit(ProductsSuccess(products: products));
    } on AppException catch (exception) {
      emit(ProductsFailure(exception: exception));
    }
  }
}
