import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData light() {
    final textTheme = _getTextTheme(Brightness.light);
    final ThemeData theme = ThemeData(
        primaryColor: _primaryColor,
        textTheme: textTheme,
        primaryTextTheme: textTheme);

    return theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(secondary: _accentColor));
  }

  static ThemeData dark() {
    final textTheme = _getTextTheme(Brightness.dark);
    final ThemeData theme = ThemeData(
        primaryColor: _primaryColor,
        brightness: Brightness.dark,
        textTheme: textTheme,
        primaryTextTheme: textTheme,
        dividerTheme: _dividerTheme,
        elevatedButtonTheme: _elevatedButtonTheme);
    return theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(secondary: _accentColor));
  }

  static const _primaryColor = Colors.black;
  static const _accentColor = Colors.white;

  static const _dividerTheme = DividerThemeData(space: 0.0, indent: 16.0);

  static final _elevatedButtonTheme = ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          primary: _primaryColor, onPrimary: _accentColor));

  static TextTheme _getTextTheme(Brightness brightness) {
    final themeData = ThemeData(brightness: brightness);
    return GoogleFonts.exo2TextTheme(themeData.textTheme).copyWith(
        headline1: GoogleFonts.orbitron(),
        headline2: GoogleFonts.orbitron(),
        headline3: GoogleFonts.orbitron(),
        headline4: GoogleFonts.orbitron(),
        headline5: GoogleFonts.orbitron(),
        headline6: GoogleFonts.orbitron());
  }
}
