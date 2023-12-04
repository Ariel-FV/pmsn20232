import 'package:flutter/material.dart';
import 'package:pmsn20232/assets/global_values.dart';
import 'package:pmsn20232/database/calen/agendadb.dart';
import 'package:pmsn20232/models/calen/carrera_model.dart';
import 'package:pmsn20232/screens/calen/add_carrera.dart';


// ignore: must_be_immutable
class CardCarreraWidget extends StatelessWidget {
  CardCarreraWidget({super.key, required this.carreraModel, this.agendaDB});

  CareerModel carreraModel;
  AgendaDB? agendaDB;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),

      decoration: BoxDecoration(
        color: Color.fromARGB(255, 90, 90, 245), borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(color: Colors.white, spreadRadius: 3),
        ],
      ),
      child: Row(
        children: [
          Column(
            children: [Text(carreraModel.nameCareer!, style:TextStyle(color: Colors.white))],
          ),
          Expanded(
            child: Container(),
          ),
          Column(
            children: [
              GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            AddCarrera(carreraModel: carreraModel))),
                child: Icon(Icons.edit, color: Theme.of(context).iconTheme.color)
              ),
              IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Mensaje del sistema'),
                          content: Text('¿Deseas borrar la carrera?'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  agendaDB!
                                      .DELETE4('tblCarrera', 'idCareer',
                                          carreraModel.idCareer!)
                                      .then((value) {
                                    if (value == 0) {
                                      Navigator.pop(context);
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Text('Alerta'),
                                              content: Text('Tiene asginada.'),
                                              actions: [
                                                TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(context),
                                                    child: Text('Entendido')),
                                              ],
                                            );
                                          });
                                    } else {
                                      Navigator.pop(context);
                                      GlobalValues.flagPR4Carrera.value =
                                          !GlobalValues.flagPR4Carrera.value;
                                    }
                                  });
                                },
                                child: Text('Si')),
                            TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('No')),
                          ],
                        );
                      },
                    );
                  },
                  icon: Icon(Icons.delete))
            ],
          )
        ],
      ),
    );
  }
}
