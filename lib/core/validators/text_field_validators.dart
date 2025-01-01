class TextFieldValidators {
  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  static String? userNameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    } else if (value.contains(' ')) {
      return 'Username cannot contain empty spaces';
    }
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    } else if (value.length > 20) {
      return "Password too long";
    }
    return null;
  }

  static String? requiredFieldValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  static String? ageValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your age';
    }

    final age = int.tryParse(value);
    if (age == null) {
      return 'Age must be a valid number';
    } else if (age < 0) {
      return 'Age cannot be negative';
    } else if (age > 150) {
      return 'Please enter a realistic age';
    }
  }
}
