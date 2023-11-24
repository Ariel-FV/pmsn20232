import 'package:flutter/material.dart';
import 'package:pmsn20232/models/proyecto/libros_model.dart';
import 'package:pmsn20232/provider/test_provider.dart';
import 'package:provider/provider.dart';
import 'package:pmsn20232/database/proyecto/database_helper.dart';

class LibroPopular extends StatefulWidget {
  LibroPopular({super.key, required this.librosModel});
  LibrosModel librosModel;

  @override
  State<LibroPopular> createState() => _LibroPopularState();
}

class _LibroPopularState extends State<LibroPopular> {
  DatabaseHelper databaseHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    TestProvider flag = Provider.of<TestProvider>(context);
    return Stack(
      children: [
        Container(
          /*decoration: BoxDecoration(
            ,
            shape: BoxShape.circle,
            border: Border.all(color: Color.fromARGB(255, 106, 255, 0)),
          ),*/
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: FadeInImage(
              fit: BoxFit.fill,
              placeholder: AssetImage('assets/loading.gif'),
              image: NetworkImage(widget.librosModel.image.toString()),
            ),
          ),
        ),
        Positioned(
          top: 0.0,
          right: 20,
          child: FutureBuilder(
              future: databaseHelper.searchPopular(int.parse(widget.librosModel.id!)),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return IconButton(
                    icon: Icon(Icons.favorite),
                    color: snapshot.data != true ? const Color.fromARGB(255, 106, 106, 106) : Colors.red,
                    onPressed: () {
                      if (snapshot.data != true) {
                        databaseHelper
                            .INSERTAR(
                                'tblPopularFav', widget.librosModel.toMap())
                            .then((value) => flag.setflagListPost());
                      } else {
                        databaseHelper
                            .ELIMINAR(
                                'tblPopularFav', int.parse(widget.librosModel.id!), 'id')
                            .then((value) => flag.setflagListPost());
                      }
                    },
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ),
      ],
    );
  }
}
