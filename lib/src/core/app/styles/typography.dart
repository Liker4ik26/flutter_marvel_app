import 'package:flutter/material.dart';
import 'package:marvel/src/core/app/styles/font_families.dart';

enum AppTextStyle {
  interBlack28(
    TextStyle(
      fontFamily: FontFamilies.inter,
      fontWeight: FontWeight.w800,
      fontSize: 28,
      letterSpacing: -0.33,
      color: Colors.white,
    ),
  ),
  interBlack32(
    TextStyle(
      fontFamily: FontFamilies.inter,
      fontWeight: FontWeight.w800,
      fontSize: 32,
      letterSpacing: -0.33,
      color: Colors.white,
    ),
  ),
  interBold22(
    TextStyle(
      fontFamily: FontFamilies.inter,
      fontWeight: FontWeight.w700,
      fontSize: 22,
      letterSpacing: -0.33,
      color: Colors.white,
    ),
  );

  final TextStyle value;

  const AppTextStyle(this.value);
}
