import 'package:flutter_test/flutter_test.dart';
import 'package:drip_society/layouts/desktop/products/data/product_model.dart';

void main() {
  group('ProductModel.fromJson', () {
    test('parses the current API payload without runtime errors', () {
      final json = {
        'id': 'p1',
        'nameEn': 'Arabica Beans',
        'nameAr': 'حبوب عربية',
        'description': 'Premium roasted beans',
        'price': 400,
        'stock': 10,
        'imageUrl': 'https://example.com/image.jpg',
        'isFeatured': true,
      };

      final product = ProductModel.fromJson(json);

      expect(product.id, 'p1');
      expect(product.nameEn, 'Arabica Beans');
      expect(product.nameAr, 'حبوب عربية');
      expect(product.description, 'Premium roasted beans');
      expect(product.price, 400.0);
      expect(product.stock, 10);
      expect(product.imageUrl, 'https://example.com/image.jpg');
      expect(product.isFeatured, isTrue);
    });
  });
}
