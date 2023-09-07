import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';

import '../assets/global_values.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenidos :)'),
      ),
      drawer: createDrawer(),
    );
  }

  Widget createDrawer(){
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
            trailing: Icon(Icons.chevron_right),
            title: Text('FruitApp'),
            subtitle: Text('Carrusel'),
            onTap: (){},
          ),
          DayNightSwitcher(
            isDarkModeEnabled: GlobalValues.flagTheme.value,
            onStateChanged: (isDarkModeEnabled) {
              setState(() {
                GlobalValues.flagTheme.value= isDarkModeEnabled;
              });
            },
          ),
        ],
      ),
    );
  }
}