import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pmsn20232/provider/theme_provider.dart';
import 'package:pmsn20232/routes.dart';
<<<<<<< Updated upstream
import 'package:pmsn20232/screens/proyecto/dashboard_screen.dart';
import 'package:pmsn20232/screens/login_screen.dart';
import 'package:provider/provider.dart';
=======
import 'package:pmsn20232/screens/dashboard_screen.dart';
import 'package:pmsn20232/screens/onBoarding_screen.dart';
import 'package:pmsn20232/services/push_notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
>>>>>>> Stashed changes

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  final theme = sharedPreferences.getString('theme') ?? 'light';
  await Firebase.initializeApp();
  //await FirebaseHelper.setupFirebase();
  //await NotificationService.initializeNotification();
  await Firebase.initializeApp();
  await NotificacionesService().initializeApp();

/*
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('app_icon');

  final InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);

  var flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  flutterLocalNotificationsPlugin.initialize(initializationSettings);
*/
  runApp(proyectoFinal(theme: theme));
}

class proyectoFinal extends StatelessWidget {
  final String theme;
  const proyectoFinal({super.key, required this.theme});

  @override
  Widget build(BuildContext context) {
<<<<<<< Updated upstream
    GlobalValues.flagTheme.value = GlobalValues.teme.getBool('teme') ?? false;
    return ValueListenableBuilder(
      valueListenable: GlobalValues.flagTheme,
      builder: (context, value, _) {
        return ChangeNotifierProvider(
          create: (context) => TestProvider(),
          child: MaterialApp(
            home: pantalla(),
            routes: getRoutes(),
            theme: value
            ?StyleApp.darkTheme(context)
            :StyleApp.lightTheme(context)
          ),
        );
      }
    );
  }
  pantalla(){
    if(GlobalValues.session.getBool('session')==true && GlobalValues.login.getBool('login')==true){
      return DashboardScreen();
    }else{
      GlobalValues.session.setBool('session', false);
      return LoginScreen();
    }
  }
}
=======
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider(theme)),
      ],
      child: ChangeNotifierProvider(
        create: (context) => ThemeProvider(theme),
        builder: (context, snapshot) {
          return const ProyectoApp();
        },
      ),
    );
  }
}

class ProyectoApp extends StatelessWidget {
  const ProyectoApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: settings.currentTheme,
      routes: getApplicationRoutes(),
      home: FirebaseAuth.instance.currentUser == null
          ? onBoardingScreen()
          : DashboardScreen(),
    );
  }
}
>>>>>>> Stashed changes
