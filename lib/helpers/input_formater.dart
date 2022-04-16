import 'package:flutter/services.dart';

List<TextInputFormatter>? customInputTextFormatterWithZero = [
  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\,?\d{0,2}')),
  TextInputFormatter.withFunction(
        (oldValue, newValue) => newValue.copyWith(
      text: newValue.text.replaceAll(',', '.'),
    ),
  ),
];