class AuthValidation {
  const AuthValidation._();

  static final RegExp _uppercaseRegex = RegExp(r'[A-Z]');
  static final RegExp _lowercaseRegex = RegExp(r'[a-z]');
  static final RegExp _numberRegex = RegExp(r'\d');
  static final RegExp _specialCharacterRegex = RegExp(
    r'''[!@#$%^&*()_+\-=[\]{}|;:'",.<>?/]''',
  );

  static String? validateFirstName(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) {
      return 'First name is required';
    }
    if (text.length < 2) {
      return 'First name must be at least 2 characters';
    }
    return null;
  }

  static String? validateLastName(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) {
      return 'Last name is required';
    }
    if (text.length < 2) {
      return 'Last name must be at least 2 characters';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) {
      return 'Email is required';
    }
    final regex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!regex.hasMatch(text)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  static String? validatePhone(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) {
      return 'Phone number is required';
    }
    if (text.length < 8) {
      return 'Phone number must be at least 8 digits';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    final text = value ?? '';
    if (text.isEmpty) {
      return 'Password is required';
    }

    final missingRules = <String>[];

    if (text.length < 6) {
      missingRules.add('- 6 characters');
    }
    if (!_uppercaseRegex.hasMatch(text)) {
      missingRules.add('- One uppercase letter');
    }
    if (!_lowercaseRegex.hasMatch(text)) {
      missingRules.add('- One lowercase letter');
    }
    if (!_numberRegex.hasMatch(text)) {
      missingRules.add('- One number');
    }
    if (!_specialCharacterRegex.hasMatch(text)) {
      missingRules.add('- One special character');
    }

    if (missingRules.isNotEmpty) {
      return 'Password must contain at least:\n${missingRules.join('\n')}';
    }

    return null;
  }

  static String? validateCity(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) {
      return 'Please select your governorate.';
    }
    return null;
  }
}
