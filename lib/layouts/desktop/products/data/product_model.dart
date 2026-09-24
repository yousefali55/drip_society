import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel {
  final String id;
  final String nameEn;
  final String nameAr;
  final String description;
  final double price;
  // final int stock;
  final String imageUrl;
  final bool isFeatured;

  const ProductModel({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.description,
    required this.price,
    // required this.stock,
    required this.imageUrl,
    required this.isFeatured,
  });
  factory ProductModel.fromJson(Map<String,dynamic> json) =>
  _$ProductModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}