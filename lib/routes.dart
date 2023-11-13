import 'package:flutter/widgets.dart';
import 'package:pmsn20232/screens/calen/tareas_screen.dart';
import 'package:pmsn20232/screens/maps_screen.dart';
import 'package:pmsn20232/screens/peli/movie_list_screen.dart';
import 'package:pmsn20232/screens/register_screen.dart';
import 'package:pmsn20232/screens/add_task.dart';
import 'package:pmsn20232/screens/dashboard_screen.dart';
import 'package:pmsn20232/screens/detail_movie_screen.dart';
import 'package:pmsn20232/screens/frutas_screen.dart';
import 'package:pmsn20232/screens/login_screen.dart';
import 'package:pmsn20232/screens/onboard_screen.dart';
import 'package:pmsn20232/screens/popular_screen.dart';
import 'package:pmsn20232/screens/provider_screen.dart';
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
    '/detail': (BuildContext context) => const DetailMovieScreen(),
    '/prov': (BuildContext context) => const ProviderScreen(),
    '/register': (BuildContext context) => const RegisterScreen(),
    '/maps': (BuildContext context) => const MapsScreen(),
    '/popular2': (BuildContext context) => const MovieListVideos(),
    '/practica4': (BuildContext context) => TareasScreen(),
  };
}