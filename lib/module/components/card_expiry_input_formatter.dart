import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class CardExpiryInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text;
    if (text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    String updatedText = '';
    for (int i = 0; i < text.length; i++) {
      if (i == 2 && !text.contains('/')) {
        updatedText += '/';
      }
      updatedText += text[i];
    }

    return newValue.copyWith(
      text: updatedText,
      selection: TextSelection.collapsed(offset: updatedText.length),
    );
  }
}