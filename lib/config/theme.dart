import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
    primarySwatch: Colors.blue,
    appBarTheme: const AppBarTheme(
      elevation: 0,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      elevation: 0,
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
    ),
    inputDecorationTheme: InputDecorationTheme(
      isDense: true,
      filled: true,
      errorMaxLines: 0,
      helperMaxLines: 0,
      fillColor: Colors.white,
      alignLabelWithHint: true,
      border: outlineInputBorder(Colors.white),
      enabledBorder: outlineInputBorder(Colors.white),
      focusedBorder: outlineInputBorder(Colors.white),
      focusedErrorBorder: outlineInputBorder(Colors.red),
      disabledBorder: outlineInputBorder(Colors.grey),
      errorBorder: outlineInputBorder(Colors.red.shade500),
      labelStyle: textStyle(Colors.black54),
      hintStyle: textStyle(Colors.black),
      errorStyle: textStyle(Colors.red),
      helperStyle: textStyle(Colors.black),
      contentPadding: const EdgeInsets.all(12),
    )
  );
}

TextStyle textStyle(Color color) {
  return TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    letterSpacing: .5,
    color: color,
  );
}

OutlineInputBorder outlineInputBorder(Color color) {
  return OutlineInputBorder(
    borderSide: BorderSide(
      width: 1,
      color: color,
    ),
    borderRadius: const BorderRadius.all(Radius.circular(8)),
  );
}
