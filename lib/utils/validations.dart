import 'package:flutter/material.dart';

class Validations{

  // Valid if we get a well-formed and non-empty email address
  static String? _validateEmail(String email) {
    // 1
    RegExp regex = RegExp(r'\w+@\w+\.\w+');
    FocusNode _emailFocusNode = FocusNode();
    // Add the following line to set focus to the email field
    if (email.isEmpty || !regex.hasMatch(email)) _emailFocusNode.requestFocus();
    // 2
    if (email.isEmpty)
      return 'We need an email address';
    else if (!regex.hasMatch(email))
      // 3
      return "That doesn't look like an email address";
    else
      // 4
      return null;
  }

  static String? _validatePassword(String pass1) {
    RegExp hasUpper = RegExp(r'[A-Z]');
    RegExp hasLower = RegExp(r'[a-z]');
    RegExp hasDigit = RegExp(r'\d');
    RegExp hasPunct = RegExp(r'[_!@#\$&*~-]');
    if (!RegExp(r'.{8,}').hasMatch(pass1))
      return 'Passwords must have at least 8 characters';
    if (!hasUpper.hasMatch(pass1))
      return 'Passwords must have at least one uppercase character';
    if (!hasLower.hasMatch(pass1))
      return 'Passwords must have at least one lowercase character';
    if (!hasDigit.hasMatch(pass1))
      return 'Passwords must have at least one number';
    if (!hasPunct.hasMatch(pass1))
      return 'Passwords need at least one special character like !@#\$&*~-';
    return null;
  }

  static String? isValidPhoneNumber(String string) {
    // Null or empty string is invalid phone number
    if (string == null || string.isEmpty) {
      return 'Please enter mobile no.';
    }

    // You may need to change this pattern to fit your requirement.
    // I just copied the pattern from here: https://regexr.com/3c53v
    const pattern = r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$';
    final regExp = RegExp(pattern);

    if (!regExp.hasMatch(string)) {
      return "That doesn't look like an mobile no.";
    }
    return null;
  }

}