import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:pmsn20232/models/recipe_model.dart';
import 'package:pmsn20232/models/user_model.dart';
import 'package:pmsn20232/network/api_spoonacular.dart';
import 'package:pmsn20232/screens/details_recipe.dart';
import 'package:pmsn20232/screens/post_screen.dart';
import 'package:pmsn20232/services/email_authentication.dart';
import 'package:pmsn20232/screens/list_post_cloud_screen.dart';
import 'package:pmsn20232/widgets/item_spoonacular.dart';

import '../provider/theme_provider.dart';
import '../services/push_notification_service.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  void _toggleTheme(theme) {
    final settings = Provider.of<ThemeProvider>(context, listen: false);
    settings.toggleTheme(theme);
  }

  //late List<Recipe> _recipes;
  //bool _isLoading = true;

  ApiSpoonacular? apiSpoonacular;

  EmailAuth emailAuth = EmailAuth();

  File? _image;
  var urlDownload = '';

  Future getImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemporary = File(image.path);

      setState(() {
        this._image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    //getRecipes();

    apiSpoonacular = ApiSpoonacular();
  }

  /*Future<void> getRecipes() async{
    _recipes = await RecipeApi.getRecipe();
    setState(() {
      _isLoading = false;
    });
  }*/

  Future<String> getUrlImage() async {
    await Future.delayed(Duration(seconds: 1));

    try {
      return await FirebaseStorage.instance
          .ref()
          .child('users/${FirebaseAuth.instance.currentUser!.uid}.jpg')
          .getDownloadURL();
    } catch (e) {
      return await FirebaseStorage.instance
          .ref()
          .child('users/avatar.png')
          .getDownloadURL();
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider theme = Provider.of<ThemeProvider>(context);
    final user = FirebaseAuth.instance.currentUser!;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Row(
            children: [
              Icon(Icons.restaurant_menu),
              SizedBox(
                width: 10,
              ),
              Text('Bienvenido '),
            ],
          ),
          bottom: TabBar(
            tabs: [
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.home,
                      color: Colors.white,
                    ),
                    Text(
                      ' Inicio',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.group,
                      color: Colors.white,
                    ),
                    Text(
                      ' Social',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        /*body: _isLoading ? Center(child: CircularProgressIndicator())
                       : ListView.builder(
                          itemCount: _recipes.length,
                          itemBuilder: (context, index) {
                            return RecipeCard(
                              title: _recipes[index].name, 
                              cookTime: _recipes[index].totalTime, 
                              rating: _recipes[index].rating.toString(), 
                              thumbnailUrl: _recipes[index].images
                            );
                          },
                       )*/
        body: TabBarView(
          children: [
            FutureBuilder(
              future: apiSpoonacular!.getAllRecipes(),
              builder: (context, AsyncSnapshot<List<RecipeModel>?> snapshot) {
                if (snapshot.data != null) {
                  return InkWell(
                    onTap: () {},
                    child: GridView.builder(
                      itemCount: snapshot.data!.length,
                      padding: const EdgeInsets.all(10),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        mainAxisSpacing: 10,
                        childAspectRatio: 2,
                        crossAxisSpacing: 10,
                      ),
                      itemBuilder: (context, index) {
                        if (snapshot.hasData) {
                          RecipeModel model = snapshot.data![index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          detailsRecipe(
                                            recipeModel: model,
                                          )));
                            },
                            child: ItemSpoonacular(
                                recipeModel: snapshot.data![index]),
                          );
                        } else if (snapshot.hasError) {
                          return const Center(
                            child: Text('Algo salio mal :()'),
                          );
                        } else {
                          return const CircularProgressIndicator();
                        }
                      },
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
            ListPostCloudScreen(),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                currentAccountPicture: user.photoURL != null
                    ? CircleAvatar(
                        backgroundImage: NetworkImage(user.photoURL!))
                    : FutureBuilder(
                        future: getUrlImage(),
                        builder: ((BuildContext context,
                            AsyncSnapshot<String> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else {
                            return CircleAvatar(
                              backgroundImage: NetworkImage(snapshot.data!),
                              radius: 100,
                            );
                          }
                        })),
                accountName: user.displayName != null
                    ? Text(user.displayName!)
                    : Container(),
                accountEmail:
                    user.email != null ? Text(user.email!) : Container(),
                onDetailsPressed: () {
                  Navigator.pushNamed(context, '/user');
                },
              ),
              ListTile(
                onTap: () async {
                  //await emailAuth.signOut();
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushNamed(context, '/login');
                },
                horizontalTitleGap: 0.0,
                leading: const Icon(Icons.add_to_home_screen),
                title: const Text(
                  'Cerrar Sesión',
                  style: TextStyle(fontSize: 16),
                ),
                trailing: const Icon(Icons.chevron_right),
              ),
              ListTile(
                onTap: () {
                  Navigator.pushNamed(context, '/subs');
                },
                horizontalTitleGap: 0.0,
                leading: const Icon(Icons.star),
                title: const Text(
                  'Suscripciones',
                  style: TextStyle(fontSize: 16),
                ),
                trailing: const Icon(Icons.chevron_right),
              ),
              DropdownButtonFormField<String>(
                  isExpanded: true,
                  value: theme.getTheme(),
                  decoration: const InputDecoration(
                    labelText: 'Tema',
                    prefixIcon: Icon(Icons.color_lens),
                  ),
                  items: <String>['light', 'eco'].map((i) {
                    return DropdownMenuItem(
                        value: i,
                        child: Text(
                          i,
                        ));
                  }).toList(),
                  hint: const Text('Tema'),
                  //padding: const EdgeInsets.symmetric(horizontal: 10),
                  onChanged: (value) {
                    if (value == 'light') {
                      _toggleTheme('light');
                    }
                    if (value == 'eco') {
                      _toggleTheme('eco');
                    }
                  }),
            ],
          ),
<<<<<<< Updated upstream
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
            leading: Icon(Icons.location_pin, color: Theme.of(context).iconTheme.color),
             trailing: Icon(Icons.chevron_right, color: Theme.of(context).iconTheme.color),
            title: const Text('Clima en ubicacion actual'),
            subtitle: Text('Practica 6'),
            onTap: () {
              Navigator.pushNamed(context, '/weather');
            },
          ),
          ListTile(
            leading: Icon(Icons.map, color: Theme.of(context).iconTheme.color),
            trailing: Icon(Icons.chevron_right, color: Theme.of(context).iconTheme.color),
            title: const Text('Mapas'),
            subtitle: Text('Practica 6'),
            onTap: () {
              Navigator.pushNamed(context, '/maps2');
            },
          ),
          
          ListTile(
            leading: Icon(Icons.list, color: Theme.of(context).iconTheme.color),
             trailing: Icon(Icons.chevron_right, color: Theme.of(context).iconTheme.color),
            title: const Text('Lista de ubicaciones'),
            subtitle: Text('Practica 6'),
            onTap: () {
              Navigator.pushNamed(context, '/listweather');
            },
          ),
          ListTile(
            leading: Icon(Icons.movie, color: Theme.of(context).iconTheme.color),
             trailing: Icon(Icons.chevron_right, color: Theme.of(context).iconTheme.color),
            title: const Text('Peliculas'),
            subtitle: Text('Firebase'),
            onTap: () {
              Navigator.pushNamed(context, '/pelis');
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
=======
        ),
        /*body: _isLoading ? Center(child: CircularProgressIndicator())
                         : ListView.builder(
                            itemCount: _recipes.length,
                            itemBuilder: (context, index) {
                              return RecipeCard(
                                title: _recipes[index].name, 
                                cookTime: _recipes[index].totalTime, 
                                rating: _recipes[index].rating.toString(), 
                                thumbnailUrl: _recipes[index].images
                              );
                            },
                         )*/
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: ((context) => PostScreen(
                      token: '',
                    )),
              ),
            );
          },
          label: const Text('Publicar'),
          icon: const Icon(Icons.food_bank),
        ),
>>>>>>> Stashed changes
      ),
    );
  }
}
