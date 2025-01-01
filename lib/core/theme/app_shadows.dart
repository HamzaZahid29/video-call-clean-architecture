import 'package:flutter/material.dart';

class AppShadows{
  static BoxShadow customBoxShadow = BoxShadow(
    color: Colors.grey.withOpacity(0.2),
    spreadRadius: 1,
    blurRadius: 1,
    offset: const Offset(0, 1),
  );
  static BoxShadow customBoxShadow2 = BoxShadow(
    color: Colors.grey.withOpacity(0.5),
    spreadRadius: 0.5,
    blurRadius: 1,
    offset: const Offset(0, 1),
  );
}
