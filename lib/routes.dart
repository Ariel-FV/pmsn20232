import 'package:flutter/widgets.dart';
import 'package:pmsn20232/screens/dashboard_screen.dart';
import 'package:pmsn20232/screens/frutas_screen.dart';
import 'package:pmsn20232/screens/login_screen.dart';
import 'package:pmsn20232/screens/onboard_screen.dart';

Map<String,WidgetBuilder> getRoutes(){
  return{
    '/dash' : (BuildContext contex) => DashboardScreen(),
    '/frutas' : (BuildContext contex) => FrutasScreen(),
    '/knows': (BuildContext contex) => OnBoardScreen(),
    '/login': (BuildContext context) => LoginScreen(),
  };
}