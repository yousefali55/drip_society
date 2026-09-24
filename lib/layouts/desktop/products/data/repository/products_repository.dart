import 'package:dio/dio.dart';
import 'package:drip_society/core/network/api_error_handler.dart';
import 'package:drip_society/core/network/api_service.dart';
import 'package:drip_society/layouts/desktop/products/data/product_model.dart';

class ProductsRepository {
  final ApiService apiService;

  ProductsRepository(this.apiService);
  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await apiService.getProducts();
      if (!response.isSuccess) {
        throw AppException(
          errorType: AppErrorType.unknown,
          message: response.message,
        );
      }
      return response.data;
    } on DioException catch (exception) {
      throw ApiErrorHandler.handle(exception);
    }
  }
}
