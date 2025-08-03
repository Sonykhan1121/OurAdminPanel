import '../constants/app_texts.dart';
import 'package:intl/intl.dart';

class DValidation {
  DValidation._();

  /// Customize the date format as needed
  static String formatDate(DateTime? date) {
    date ??= DateTime.now();
    return DateFormat('dd-MMM-yyyy').format(date);
  }

  /// Empty Text Validation
  String? validateEmptyText(String? fieldName, String? value) {
    if (value == null || value.isEmpty) return '$fieldName ${AppTexts.userNameInput}';
    return null;
  }

  /// Email validation
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return AppTexts.emailRequired;

    final emailRegExp = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegExp.hasMatch(value)) return AppTexts.enterValidEmail;

    return null;
  }

  /// Password validation
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return AppTexts.enterPassword;

    if (value.length < 8) return AppTexts.enterValidPassword;

    // check for uppercase letters
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return AppTexts.passwordUppercase;
    }

    // check for number
    if (!value.contains(RegExp(r'[0-9]'))) {
      return AppTexts.passwordNumber;
    }

    // check for special number
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return AppTexts.passwordSpecial;
    }

    return null;
  }

  /// confirm password verification
  String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return AppTexts.confirmPassword;
    }
    if (value != password) {
      return AppTexts.passwordNotMatch;
    }
    return null;
  }

  /// Phone number validation 11 digit for bd
  static String? validationPhoneNumberBd(String? value) {
    if (value == null || value.isEmpty) return AppTexts.phoneRequired;

    final phoneRegExp = RegExp(r'^(?:\+8801|8801|01)?\d{9}$');

    if (!phoneRegExp.hasMatch(value)) {
      return AppTexts.phoneInvalid;
    }

    return null;
  }

  /// international phone number validation
  static String internationalFormatPhoneNumber(String phoneNumber) {
    // Remove any non-digit characters from the phone number
    var digitsOnly = phoneNumber.replaceAll(RegExp(r'\D'), '');

    // Extract the country code from the digitsOnly
    String countryCode = '+${digitsOnly.substring(0, 2)}';
    digitsOnly = digitsOnly.substring(2);

    // Add the remaining digits with proper formatting
    final formattedNumber = StringBuffer();
    formattedNumber.write('($countryCode) ');

    int i = 0;
    while (i < digitsOnly.length) {
      int groupLength = 2;
      if (i == 0 && countryCode == '+1') {
        groupLength = 3;
      }

      int end = i + groupLength;
      formattedNumber.write(digitsOnly.substring(i, end));

      if (end < digitsOnly.length) {
        formattedNumber.write(' ');
      }
      i = end;
    }

    return formattedNumber.toString();
  }
}