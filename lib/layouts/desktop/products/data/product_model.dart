class ProductModel {
  final String id;
  final String nameEn;
  final String nameAr;
  final String description;
  final double price;
  final int stock;
  final String imageUrl;
  final bool isFeatured;

  const ProductModel({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.description,
    required this.price,
    required this.stock,
    required this.imageUrl,
    required this.isFeatured,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id']?.toString() ?? '',
      nameEn: json['nameEn']?.toString() ?? '',
      nameAr: json['nameAr']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      stock: (json['stock'] as num?)?.toInt() ?? 0,
      imageUrl: json['imageUrl']?.toString() ?? '',
      isFeatured: json['isFeatured'] == true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nameEn': nameEn,
      'nameAr': nameAr,
      'description': description,
      'price': price,
      'stock': stock,
      'imageUrl': imageUrl,
      'isFeatured': isFeatured,
    };
  }
}