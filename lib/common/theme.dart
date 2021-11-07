import 'package:emergency_notifier/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final lightThemeData = ThemeData(
  brightness: Brightness.light,
  primaryColor: primaryColor,
  textTheme: GoogleFonts.poppinsTextTheme(ThemeData.light().textTheme),
  elevatedButtonTheme: elevatedButtonThemeData,
  outlinedButtonTheme: outlineButtonThemeData,
  inputDecorationTheme: inputDecorationThemeDataLight,
  iconTheme: iconThemeDataLight,
);

final darkThemeData = ThemeData(
  brightness: Brightness.dark,
  primaryColor: primaryColor,
  colorScheme: ThemeData.dark().colorScheme.copyWith(
        secondary: secondaryColorDarkTheme,
        onSecondary: secondaryColorDarkTheme,
      ),
  scaffoldBackgroundColor: backgroundColorDarkTheme,
  elevatedButtonTheme: elevatedButtonThemeData,
  inputDecorationTheme: inputDecorationThemeDataDark,
  textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
  iconTheme: iconThemeDataDark,
);

final inputDecorationThemeDataDark = InputDecorationTheme(
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(
      color: secondaryColorDarkTheme,
      width: 2,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(
      color: Colors.white,
      width: 2,
    ),
  ),
  labelStyle: const TextStyle(
    color: secondaryTextColorDarkTheme,
  ),
);

final inputDecorationThemeDataLight = InputDecorationTheme(
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(
      color: secondaryColorDarkTheme,
      width: 2,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(
      color: primaryColor,
      width: 2,
    ),
  ),
  labelStyle: const TextStyle(
    color: secondaryTextColorDarkTheme,
  ),
);

final elevatedButtonThemeData = ElevatedButtonThemeData(
  style: TextButton.styleFrom(
    backgroundColor: primaryColor,
    elevation: 0,
    padding: const EdgeInsets.all(defaultPadding),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(defaultBorderRadius),
      ),
    ),
  ),
);

final outlineButtonThemeData = OutlinedButtonThemeData(
  style: TextButton.styleFrom(
    backgroundColor: Colors.white,
    padding: const EdgeInsets.all(defaultPadding),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(defaultBorderRadius),
      ),
    ),
  ),
);

const iconThemeDataLight = IconThemeData(
  color: primaryColor,
);

const iconThemeDataDark = IconThemeData(
  color: secondaryTextColorDarkTheme,
);
