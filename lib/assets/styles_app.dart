import 'package:flutter/material.dart';

class StyleApp{
  static ThemeData lightTheme(BuildContext context){
    final theme = ThemeData.light();
    return theme.copyWith(
      //primaryColor: Color.fromARGB(255, 255, 100, 50),
      colorScheme: Theme.of(context).colorScheme.copyWith(
        primary: Color.fromARGB(255, 194, 47, 235),
      ),
      iconTheme: IconThemeData(
        color: Color.fromARGB(255, 194, 47, 235),
      ),
    );
  }

  static ThemeData darkTheme(BuildContext context){
    final theme = ThemeData.dark();
    return theme.copyWith(
      colorScheme: Theme.of(context).colorScheme.copyWith(
        primary: Color.fromARGB(238, 0, 214, 11),
        
      ),
      iconTheme: IconThemeData(
        color: Color.fromARGB(238, 0, 214, 11),
      ),
      /*cardTheme: CardTheme(
        color: Color.fromARGB(236, 111, 37, 214),
      ),*/
    );
  }
}