import 'package:flutter/material.dart';
import 'package:marvel/src/core/app/styles/typography.dart';

class AppTextTheme extends ThemeExtension<AppTextTheme> {
  AppTextTheme.light({Color color = Colors.black})
      : interBlack28 = AppTextStyle.interBlack28.value.copyWith(color: color),
        interBlack32 = AppTextStyle.interBlack32.value.copyWith(color: color),
        interBold22 = AppTextStyle.interBold22.value.copyWith(color: color);

  AppTextTheme._({
    required this.interBlack28,
    required this.interBlack32,
    required this.interBold22,
  });

  AppTextTheme.base()
      : interBlack28 = AppTextStyle.interBlack28.value,
        interBlack32 = AppTextStyle.interBlack32.value,
        interBold22 = AppTextStyle.interBold22.value;

  AppTextTheme.dark({Color color = Colors.white})
      : interBlack28 = AppTextStyle.interBlack28.value.copyWith(color: color),
        interBlack32 = AppTextStyle.interBlack32.value.copyWith(color: color),
        interBold22 = AppTextStyle.interBold22.value.copyWith(color: color);

  final TextStyle interBlack28;
  final TextStyle interBlack32;
  final TextStyle interBold22;

  @override
  ThemeExtension<AppTextTheme> lerp(
    ThemeExtension<AppTextTheme>? other,
    double t,
  ) {
    if (other is! AppTextTheme) {
      return this;
    }

    return AppTextTheme._(
      interBlack28: TextStyle.lerp(interBlack28, other.interBlack28, t)!,
      interBlack32: TextStyle.lerp(interBlack32, other.interBlack32, t)!,
      interBold22: TextStyle.lerp(interBold22, other.interBold22, t)!,
    );
  }

  static AppTextTheme of(BuildContext context) {
    return Theme.of(context).extension<AppTextTheme>() ??
        _throwThemeExceptionFromFunc(context);
  }

  @override
  ThemeExtension<AppTextTheme> copyWith({
    TextStyle? regular12,
    TextStyle? medium24,
    TextStyle? medium20,
    TextStyle? bold32,
    TextStyle? medium16,
    TextStyle? medium12,
    TextStyle? regular10,
    TextStyle? regular14,
    TextStyle? medium14,
    TextStyle? semiBold20,
    TextStyle? semiBold12,
    TextStyle? semiBold28,
    TextStyle? regular24,
  }) {
    return AppTextTheme._(
      interBlack28: regular12 ?? interBlack28,
      interBlack32: medium24 ?? interBlack32,
      interBold22: bold32 ?? interBold22,
    );
  }
}

Never _throwThemeExceptionFromFunc(BuildContext context) =>
    throw Exception('$AppTextTheme не найдена в $context');
