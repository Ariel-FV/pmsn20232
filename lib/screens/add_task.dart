import 'package:flutter/material.dart';
import 'package:pmsn20232/database/agendadb.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TextEditingController txtConName = TextEditingController();
  TextEditingController txtConDesc = TextEditingController();
    
  String dropDownValue = "Pendiente";
  List<String> dropDownValues = ['Pendiente', 'Completado', 'En Proceso'];

  AgendaDB? agendaDB;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    agendaDB = AgendaDB();
  }

  @override
  Widget build(BuildContext context) {
    final txtNameTask = TextFormField(
      decoration: const InputDecoration(
        label: Text('Tarea'),
        border: OutlineInputBorder()
      ),
      controller: txtConName,
    );

    final txtDescTask = TextField(
      decoration: const InputDecoration(
        label: Text('Descripcion'),
        border: OutlineInputBorder()
      ),
      maxLines: 6,
      controller: txtConDesc,
    );

    final DropdownButton ddBStatus = DropdownButton(
      value: dropDownValue,
      items: dropDownValues.map(
        (status) => DropdownMenuItem(
          value: status,
          child: Text(status)
        )
      ).toList(), 
      onChanged: (value){
        dropDownValue = value;
        setState(() {});
      }
    );

    final ElevatedButton btnGuardar = ElevatedButton(
      onPressed: (){
        agendaDB!.INSERT('tblTareas', {  
          'nameTask' : txtConName.text,
          'dscTask' : txtConDesc.text,
          'sttTask' : dropDownValue.substring(1,1)
        }).then((value) {
          var msj = (value > 0)
          ? 'La insercion fue exitosa! :)'
          : 'Ocurrio un error! :(';
          var snackbar = SnackBar(content: Text(msj));
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
          Navigator.pop(context);
        });
      }, 
      child: Text('Save Task'),
    );

    final space = SizedBox(height: 10);

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            txtNameTask,
            space,
            txtDescTask,
            space,
            ddBStatus,
            space,
            btnGuardar
          ],
        ),
      ),
    );
  }
}