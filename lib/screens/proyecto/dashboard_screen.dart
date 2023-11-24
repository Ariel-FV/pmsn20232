import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import '../../assets/global_values.dart';
import 'package:pmsn20232/provider/test_provider.dart';
import 'package:provider/provider.dart';

import 'package:pmsn20232/database/proyecto/database_helper.dart';
import 'package:pmsn20232/models/proyecto/libros_model.dart';
import 'package:pmsn20232/network/proyecto/api_libros.dart';
import 'package:pmsn20232/widgets/proyecto/libros_popular.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  //UserModel? user;
  ApiLibros? apiLibros;
  bool isFavoriteView = false;
  DatabaseHelper? database;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiLibros = ApiLibros();
    database = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    TestProvider flag = Provider.of<TestProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Libros Recientes'),
        actions: [
          IconButton(
            icon: isFavoriteView != true
                ? Icon(Icons.favorite)
                : Icon(Icons.list),
            onPressed: () {
              setState(() {
                isFavoriteView = !isFavoriteView;
              });
            },
          )
        ],
      ),
      body: FutureBuilder(
          future: flag.getflagListPost() == true
              ? isFavoriteView
                  ? database!.getAllPopular()
                  : apiLibros!.getAllPopular()
              : isFavoriteView
                  ? database!.getAllPopular()
                  : apiLibros!.getAllPopular(),
          builder: (context, AsyncSnapshot<List<LibrosModel>?> snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                padding: EdgeInsets.all(15),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: .8,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemCount: snapshot.data != null ? snapshot.data!.length : 0,
                itemBuilder: (context, index) {
                  LibrosModel librosModel = snapshot.data![index];
                  return GestureDetector(
                    onTap: () {
                      /*Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) => MovieDetailScreen(
                            popularModel: snapshot.data![index],
                          ),
                        ),
                      );*/
                    },
                    child: Hero(
                      tag: snapshot.data![index].id!,
                      child: LibroPopular(librosModel: snapshot.data![index]),
                    ),
                  );
                  //return ItemPopular(popularModel: snapshot.data![index]);
                },
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('OCURRIO UN ERROR' + snapshot.error.toString()),
              );
            } else {
              return CircularProgressIndicator();
            }
          }),
          drawer: createDrawer(context),
    );
  }

  Widget createDrawer(context){
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
                  //backgroundImage: NetworkImage(user!.photoUrl.toString()),
                ),
                accountName: Text('user!.name.toString()'),
                accountEmail: Text('user!.email.toString()')
                ),
          ListTile(
            leading: Icon(Icons.task, color: Theme.of(context).iconTheme.color),
            trailing: Icon(Icons.chevron_right, color: Theme.of(context).iconTheme.color),
            title: Text('Task Manager'),
            subtitle: Text('Tasks'),
            onTap: ()=> Navigator.pushNamed(context, '/task'),
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