import 'package:flutter/material.dart';
import 'color_scheme.dart';

final ThemeData themeData = ThemeData(
  colorScheme: colorScheme,
  // Customize additional theme properties if needed
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: colorScheme.primary, // Background color
      foregroundColor: colorScheme.secondary, // Text color
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: colorScheme.secondary, // Text color
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: colorScheme.secondary, // Text color
      side: BorderSide(color: colorScheme.background), // Border color
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: colorScheme.background,
    foregroundColor: colorScheme.primary,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: colorScheme.background,
    foregroundColor: colorScheme.primary,
  ),
);
