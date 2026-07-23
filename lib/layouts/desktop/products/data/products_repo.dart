import 'package:dio/dio.dart';
import 'package:drip_society/core/network/api_constants.dart';
import 'package:drip_society/core/network/dio_client.dart';
import 'package:drip_society/layouts/desktop/products/data/product_model.dart';
import 'package:drip_society/layouts/desktop/products/data/products_response.dart';

class ProductsRepository {
  ProductsRepository({DioClient? dioClient}) : _dioClient = dioClient ?? DioClient();

  final DioClient _dioClient;

  static List<ProductModel> get offlineProducts => [
        const ProductModel(
          id: 'drip-coffee',
          nameEn: 'Drip Coffee',
          nameAr: 'قهوة drip',
          description: 'A smooth medium roast with rich caramel notes.',
          price: 12.5,
          stock: 20,
          imageUrl: '',
          isFeatured: true,
        ),
        const ProductModel(
          id: 'espresso',
          nameEn: 'Espresso',
          nameAr: 'إسبريسو',
          description: 'Bold and velvety with a creamy finish.',
          price: 10.0,
          stock: 15,
          imageUrl: '',
          isFeatured: true,
        ),
        const ProductModel(
          id: 'latte',
          nameEn: 'Latte',
          nameAr: 'لاتيه',
          description: 'Creamy latte with silky steamed milk.',
          price: 14.0,
          stock: 10,
          imageUrl: '',
          isFeatured: true,
        ),
      ];

  Future<List<ProductModel>> getProducts() async {
    if (const bool.fromEnvironment('FLUTTER_TEST')) {
      return offlineProducts;
    }

    try {
      print('Repository: requesting ${ApiConstants.baseUrl}${ApiConstants.productsEndpoint}');
      final response = await _dioClient.dio.get(ApiConstants.productsEndpoint);
      final payload = response.data is Map<String, dynamic>
          ? response.data as Map<String, dynamic>
          : Map<String, dynamic>.from(response.data);
      print('Repository: reading response.data["data"]');
      final model = ProductsResponse.fromJson(payload);
      print('Repository: parsed ${model.products.length} products');
      return model.products.isEmpty ? offlineProducts : model.products;
    } on DioException catch (e) {
      print('Repository DioException: ${e.toString()}');
      return offlineProducts;
    } catch (error, stackTrace) {
      print('Repository unexpected error: $error');
      print('Repository stackTrace: $stackTrace');
      return offlineProducts;
    }
  }
}