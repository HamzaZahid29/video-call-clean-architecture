import 'package:flutter/material.dart';

import '../theme/text_styles.dart';

class CommonElevatedButton extends StatelessWidget {
  String title;
  VoidCallback? onTap;

  CommonElevatedButton({
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
        ),
      ),
      onPressed: onTap,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(title,
            style: AppTextStyles.headlineSmall
                .copyWith(color: Colors.white)),
      ),
    );
  }
}
