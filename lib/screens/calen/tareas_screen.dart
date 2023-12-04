import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import '../../assets/global_values.dart';

class TareasScreen extends StatefulWidget {
  TareasScreen({super.key});

  @override
  State<TareasScreen> createState() => _TareasScreenState();
}

class _TareasScreenState extends State<TareasScreen> {

   //final imglogo = Image.asset('assets/dash2logo.gif', height: 350, width: 350);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sistema De Tareas'),
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
                              //imglogo,
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
              backgroundImage: NetworkImage('https://avatars.githubusercontent.com/u/102234549?v=4'),
            ),
            accountName: Text('Alan Sanchez'),
            accountEmail: Text('saulsanchezd@hotmail.com')
          ),
          ListTile(
            leading: Icon(Icons.document_scanner, color: Theme.of(context).iconTheme.color),
            trailing: Icon(Icons.chevron_right, color: Theme.of(context).iconTheme.color),
            title: const Text('Carreras'),
            subtitle: Text(''),
            onTap: () {
              Navigator.pushNamed(context, '/carreras');
            },
          ),
          ListTile(
            leading: Icon(Icons.person, color: Theme.of(context).iconTheme.color),
            trailing: Icon(Icons.chevron_right, color: Theme.of(context).iconTheme.color),
            title: const Text('Profesores'),
            subtitle: Text(''),
            onTap: () {
              Navigator.pushNamed(context, '/professor');
            },
          ),
          ListTile(
            leading: Icon(Icons.home_work, color: Theme.of(context).iconTheme.color),
            trailing: Icon(Icons.chevron_right, color: Theme.of(context).iconTheme.color),
            title: const Text('Tareas'),
            subtitle: Text(''),
            onTap: () {
              Navigator.pushNamed(context, '/tasks');
            },
          ),
          ListTile(
            leading: Icon(Icons.date_range, color: Theme.of(context).iconTheme.color),
            trailing: Icon(Icons.chevron_right, color: Theme.of(context).iconTheme.color),
            title: const Text('Calendario'),
            subtitle: Text(''),
            onTap: () {
              Navigator.pushNamed(context, '/calendar');
            },
          ),
        ],
      ),
    );
  }
}