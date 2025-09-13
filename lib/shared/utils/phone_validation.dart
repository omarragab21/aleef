import 'package:flutter/material.dart';

class PhoneValidation {
  // Country-specific phone number patterns and validation rules
  static final Map<String, PhoneValidationRule> countryValidationRules = {
    '+968': PhoneValidationRule( // Oman
      minLength: 8,
      maxLength: 8,
      pattern: r'^[0-9]{8}$',
      example: '91234567',
    ),
    '+20': PhoneValidationRule( // Egypt
      minLength: 10,
      maxLength: 10,
      pattern: r'^[0-9]{10}$',
      example: '1012345678',
    ),
    '+966': PhoneValidationRule( // Saudi Arabia
      minLength: 9,
      maxLength: 9,
      pattern: r'^[0-9]{9}$',
      example: '501234567',
    ),
    '+971': PhoneValidationRule( // UAE
      minLength: 9,
      maxLength: 9,
      pattern: r'^[0-9]{9}$',
      example: '501234567',
    ),
    '+965': PhoneValidationRule( // Kuwait
      minLength: 8,
      maxLength: 8,
      pattern: r'^[0-9]{8}$',
      example: '12345678',
    ),
    '+974': PhoneValidationRule( // Qatar
      minLength: 8,
      maxLength: 8,
      pattern: r'^[0-9]{8}$',
      example: '12345678',
    ),
    '+973': PhoneValidationRule( // Bahrain
      minLength: 8,
      maxLength: 8,
      pattern: r'^[0-9]{8}$',
      example: '12345678',
    ),
    '+962': PhoneValidationRule( // Jordan
      minLength: 9,
      maxLength: 9,
      pattern: r'^[0-9]{9}$',
      example: '791234567',
    ),
    '+961': PhoneValidationRule( // Lebanon
      minLength: 8,
      maxLength: 8,
      pattern: r'^[0-9]{8}$',
      example: '12345678',
    ),
    '+963': PhoneValidationRule( // Syria
      minLength: 9,
      maxLength: 9,
      pattern: r'^[0-9]{9}$',
      example: '912345678',
    ),
    '+964': PhoneValidationRule( // Iraq
      minLength: 10,
      maxLength: 10,
      pattern: r'^[0-9]{10}$',
      example: '7912345678',
    ),
    '+967': PhoneValidationRule( // Yemen
      minLength: 9,
      maxLength: 9,
      pattern: r'^[0-9]{9}$',
      example: '712345678',
    ),
    '+970': PhoneValidationRule( // Palestine
      minLength: 9,
      maxLength: 9,
      pattern: r'^[0-9]{9}$',
      example: '591234567',
    ),
    '+218': PhoneValidationRule( // Libya
      minLength: 9,
      maxLength: 9,
      pattern: r'^[0-9]{9}$',
      example: '912345678',
    ),
    '+216': PhoneValidationRule( // Tunisia
      minLength: 8,
      maxLength: 8,
      pattern: r'^[0-9]{8}$',
      example: '12345678',
    ),
    '+213': PhoneValidationRule( // Algeria
      minLength: 9,
      maxLength: 9,
      pattern: r'^[0-9]{9}$',
      example: '612345678',
    ),
    '+212': PhoneValidationRule( // Morocco
      minLength: 9,
      maxLength: 9,
      pattern: r'^[0-9]{9}$',
      example: '612345678',
    ),
    '+249': PhoneValidationRule( // Sudan
      minLength: 9,
      maxLength: 9,
      pattern: r'^[0-9]{9}$',
      example: '912345678',
    ),
    '+252': PhoneValidationRule( // Somalia
      minLength: 8,
      maxLength: 8,
      pattern: r'^[0-9]{8}$',
      example: '12345678',
    ),
    '+253': PhoneValidationRule( // Djibouti
      minLength: 8,
      maxLength: 8,
      pattern: r'^[0-9]{8}$',
      example: '12345678',
    ),
    '+269': PhoneValidationRule( // Comoros
      minLength: 7,
      maxLength: 7,
      pattern: r'^[0-9]{7}$',
      example: '1234567',
    ),
    '+235': PhoneValidationRule( // Chad
      minLength: 8,
      maxLength: 8,
      pattern: r'^[0-9]{8}$',
      example: '12345678',
    ),
    '+227': PhoneValidationRule( // Niger
      minLength: 8,
      maxLength: 8,
      pattern: r'^[0-9]{8}$',
      example: '12345678',
    ),
    '+223': PhoneValidationRule( // Mali
      minLength: 8,
      maxLength: 8,
      pattern: r'^[0-9]{8}$',
      example: '12345678',
    ),
    '+226': PhoneValidationRule( // Burkina Faso
      minLength: 8,
      maxLength: 8,
      pattern: r'^[0-9]{8}$',
      example: '12345678',
    ),
    '+225': PhoneValidationRule( // Ivory Coast
      minLength: 10,
      maxLength: 10,
      pattern: r'^[0-9]{10}$',
      example: '0123456789',
    ),
    '+233': PhoneValidationRule( // Ghana
      minLength: 9,
      maxLength: 9,
      pattern: r'^[0-9]{9}$',
      example: '201234567',
    ),
    '+228': PhoneValidationRule( // Togo
      minLength: 8,
      maxLength: 8,
      pattern: r'^[0-9]{8}$',
      example: '12345678',
    ),
    '+229': PhoneValidationRule( // Benin
      minLength: 8,
      maxLength: 8,
      pattern: r'^[0-9]{8}$',
      example: '12345678',
    ),
    '+234': PhoneValidationRule( // Nigeria
      minLength: 10,
      maxLength: 11,
      pattern: r'^[0-9]{10,11}$',
      example: '8012345678',
    ),
  };

  /// Validates a phone number based on country code
  static PhoneValidationResult validatePhoneNumber(String phoneNumber, String countryCode) {
    // Remove all non-digit characters
    final cleanNumber = phoneNumber.replaceAll(RegExp(r'[^0-9]'), '');
    
    // Get validation rules for the country
    final rules = countryValidationRules[countryCode];
    if (rules == null) {
      return PhoneValidationResult(
        isValid: false,
        errorMessage: 'Unsupported country code',
        suggestion: 'Please select a supported country',
      );
    }

    // Check if empty
    if (cleanNumber.isEmpty) {
      return PhoneValidationResult(
        isValid: false,
        errorMessage: 'Phone number is required',
        suggestion: 'Please enter your phone number',
      );
    }

    // Check length
    if (cleanNumber.length < rules.minLength) {
      return PhoneValidationResult(
        isValid: false,
        errorMessage: 'Phone number is too short',
        suggestion: 'Phone number should be at least ${rules.minLength} digits',
      );
    }

    if (cleanNumber.length > rules.maxLength) {
      return PhoneValidationResult(
        isValid: false,
        errorMessage: 'Phone number is too long',
        suggestion: 'Phone number should be at most ${rules.maxLength} digits',
      );
    }

    // Check pattern
    if (!RegExp(rules.pattern).hasMatch(cleanNumber)) {
      return PhoneValidationResult(
        isValid: false,
        errorMessage: 'Invalid phone number format',
        suggestion: 'Example: ${rules.example}',
      );
    }

    // Check if it's a valid mobile number (not starting with 0 for most countries)
    if (cleanNumber.startsWith('0') && countryCode != '+225' && countryCode != '+234') {
      return PhoneValidationResult(
        isValid: false,
        errorMessage: 'Invalid mobile number format',
        suggestion: 'Remove the leading 0',
      );
    }

    return PhoneValidationResult(
      isValid: true,
      errorMessage: null,
      suggestion: null,
    );
  }

  /// Formats a phone number for display
  static String formatPhoneNumber(String phoneNumber, String countryCode) {
    final cleanNumber = phoneNumber.replaceAll(RegExp(r'[^0-9]'), '');
    
    if (cleanNumber.isEmpty) return '';
    
    switch (countryCode) {
      case '+968': // Oman
        if (cleanNumber.length == 8) {
          return '${cleanNumber.substring(0, 4)} ${cleanNumber.substring(4)}';
        }
        break;
      case '+20': // Egypt
        if (cleanNumber.length == 10) {
          return '${cleanNumber.substring(0, 3)} ${cleanNumber.substring(3, 6)} ${cleanNumber.substring(6)}';
        }
        break;
      case '+966': // Saudi Arabia
        if (cleanNumber.length == 9) {
          return '${cleanNumber.substring(0, 2)} ${cleanNumber.substring(2, 5)} ${cleanNumber.substring(5)}';
        }
        break;
      case '+971': // UAE
        if (cleanNumber.length == 9) {
          return '${cleanNumber.substring(0, 2)} ${cleanNumber.substring(2, 5)} ${cleanNumber.substring(5)}';
        }
        break;
      case '+234': // Nigeria
        if (cleanNumber.length == 11) {
          return '${cleanNumber.substring(0, 4)} ${cleanNumber.substring(4, 7)} ${cleanNumber.substring(7)}';
        } else if (cleanNumber.length == 10) {
          return '${cleanNumber.substring(0, 3)} ${cleanNumber.substring(3, 6)} ${cleanNumber.substring(6)}';
        }
        break;
      default:
        // Default formatting for other countries
        if (cleanNumber.length >= 8) {
          final midPoint = (cleanNumber.length / 2).round();
          return '${cleanNumber.substring(0, midPoint)} ${cleanNumber.substring(midPoint)}';
        }
    }
    
    return cleanNumber;
  }

  /// Gets the complete phone number with country code
  static String getCompletePhoneNumber(String phoneNumber, String countryCode) {
    final cleanNumber = phoneNumber.replaceAll(RegExp(r'[^0-9]'), '');
    return '$countryCode$cleanNumber';
  }

  /// Checks if a phone number is a valid mobile number
  static bool isMobileNumber(String phoneNumber, String countryCode) {
    final cleanNumber = phoneNumber.replaceAll(RegExp(r'[^0-9]'), '');
    
    if (cleanNumber.isEmpty) return false;
    
    // Mobile number prefixes for different countries
    final mobilePrefixes = {
      '+968': ['9'], // Oman
      '+20': ['10', '11', '12', '15'], // Egypt
      '+966': ['50', '51', '53', '54', '55', '56', '57', '58', '59'], // Saudi Arabia
      '+971': ['50', '51', '52', '54', '55', '56'], // UAE
      '+965': ['5', '6', '9'], // Kuwait
      '+974': ['3', '5', '6', '7'], // Qatar
      '+973': ['3', '6', '7'], // Bahrain
      '+962': ['7'], // Jordan
      '+961': ['3', '7'], // Lebanon
      '+963': ['9'], // Syria
      '+964': ['7'], // Iraq
      '+967': ['7'], // Yemen
      '+970': ['5'], // Palestine
      '+218': ['9'], // Libya
      '+216': ['2', '3', '4', '5', '9'], // Tunisia
      '+213': ['5', '6', '7'], // Algeria
      '+212': ['6', '7'], // Morocco
      '+249': ['9'], // Sudan
      '+252': ['6', '7'], // Somalia
      '+253': ['7'], // Djibouti
      '+269': ['3'], // Comoros
      '+235': ['6', '7', '9'], // Chad
      '+227': ['9'], // Niger
      '+223': ['6', '7'], // Mali
      '+226': ['6', '7'], // Burkina Faso
      '+225': ['0'], // Ivory Coast
      '+233': ['2', '3', '5', '6'], // Ghana
      '+228': ['9'], // Togo
      '+229': ['6', '9'], // Benin
      '+234': ['70', '71', '80', '81', '90', '91'], // Nigeria
    };
    
    final prefixes = mobilePrefixes[countryCode];
    if (prefixes == null) return true; // Assume valid if no specific rules
    
    return prefixes.any((prefix) => cleanNumber.startsWith(prefix));
  }
}

class PhoneValidationRule {
  final int minLength;
  final int maxLength;
  final String pattern;
  final String example;

  PhoneValidationRule({
    required this.minLength,
    required this.maxLength,
    required this.pattern,
    required this.example,
  });
}

class PhoneValidationResult {
  final bool isValid;
  final String? errorMessage;
  final String? suggestion;

  PhoneValidationResult({
    required this.isValid,
    this.errorMessage,
    this.suggestion,
  });
}


