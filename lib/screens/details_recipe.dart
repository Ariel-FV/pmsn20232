import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_html/flutter_html.dart';
import 'package:pmsn20232/models/ingredients_model.dart';
import 'package:pmsn20232/models/recipe_model.dart';
import 'package:pmsn20232/network/api_spoonacular.dart';

import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart' as zzz;
import 'package:translator/translator.dart';

class detailsRecipe extends StatefulWidget {
  const detailsRecipe({Key? key, required this.recipeModel}) : super(key: key);

  final RecipeModel recipeModel;

  @override
  State<detailsRecipe> createState() => _detailsRecipeState();
}

class _detailsRecipeState extends State<detailsRecipe> {
  final ApiSpoonacular apiSpoonacular = ApiSpoonacular();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
          length: 2,
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  title: Text(widget.recipeModel.title.toString()),
                  expandedHeight: 320,
                  flexibleSpace: CachedNetworkImage(
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    imageUrl: widget.recipeModel.image.toString(),
                    fit: BoxFit.cover,
                    colorBlendMode: BlendMode.multiply,
                    color: Colors.black.withOpacity(0.5),
                  ),
                  /*Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                widget.recipeModel.image.toString()))),
                    child: Container(
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),*/
                  pinned: true,
                  bottom: TabBar(
                      labelColor: Colors.white,
                      indicatorWeight: 4,
                      tabs: <Widget>[
                        Tab(
                          child: Text(
                            'Details',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        Tab(
                          child: Text(
                            'Ingredients',
                            style: TextStyle(fontSize: 18),
                          ),
                        )
                      ]),
                )
              ];
            },
            body: TabBarView(
              children: <Widget>[
                Container(
                    color: Colors.orange.withOpacity(0.3),
                    child: ListView(
                      padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                      children: <Widget>[
                        Text(
                          widget.recipeModel.title.toString(),
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: FutureBuilder<String>(
    future: limpiarHTML(widget.recipeModel.summary.toString()),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        // Si la operación está en curso, puedes mostrar un indicador de carga u otra UI temporal.
        return CircularProgressIndicator();
      } else if (snapshot.hasError) {
        // Si hay un error, puedes mostrar un mensaje de error.
        return Text('Error: ${snapshot.error}');
      } else {
        // Si la operación se completó con éxito, muestra el texto limpio.
        return Text(snapshot.data ?? '');
      }
    },
  ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container()
                      ],
                    )),
                Container(
                    color: Colors.orange.withOpacity(0.3),
                    child: ListView(
                        padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                        children: <Widget>[
                          Text(
                            widget.recipeModel.title.toString(),
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Column(
                            children: [
                              Container(
                                height: 15,
                                width: 15,
                                decoration:
                                    BoxDecoration(shape: BoxShape.circle),
                              ),
                              FutureBuilder<List<ingredientsModel>>(
                                future: apiSpoonacular.getIngredients(
                                    widget.recipeModel.id.toString()),
                                builder: (BuildContext context,
                                    AsyncSnapshot<List<ingredientsModel>?>
                                        snapshot) {
                                  if (snapshot.hasData) {
                                    return SizedBox(
                                      height: 350,
                                      child: ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        itemCount: snapshot.data!.length,
                                        itemBuilder: (context, index) {
                                          var i = 1;
                                          return Text(
                                            "° " +
                                                snapshot.data![index].name
                                                    .toString(),
                                            style: TextStyle(fontSize: 25),
                                          );
                                        },
                                      ),
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
                            ],
                          )
                        ]))
              ],
            ),
          )),
    );
  }
  Future<String> limpiarHTML(String htmlString) async{
  // Parsea la cadena HTML
  zzz.Document document = parse(htmlString);

  // Obtiene el texto del cuerpo del HTML
  String textoLimpio = document.body?.text ?? '';

  String textoLimpio2 = await traducir(textoLimpio);

  return textoLimpio2;
}
Future<String> traducir(String textito) async {
  // Crea una instancia de GoogleTranslator
  final translator = GoogleTranslator();

  // Traduce el texto de inglés a español
  Translation texto = await translator.translate(textito, from: 'en', to: 'es');

  String textoTraducido = texto.text;

  print('Texto traducido al español: $textoTraducido');

  return textoTraducido;
}
}
