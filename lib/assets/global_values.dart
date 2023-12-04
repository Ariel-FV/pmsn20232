import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalValues{
  static ValueNotifier<bool> flagTheme = ValueNotifier<bool>(false);
  static ValueNotifier<bool> flagTask = ValueNotifier<bool>(true);
  static ValueNotifier<bool> flagTask2 = ValueNotifier<bool>(true);
  static ValueNotifier<bool> flagPR4Profe = ValueNotifier<bool>(true);
  static ValueNotifier<bool> flagPR4Carrera = ValueNotifier<bool>(true);

  static late SharedPreferences prefs;
  static late SharedPreferences teme;
  static late SharedPreferences session;
  static late SharedPreferences login;

  static Future<void> configPrefs() async {
    prefs = await SharedPreferences.getInstance();
    teme = await SharedPreferences.getInstance();
    session = await SharedPreferences.getInstance();
    login = await SharedPreferences.getInstance();
  }
}