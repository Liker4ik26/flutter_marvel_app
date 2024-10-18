import 'package:flutter/material.dart';

import 'package:marvel/src/core/app/styles/colors.dart';

@immutable
class AppColorScheme extends ThemeExtension<AppColorScheme> {
  const AppColorScheme.light()
      : backgroundColor = AppColors.lotion,
        onPrimary = AppColors.kellyGreen,
        secondary = Colors.white,
        tertiary = AppColors.queenBlue,
        onBackground = AppColors.blueMagentaViolet,
        onSecondary = AppColors.spartanCrimson,
        error = AppColors.deepCoral,
        primary = Colors.black;

  const AppColorScheme.dark()
      : backgroundColor = AppColors.charlestonGreen,
        onPrimary = AppColors.kellyGreen,
        secondary = Colors.black,
        tertiary = AppColors.queenBlue,
        onBackground = AppColors.blueMagentaViolet,
        onSecondary = AppColors.spartanCrimson,
        error = AppColors.deepCoral,
        primary = Colors.white;

  const AppColorScheme._({
    required this.backgroundColor,
    required this.onPrimary,
    required this.secondary,
    required this.tertiary,
    required this.onBackground,
    required this.onSecondary,
    required this.error,
    required this.primary,
  });

  final Color backgroundColor;
  final Color onPrimary;
  final Color secondary;
  final Color tertiary;
  final Color onBackground;
  final Color onSecondary;
  final Color error;
  final Color primary;

  @override
  ThemeExtension<AppColorScheme> copyWith({
    Color? background,
    Color? onPrimaryColor,
    Color? secondaryColor,
    Color? tertiaryColor,
    Color? onBackgroundColor,
    Color? onSecondaryColor,
    Color? errorColor,
    Color? primaryColor,
  }) {
    return AppColorScheme._(
      backgroundColor: background ?? backgroundColor,
      onPrimary: onPrimaryColor ?? onPrimary,
      secondary: secondaryColor ?? secondary,
      tertiary: tertiaryColor ?? tertiary,
      onBackground: onBackgroundColor ?? onBackground,
      onSecondary: onSecondaryColor ?? onSecondary,
      error: errorColor ?? error,
      primary: primaryColor ?? primary,
    );
  }

  @override
  ThemeExtension<AppColorScheme> lerp(
    ThemeExtension<AppColorScheme>? other,
    double t,
  ) {
    if (other is! AppColorScheme) {
      return this;
    }

    return AppColorScheme._(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      tertiary: Color.lerp(tertiary, other.tertiary, t)!,
      onBackground: Color.lerp(onBackground, other.onBackground, t)!,
      onSecondary: Color.lerp(onSecondary, other.onSecondary, t)!,
      error: Color.lerp(error, other.error, t)!,
      primary: Color.lerp(primary, other.primary, t)!,
    );
  }

  static AppColorScheme of(BuildContext context) =>
      Theme.of(context).extension<AppColorScheme>()!;
}
