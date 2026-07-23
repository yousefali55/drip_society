import 'package:drip_society/features/auth/data/validation/auth_validation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AuthValidation', () {
    test('rejects empty first name', () {
      expect(AuthValidation.validateFirstName(''), 'First name is required');
    });

    test('rejects invalid email format', () {
      expect(AuthValidation.validateEmail('not-an-email'), 'Enter a valid email address');
    });

    test('accepts valid email and password', () {
      expect(AuthValidation.validateEmail('drip@example.com'), null);
      expect(AuthValidation.validatePassword('Strong123!'), null);
    });
  });
}
