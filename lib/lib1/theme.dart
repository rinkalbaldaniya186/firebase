import 'package:flutter/material.dart';

ThemeData appTheme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primarySwatch: Colors.amber,
    elevatedButtonTheme: elevatedButtonTheme(),
    fontFamily: 'Mulish',
    textButtonTheme: textButtonTheme(),
    textTheme: textTheme(),
    inputDecorationTheme: inputDecorationTheme(),
    appBarTheme: appBarTheme()
  );
}

appBarTheme() {
  return AppBarTheme(
    elevation: 0,
    color: Colors.white,
    centerTitle: true,
    iconTheme: IconThemeData(color: Colors.black),
  );
}

inputDecorationTheme() {

  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(28),
    borderSide: BorderSide(color: Colors.grey),
    gapPadding: 10
  );


  return InputDecorationTheme(
    border: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    enabledBorder: outlineInputBorder,
  );
}

textTheme() {
  return TextTheme(
    bodyMedium: TextStyle(color: Colors.black, fontSize: 16),
  );
}

textButtonTheme() {
  return TextButtonThemeData(
    style: ButtonStyle(
      padding: MaterialStateProperty.all(
        EdgeInsets.symmetric(horizontal: 16),
      ),
      textStyle: MaterialStateProperty.all(
        TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      backgroundColor: MaterialStateProperty.all(Colors.white),
      foregroundColor: MaterialStateProperty.all(Colors.amber.shade600),
    ),
  );
}

elevatedButtonTheme() {
  return ElevatedButtonThemeData(
    style: ButtonStyle(
      padding: MaterialStateProperty.all(
        EdgeInsets.symmetric(horizontal: 30),
      ),
      foregroundColor: MaterialStateProperty.all(Colors.white),
      backgroundColor: MaterialStateProperty.all(Colors.pink),
    ),
  );
}
