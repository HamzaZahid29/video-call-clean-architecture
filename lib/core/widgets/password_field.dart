import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../init_dependencies.dart';
import '../common/bloc/password_visibility/password_visibility_cubit.dart';
import '../theme/text_styles.dart';
import '../theme/theme.dart';

class PasswordField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String label;
  final String? Function(String?)? formFieldValidator;

  const PasswordField({
    required this.textEditingController,
    required this.label,
    required this.formFieldValidator,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLocator<PasswordVisibilityCubit>(),
      child: BlocBuilder<PasswordVisibilityCubit, bool>(
        builder: (context, isPasswordVisible) {
          return TextFormField(
            controller: textEditingController,
            validator: formFieldValidator,
            obscureText: !isPasswordVisible,
            decoration: InputDecoration(
              hintText: label,
              hintStyle: AppTextStyles.bodyMedium,
              suffixIcon: IconButton(
                icon: isPasswordVisible
                    ? HugeIcon(
                        icon: HugeIcons.strokeRoundedView, color: Colors.grey)
                    : HugeIcon(
                        icon: HugeIcons.strokeRoundedViewOff,
                        color: Colors.grey),
                onPressed: () {
                  context.read<PasswordVisibilityCubit>().toggleVisibility();
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
        },
      ),
    );
  }
}
