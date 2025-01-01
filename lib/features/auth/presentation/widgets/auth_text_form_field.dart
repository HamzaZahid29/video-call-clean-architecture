import 'package:flutter/material.dart';

import '../../../../core/theme/text_styles.dart';
import '../../../../core/theme/theme.dart';

class AuthTextFormField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String label;
  final String? Function(String?)? formFieldValidator;
  final Widget? suffixWidget;
  final TextInputType textInputType;
  final bool readOnly;

  AuthTextFormField({
    required this.textEditingController,
    required this.label,
    required this.formFieldValidator,
    this.suffixWidget,
    this.textInputType = TextInputType.text,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: textInputType,
      validator: formFieldValidator,
      controller: textEditingController,
      readOnly: readOnly, // Use the readOnly property
      decoration: InputDecoration(
        suffixIcon: suffixWidget ?? SizedBox(),
        hintText: label,
        hintStyle: AppTextStyles.bodyMedium,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppThemes.primaryColor,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 12,
        ),
      ),
    );
  }
}
