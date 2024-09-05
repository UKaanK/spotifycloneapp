import 'package:flutter/material.dart';

extension DarkMode on BuildContext{
  bool get isDarkmode{
    return Theme.of(this).brightness==Brightness.dark;
  }
}