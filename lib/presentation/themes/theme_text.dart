import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/presentation/themes/theme_color.dart';

import '../../common/constants/size_constants.dart';

class ThemeText {
  const ThemeText._();

  static TextTheme get _poppinsTextTheme => GoogleFonts.poppinsTextTheme();

  static TextStyle get _whiteHeadLine6 =>
      _poppinsTextTheme.titleLarge?.copyWith(
        fontSize: Sizes.dimen_20.sp,
        color: Colors.white,
      ) ??
      const TextStyle();

  static TextStyle get _whiteHeadLine5 =>
      _poppinsTextTheme.headlineSmall?.copyWith(
        fontSize: Sizes.dimen_24.sp,
        color: Colors.white,
      ) ??
      const TextStyle();

  static TextStyle get whiteSubtitle1 =>
      _poppinsTextTheme.titleMedium?.copyWith(
        fontSize: Sizes.dimen_16.sp,
        color: Colors.white,
      ) ??
      const TextStyle();

  static TextStyle get whiteButton =>
      _poppinsTextTheme.bodyMedium?.copyWith(
        fontSize: Sizes.dimen_14.sp,
        color: Colors.white,
      ) ??
      const TextStyle();

  static TextStyle get whiteBodyText2 =>
      _poppinsTextTheme.bodyMedium?.copyWith(
        fontSize: Sizes.dimen_14.sp,
        color: Colors.white,
        wordSpacing: 0.25,
        height: 1.5,
      ) ??
      const TextStyle();

  static TextStyle get _vulcanHeadline6 =>
      _whiteHeadLine6?.copyWith(
        color: AppColor.vulcan,
      ) ??
      const TextStyle();

  static TextStyle get _vulcanHeadline5 =>
      _whiteHeadLine5?.copyWith(
        color: AppColor.vulcan,
      ) ??
      const TextStyle();

  static TextStyle get _vulcanSubtitle1 =>
      whiteSubtitle1?.copyWith(
        color: AppColor.vulcan,
      ) ??
      const TextStyle();

  static TextStyle get _vulcanBodyText2 =>
      whiteBodyText2?.copyWith(
        color: AppColor.vulcan,
      ) ??
      const TextStyle();

  static TextTheme getTextTheme() => TextTheme(
        headlineSmall: _whiteHeadLine5,
        titleLarge: _whiteHeadLine6,
        titleMedium: whiteSubtitle1,
        bodyMedium: whiteBodyText2,
      );

  static TextTheme getLightTextTheme() => TextTheme(
        headlineSmall: _vulcanHeadline5,
        titleLarge: _vulcanHeadline6,
        titleMedium: _vulcanSubtitle1,
        bodyMedium: _vulcanBodyText2,
      );
}

extension ThemeTextExtension on TextTheme {
  TextStyle get royalBlueSubtitle1 =>
      titleMedium?.copyWith(
        color: AppColor.royalBlue,
        fontWeight: FontWeight.w600,
      ) ??
      const TextStyle();

  TextStyle get greySubtitle1 =>
      titleMedium?.copyWith(color: Colors.grey) ?? const TextStyle();

  TextStyle get violetHeadline6 =>
      titleMedium?.copyWith(
        color: AppColor.violet,
      ) ??
      const TextStyle();

  TextStyle get vulcanBodyText2 =>
      bodyMedium?.copyWith(
        color: AppColor.vulcan,
        fontWeight: FontWeight.w600,
      ) ??
      const TextStyle();

  TextStyle get greyCaption =>
      bodySmall?.copyWith(
        color: Colors.grey,
      ) ??
      const TextStyle();

  TextStyle get whiteBodyText2 =>
      vulcanBodyText2?.copyWith(
        color: Colors.white,
      ) ??
      const TextStyle();

  TextStyle get orangeSubtitle1 =>
      titleMedium?.copyWith(
        color: Colors.orangeAccent,
      ) ??
      const TextStyle();
}
