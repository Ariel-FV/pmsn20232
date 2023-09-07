import 'package:flutter/material.dart';

class StyleApp{
  static ThemeData lightTheme(BuildContext context){
    final theme = ThemeData.light();
    return theme.copyWith(
      //primaryColor: Color.fromARGB(255, 255, 100, 50),
      colorScheme: Theme.of(context).colorScheme.copyWith(
        primary: Color.fromARGB(255, 255, 100, 0),
      )
    );
  }

  static ThemeData darkTheme(BuildContext context){
    final theme = ThemeData.dark();
    return theme.copyWith(
      colorScheme: Theme.of(context).colorScheme.copyWith(
        primary: Color.fromARGB(155, 100, 200, 90),
      )
    );
  }
}