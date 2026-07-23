import 'package:bloc/bloc.dart';
import 'package:drip_society/layouts/desktop/products/data/product_model.dart';
import 'package:drip_society/layouts/desktop/products/data/products_repo.dart';
import 'package:meta/meta.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit(this.repository)
            : super(ProductsSuccess(products: []));

  final ProductsRepository repository;

  Future<void> getProducts() async {
    emit(ProductsLoading());

    try {
      final products = await repository.getProducts();
      emit(ProductsSuccess(products: products));
    } catch (error) {
      emit(ProductsError(errorMessage: 'Failed to load products.'));
    }
  }
}
