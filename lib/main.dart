import 'package:flutter/material.dart';
import 'package:pmsn20232/assets/styles_app.dart';
import 'package:pmsn20232/routes.dart';
import 'package:pmsn20232/screens/login_screen.dart';
import 'assets/global_values.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: GlobalValues.flagTheme,
      builder: (context, value, _) {
        return MaterialApp(
          home: LoginScreen(),
          routes: getRoutes(),
          theme: value
          ?StyleApp.darkTheme(context)
          :StyleApp.lightTheme(context)
        );
      }
    );
  }
}
/*class MyApp extends StatefulWidget {
  MyApp({super.key, this.x});
  int? x;
  
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int contador=0;

  @override
  Widget build(BuildContext context) {
    contador=widget.x!;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        drawer: Drawer(),
        body: Center(
          child: Text('Contador de Clicks $contador', 
          style: TextStyle(fontSize: 30),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(
            Icons.mouse, 
            color: Color.fromARGB(255, 0, 255, 0),),
          onPressed: (){
            contador++;
            print(contador);
            setState(() {});
        }),
      ),
    );
  }
}*/

/*import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({super.key});

  int contador=0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Contador de Clicks $contador', 
          style: TextStyle(fontSize: 30),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(
            Icons.mouse, 
            color: Color.fromARGB(255, 0, 255, 0),),
          onPressed: (){
            contador++;
            print(contador);
        }),
      ),
    );
  }
}*/