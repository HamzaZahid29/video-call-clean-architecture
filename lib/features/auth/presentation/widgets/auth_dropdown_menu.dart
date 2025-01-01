import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/theme/text_styles.dart';
import '../../../../core/theme/theme.dart';

class AuthDropdownMenu<T> extends StatelessWidget {
  final List<DropdownMenuItem<T>> items;
  final T? value;
  final String label;
  final ValueChanged<T?>? onChanged; // `null` indicates the disabled state.
  final String? Function(T?)? formFieldValidator;

  const AuthDropdownMenu({
    required this.items,
    required this.label,
    this.value,
    this.onChanged,
    this.formFieldValidator,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isEnabled = onChanged != null;

    return DropdownButtonFormField<T>(
      value: value,
      items: items,
      onChanged: isEnabled ? onChanged : null, // Disabled if `onChanged` is null.
      validator: formFieldValidator,
      decoration: InputDecoration(
        hintText: label,
        hintStyle: AppTextStyles.bodyMedium.copyWith(
          color: isEnabled ? Colors.black : Colors.grey, // Hint text color for disabled state.
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: isEnabled
            ? OutlineInputBorder(
          borderSide: BorderSide(
            color: AppThemes.primaryColor,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        )
            : OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey, // Border color for disabled state.
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 12,
        ),
        filled: true,
        fillColor: isEnabled ? Colors.white : Colors.grey[200], // Background color for disabled state.
      ),
      style: AppTextStyles.bodyMedium.copyWith(
        color: isEnabled ? Colors.black : Colors.grey, // Text color for disabled state.
      ),
      dropdownColor: isEnabled ? Colors.white : Colors.grey[100], // Dropdown color for disabled state.
    );
  }
}
