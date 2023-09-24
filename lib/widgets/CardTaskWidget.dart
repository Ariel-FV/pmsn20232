import 'package:flutter/material.dart';
import 'package:pmsn20232/assets/global_values.dart';
import 'package:pmsn20232/database/agendadb.dart';
import 'package:pmsn20232/models/task_model.dart';

class CardTaskWidget extends StatefulWidget {
  CardTaskWidget({super.key,required this.taskModel,this.agendaDB});

  TaskModel taskModel;
  AgendaDB? agendaDB;

  @override
  State<CardTaskWidget> createState() => _CardTaskWidgetState();
}

class _CardTaskWidgetState extends State<CardTaskWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.green
      ),
      child: Row(
        children: [
          Column(
            children: [
              Text(widget.taskModel.nameTask!),
              Text(widget.taskModel.dscTask!),
            ],
          ),
          Expanded(child: Container()),
          Column(
            children: [
              GestureDetector(
                onTap: (){},
                child: Image.asset('assets/mango.png',height: 50,)
              ),
              IconButton(onPressed: (){
                showDialog(
                  context: context, 
                  builder: (context){
                    return AlertDialog(
                      title: Text('Mensaje del sistema!!'),
                      content: Text('Deseas Eliminar la tarea? :('),
                      actions: [
                        TextButton(
                          onPressed: (){
                            widget.agendaDB!.DELETE('tblTareas', widget.taskModel.idTask!).then((value){
                              Navigator.pop(context);
                              GlobalValues.flagTask.value = !GlobalValues.flagTask.value;
                            });
                          }, 
                          child: Text('Si 🥲')),
                        TextButton(onPressed: () => Navigator.pop(context), child: Text('No 😁')),
                      ],
                    );
                  }
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