import 'package:flutter/material.dart';

import '../theme/text_styles.dart';

class CommonValuePicker extends StatelessWidget {
  VoidCallback onTap;
  String? value;
  String hint;
  IconData iconData;

  CommonValuePicker(
      {required this.onTap,
      required this.value,
      required this.iconData,
      required this.hint});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    width: 1.0,
                  )),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 12,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    value != null
                        ? Text(
                            value!,
                            style: AppTextStyles.bodyMedium
                                .copyWith(color: Colors.grey),
                          )
                        : Text(
                            hint,
                            style: AppTextStyles.bodyMedium
                                .copyWith(color: Colors.grey),
                          ),
                    Icon(
                      iconData,
                      color: Colors.grey,
                      size: 20.0,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
