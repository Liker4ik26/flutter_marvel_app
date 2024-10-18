import 'package:flutter/material.dart';
import 'package:marvel/src/core/app/styles/color_extensions.dart';
import 'package:marvel/src/core/app/styles/text_extensions.dart';

abstract class AppThemes {
  const AppThemes._();

  static final dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    extensions: <ThemeExtension<dynamic>>[
      _darkColorScheme,
      _darkTextTheme,
    ],
    appBarTheme: const AppBarTheme(
      centerTitle: false,
      elevation: 0,
      scrolledUnderElevation: 0,
    ),
    indicatorColor: _darkColorScheme.primary,
  );

  static final light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    extensions: <ThemeExtension<dynamic>>[
      _lightColorScheme,
      _lightTextTheme,
    ],
    appBarTheme: const AppBarTheme(
      centerTitle: false,
      elevation: 0,
      scrolledUnderElevation: 0,
    ),
    indicatorColor: _lightColorScheme.primary,
  );

  static const _lightColorScheme = AppColorScheme.light();
  static const _darkColorScheme = AppColorScheme.dark();
  static final _lightTextTheme = AppTextTheme.light();
  static final _darkTextTheme = AppTextTheme.dark();
}
