class ValidationRules {
  static String? email(String? text) {
    if (text == null || text.isEmpty) {
      return 'Please enter your text here';
    } else if (!text.contains('@')) {
      return 'Enter a valid email';
    } else {
      return null;
    }
  }

  static String? password(String? text) {
    if (text == null || text.isEmpty) {
      return 'Please enter your text here';
    } else if (text.length < 8) {
      return 'Enter at least 8 characters';
    } else {
      return null;
    }
  }

    static String? money(String? text) {
    if (text == null || text.isEmpty) {
      return 'Please enter your text here';
    } else if (int.tryParse(text) == null) {
      return 'Enter a valid numbers';
    } else {
      return null;
    }
  }

  static String? regular(String? text) {
    if (text == null || text.isEmpty) {
      return 'Please enter your text here';
    } {
      return null;
    }
  }
}
