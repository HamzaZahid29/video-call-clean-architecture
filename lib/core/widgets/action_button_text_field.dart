import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';

import '../common/bloc/password_visibility/password_visibility_cubit.dart';
import '../theme/text_styles.dart';
import '../theme/theme.dart';

class ActionButtonTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String label;
  final String? Function(String?)? formFieldValidator;
  final VoidCallback onTap;

  const ActionButtonTextField({
    required this.textEditingController,
    required this.label,
    required this.formFieldValidator,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
          return TextFormField(
            controller: textEditingController,
            validator: formFieldValidator,
            decoration: InputDecoration(
              hintText: label,
              hintStyle: AppTextStyles.bodyMedium,
              suffixIcon: IconButton(
                icon:HugeIcon(
                    icon: HugeIcons.strokeRoundedCheckmarkSquare01,
                    color: AppThemes.primaryColor),
                onPressed:() {
                  final error = formFieldValidator?.call(textEditingController.text);

                  if (error == null) {
                    onTap();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(error)),
                    );
                  }
                },
              ),
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
