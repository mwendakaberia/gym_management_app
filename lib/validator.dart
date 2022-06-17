import 'package:email_validator/email_validator.dart' as emailValidator;

class EmailValidator {
  static String? validate(String? email) {
    if (email != null && emailValidator.EmailValidator.validate(email)) {
      return null;
    }

    return 'Please enter a valid email address';
  }
}

class PasswordValidator {
  static String? validate(String? password) {
    print("hello");
    if (password == null || password.isEmpty) {
      return 'Please enter a password';
    }

    if (password.length < 6) {
      return 'Too short';
    }

    return null;
  }
}
