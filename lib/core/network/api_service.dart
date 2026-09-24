import 'package:dio/dio.dart';
import 'package:drip_society/core/network/api_constants.dart';
import 'package:drip_society/layouts/desktop/products/data/products_response_model.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'api_service.g.dart';

@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio) = _ApiService;

  @GET(ApiConstants.products)
  Future<ProductsResponseModel> getProducts();
}
