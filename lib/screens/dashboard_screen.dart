import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import '../assets/global_values.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

   final imglogo = Image.asset('assets/dashlogo.gif', height: 350, width: 350);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenidos :)'),
      ),
      body: Stack(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ListView(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                              imglogo,
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      drawer: createDrawer(context),
    );
  }

  Widget createDrawer(context){
    return Drawer(
      child: ListView(
        children: [
          const UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage('https://i.pravatar.cc/300'),
            ),
            accountName: Text('Siddhartha Ariel F.'),
            accountEmail: Text('18031781@itcelaya.edu.mx')
          ),
          ListTile(
            //leading: Icon(Icons.mouse),
            //leading: Image.network('https://cdn3.iconfinder.com/data/icons/materia-flat-halloween-free/24/039_026_cat_black_witch_halloween-512.png'),
            leading: Image.asset('assets/aguacate.png'),
            trailing: Icon(Icons.chevron_right, color: Theme.of(context).iconTheme.color),
            title: Text('FruitApp'),
            subtitle: Text('Carrusel'),
            onTap: ()=> Navigator.pushNamed(context, '/frutas'),
          ),
          ListTile(
            leading: Icon(Icons.task, color: Theme.of(context).iconTheme.color),
            //leading: Image.network('https://cdn3.iconfinder.com/data/icons/materia-flat-halloween-free/24/039_026_cat_black_witch_halloween-512.png'),
            //leading: Image.asset('assets/aguacate.png'),
            trailing: Icon(Icons.chevron_right, color: Theme.of(context).iconTheme.color),
            title: Text('Task Manager'),
            subtitle: Text('Tasks'),
            onTap: ()=> Navigator.pushNamed(context, '/task'),
          ),
          /*ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/popular2');
              },
              horizontalTitleGap: 0.0,
              leading: const Icon(Icons.movie),
              title: const Text(
                'API Movies',
                style: TextStyle(fontSize: 16),
              ),
              trailing: Icon(Icons.chevron_right),
            ),*/
          ListTile(
            leading: Icon(Icons.movie, color: Theme.of(context).iconTheme.color),
            //leading: Image.network('https://cdn3.iconfinder.com/data/icons/materia-flat-halloween-free/24/039_026_cat_black_witch_halloween-512.png'),
            //leading: Image.asset('assets/aguacate.png'),
            trailing: Icon(Icons.chevron_right, color: Theme.of(context).iconTheme.color),
            title: Text('Popular Movies'),
            subtitle: Text('Movies y Practica 5'),
            onTap: ()=> Navigator.pushNamed(context, '/popular2'),
          ),
          ListTile(
            leading: Icon(Icons.animation_outlined, color: Theme.of(context).iconTheme.color),
            //leading: Image.network('https://cdn3.iconfinder.com/data/icons/materia-flat-halloween-free/24/039_026_cat_black_witch_halloween-512.png'),
            //leading: Image.asset('assets/aguacate.png'),
            trailing: Icon(Icons.chevron_right, color: Theme.of(context).iconTheme.color),
            title: Text('Test Provider'),
            subtitle: Text('Provider'),
            onTap: ()=> Navigator.pushNamed(context, '/prov'),
          ),
          /*ListTile(
            leading: Icon(Icons.date_range, color: Theme.of(context).iconTheme.color),
            trailing: Icon(Icons.chevron_right, color: Theme.of(context).iconTheme.color),
            title: const Text('Calendario'),
            subtitle: Text('Practica 4'),
            onTap: () {
              Navigator.pushNamed(context, '/calendar');
            },
          ),
          ListTile(
            leading: Icon(Icons.person, color: Theme.of(context).iconTheme.color),
            trailing: Icon(Icons.chevron_right, color: Theme.of(context).iconTheme.color),
            title: const Text('Profesores'),
            subtitle: Text('Practica 4'),
            onTap: () {
              Navigator.pushNamed(context, '/professor');
            },
          ),
          ListTile(
            leading: Icon(Icons.document_scanner, color: Theme.of(context).iconTheme.color),
            trailing: Icon(Icons.chevron_right, color: Theme.of(context).iconTheme.color),
            title: const Text('Carreras'),
            subtitle: Text('Practica 4'),
            onTap: () {
              Navigator.pushNamed(context, '/carreras');
            },
          ),*/
          ListTile(
            leading: Icon(Icons.school, color: Theme.of(context).iconTheme.color),
            trailing: Icon(Icons.chevron_right, color: Theme.of(context).iconTheme.color),
            title: const Text('Tareas'),
            subtitle: Text('Practica 4'),
            onTap: () {
              Navigator.pushNamed(context, '/practica4');
            },
          ),
          ListTile(
            leading: Icon(Icons.map, color: Theme.of(context).iconTheme.color),
            trailing: Icon(Icons.chevron_right, color: Theme.of(context).iconTheme.color),
            title: const Text('Mapas'),
            subtitle: Text('Practica 6'),
            onTap: () {
              Navigator.pushNamed(context, '/maps');
            },
          ),
          ListTile(
            leading: Icon(Icons.logout, color: Theme.of(context).iconTheme.color),
            trailing: Icon(Icons.chevron_right, color: Theme.of(context).iconTheme.color),
            title: const Text('logout'),
            subtitle: Text('Practica 3'),
            onTap: () {
              GlobalValues.login.setBool('login', false);
              GlobalValues.session.setBool('session', false);
              Navigator.pushNamed(context, '/login');
            },
          ),
          DayNightSwitcher(
            isDarkModeEnabled: GlobalValues.flagTheme.value,
            onStateChanged: (isDarkModeEnabled) {
              GlobalValues.teme.setBool('teme', isDarkModeEnabled);
              GlobalValues.flagTheme.value = isDarkModeEnabled;
            },
          ),
        ],
      ),
    );
  }
}