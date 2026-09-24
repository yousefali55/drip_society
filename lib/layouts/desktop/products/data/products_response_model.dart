import 'package:drip_society/layouts/desktop/products/data/product_model.dart';
import 'package:json_annotation/json_annotation.dart';


part 'products_response_model.g.dart';

@JsonSerializable()
class ProductsResponseModel {
  final bool isSuccess;
  final String message;
  final List<ProductModel> data;

  ProductsResponseModel({
    required this.isSuccess,
    required this.message,
    required this.data,
  });

  factory ProductsResponseModel.fromJson(Map<String, dynamic> json) =>
  _$ProductsResponseModelFromJson(json);
  Map<String ,dynamic> toJson() => _$ProductsResponseModelToJson(this);
}