class ValidationUtils {
  // Email validation
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }

    // Regular expression for email validation
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(value.trim())) {
      return 'Please enter a valid email address';
    }

    return null; // Valid email
  }

  // Phone number validation
  static String? validatePhoneNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    }

    // Remove any spaces, dashes, or other non-digit characters for validation
    final cleanedValue = value.replaceAll(RegExp(r'[^\d]'), '');

    if (cleanedValue.isEmpty) {
      return 'Phone number must contain only numbers';
    }

    // Check if it contains only digits (you can adjust this based on your requirements)
    if (cleanedValue.length < 7 || cleanedValue.length > 15) {
      return 'Phone number must be between 7 and 15 digits';
    }

    return null; // Valid phone number
  }

  // Generic required field validation
  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  // Password validation (for future use)
  static String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Password is required';
    }

    if (value.length < 5) {
      return 'Password must cannot be less than 5 numbers';
    }
    if (value.length > 5) {
      return 'Password must cannot be more than 5 numbers';
    }

    return null;
  }

  // Custom validation that combines multiple validators
  static String? Function(String?) combineValidators(
    List<String? Function(String?)> validators,
  ) {
    return (String? value) {
      for (final validator in validators) {
        final result = validator(value);
        if (result != null) {
          return result;
        }
      }
      return null;
    };
  }
}
