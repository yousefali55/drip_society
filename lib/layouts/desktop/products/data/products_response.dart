import 'product_model.dart';

class ProductsResponse {
  final bool isSuccess;
  final String message;
  final List<ProductModel> products;

  ProductsResponse({
    required this.isSuccess,
    required this.message,
    required this.products,
  });

  factory ProductsResponse.fromJson(Map<String, dynamic> json) {
    return ProductsResponse(
      isSuccess: json["isSuccess"],
      message: json["message"],
      products: (json["data"] as List)
          .map((e) => ProductModel.fromJson(e))
          .toList(),
    );
  }
}