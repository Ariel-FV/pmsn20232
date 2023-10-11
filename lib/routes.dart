import 'package:flutter/widgets.dart';
import 'package:pmsn20232/screens/add_task.dart';
import 'package:pmsn20232/screens/dashboard_screen.dart';
import 'package:pmsn20232/screens/frutas_screen.dart';
import 'package:pmsn20232/screens/login_screen.dart';
import 'package:pmsn20232/screens/onboard_screen.dart';
import 'package:pmsn20232/screens/popular_screen.dart';
import 'package:pmsn20232/screens/task_screen.dart';

Map<String,WidgetBuilder> getRoutes(){
  return{
    '/dash' : (BuildContext contex) => DashboardScreen(),
    '/frutas' : (BuildContext contex) => const FrutasScreen(),
    '/knows': (BuildContext contex) => const OnBoardScreen(),
    '/login': (BuildContext context) => const LoginScreen(),
    '/task': (BuildContext context) => const TaskScreen(),
    '/add': (BuildContext context) => AddTask(),
    '/popular': (BuildContext context) => const PopularScreen(),
  };
}