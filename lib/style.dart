import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum StyleColor {
  blue,
  darkBlue,
  white,
  black,
  ultraDarkBlue,
  gray,
  lightGray,
  darkGray,
  extraDarkGray,
  lightBlue,
  extraDarkBlue,
  extraLightBlue,
  ultraLightBlue,
  red,
  green,
  borderBlue
}

enum StyleText {
  //generics
  /// **[font]**: Rubik
  ///
  /// **[weight]**: 600
  ///
  /// **[size]**: 40
  headlineOneSemiBold,

  /// **[font]**: Rubik
  ///
  /// **[weight]**: 500
  ///
  /// **[size]**: 32
  headlineTwoMedium,

  /// **[font]**: Rubik
  ///
  /// **[weight]**: 500
  ///
  /// **[size]**: 24
  headlineThreeMedium,

  /// **[font]**: Rubik
  ///
  /// **[weight]**: 300
  ///
  /// **[size]**: 20
  bodyOneLight,

  /// **[font]**: Rubik
  ///
  /// **[weight]**: 400
  ///
  /// **[size]**: 18
  bodyTwoRegular,

  /// **[font]**: Rubik
  ///
  /// **[weight]**: 500
  ///
  /// **[size]**: 18
  bodyTwoMedium,

  /// **[font]**: Rubik
  ///
  /// **[weight]**: 400
  ///
  /// **[size]**: 16
  bodyThreeRegular,

  /// **[font]**: Rubik
  ///
  /// **[weight]**: 700
  ///
  /// **[size]**: 16
  bodyThreeBold,

  /// **[font]**: Rubik
  ///
  /// **[weight]**: 400
  ///
  /// **[size]**: 12
  bodyFourRegular,

  /// **[font]**: Rubik
  ///
  /// **[weight]**: 500
  ///
  /// **[size]**: 12
  ///
  /// ++[allCaps]++: true
  bodyFourMedium,

  // TODO Provjeriti s Pavom za ovaj font

  /// **[font]**: Rubik
  ///
  /// **[weight]**: 500
  ///
  /// **[size]**: 14
  bodyFiveBold,

  /// **[font]**: Rubik
  ///
  /// **[weight]**: 400
  ///
  /// **[size]**: 14
  bodyFiveRegular,
}

class Style {
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  // COLORS
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  static const colorBlue = Color(0xFF1382d3);
  static const colorDarkBlue = Color(0xFF043456);
  static const colorWhite = Color(0xFFffffff);
  static const colorBlack = Color(0xFF2d363b);
  static const colorUltraDarkBlue = Color(0xFF043456);
  static const colorGray = Color(0xFFB9BEC7);
  static const colorLightGray = Color(0xFFededee);
  static const colorDarkGray = Color(0xFF92979f);
  static const colorExtraDarkGray = Color(0xFF666b73);
  static const colorLightBlue = Color(0xFF72b3ff);
  static const colorExtraDarkBlue = Color(0xFF1c4d86);
  static const colorExtraLightBlue = Color(0xFFbadaff);
  static const colorUltraLightBlue = Color(0xFFf2f9ff);
  static const colorRed = Color(0xFFdb3434);
  static const colorGreen = Color(0xFF30a567);
  static const colorBorderBlue = Color(0xFFBADAFD);

  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  // COLORS
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  static Color getColor(BuildContext context, StyleColor styleColor) {
    // TODO: Uncomment this one day to enable dark mode.
    // bool darkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;
    bool darkMode = false;

    switch (styleColor) {
      case StyleColor.blue:
        return colorBlue;
      case StyleColor.darkBlue:
        return colorDarkBlue;
      case StyleColor.white:
        return colorWhite;
      case StyleColor.black:
        return colorBlack;
      case StyleColor.ultraDarkBlue:
        return colorUltraDarkBlue;
      case StyleColor.gray:
        return colorGray;
      case StyleColor.lightGray:
        return colorLightGray;
      case StyleColor.darkGray:
        return colorDarkGray;
      case StyleColor.extraDarkGray:
        return colorExtraDarkGray;
      case StyleColor.extraDarkBlue:
        return colorExtraDarkBlue;
      case StyleColor.lightBlue:
        return colorLightBlue;
      case StyleColor.extraLightBlue:
        return colorExtraLightBlue;
      case StyleColor.ultraLightBlue:
        return colorUltraLightBlue;
      case StyleColor.red:
        return colorRed;
      case StyleColor.green:
        return colorGreen;
      case StyleColor.borderBlue:
        return colorBorderBlue;

      default:
        throw UnimplementedError();
    }
  }

  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  // TEXT STYLES
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  static TextStyle getTextStyle(BuildContext context, StyleText styleText, [StyleColor? color, double? lineHeight]) {
    switch (styleText) {
      // HeadLine
      case StyleText.headlineOneSemiBold:
        color ??= StyleColor.black;
        return GoogleFonts.rubik(
            fontWeight: FontWeight.w600,
            fontSize: 40.0,
            height: 47.4/40,
            color: getColor(context, color)
        );
      case StyleText.headlineTwoMedium:
        color ??= StyleColor.black;
        return GoogleFonts.rubik(
            fontWeight: FontWeight.w500,
            fontSize: 32.0,
            height: 37.92/32,
            color: getColor(context, color)
        );
      case StyleText.headlineThreeMedium:
        color ??= StyleColor.black;
        return GoogleFonts.rubik(
            fontWeight: FontWeight.w500,
            fontSize: 24.0,
            height: 28.44/32,
            color: getColor(context, color)
        );

      // Body
      case StyleText.bodyOneLight:
        color ??= StyleColor.black;
        return GoogleFonts.rubik(
            fontWeight: FontWeight.w300,
            fontSize: 20.0,
            height: 26/20,
            color: getColor(context, color)
        );
      case StyleText.bodyTwoRegular:
        color ??= StyleColor.black;
        return GoogleFonts.rubik(
            fontWeight: FontWeight.w400,
            fontSize: 18.0,
            height: 21.33/18,
            color: getColor(context, color)
        );
      case StyleText.bodyTwoMedium:
        color ??= StyleColor.black;
        return GoogleFonts.rubik(
            fontWeight: FontWeight.w500,
            fontSize: 18.0,
            height: 21.33/18,
            color: getColor(context, color)
        );
      case StyleText.bodyThreeRegular:
        color ??= StyleColor.black;
        return GoogleFonts.rubik(
            fontWeight: FontWeight.w400,
            fontSize: 16.0,
            height: 18.96/16,
            color: getColor(context, color)
        );
      case StyleText.bodyThreeBold:
        color ??= StyleColor.black;
        return GoogleFonts.rubik(
            fontWeight: FontWeight.w700,
            fontSize: 16.0,
            height: 18.96/16,
            color: getColor(context, color)
        );
      case StyleText.bodyFourRegular:
        color ??= StyleColor.black;
        return GoogleFonts.rubik(
            fontWeight: FontWeight.w400,
            fontSize: 12.0,
            height: lineHeight,
            color: getColor(context, color)
        );
      case StyleText.bodyFourMedium:
        color ??= StyleColor.black;
        return GoogleFonts.rubik(
            fontWeight: FontWeight.w500,
            fontSize: 12.0,
            height: 14.22/12,
            color: getColor(context, color)
        );
      case StyleText.bodyFiveBold:
        color ??= StyleColor.black;
        return GoogleFonts.rubik(
            fontWeight: FontWeight.w500,
            fontSize: 14.0,
            height: 16.59/12,
            color: getColor(context, color)
        );
      case StyleText.bodyFiveRegular:
        color ??= StyleColor.black;
        return GoogleFonts.rubik(
            fontWeight: FontWeight.w400,
            fontSize: 14.0,
            height: 16.59/12,
            color: getColor(context, color)
        );
    }
  }
}