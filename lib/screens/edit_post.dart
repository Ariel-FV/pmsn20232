import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:pmsn20232/models/post_model.dart';
import 'package:pmsn20232/screens/login_screen.dart';

import 'dart:io';

import '../services/post_collection_fb.dart';

class EditPost extends StatefulWidget {
  EditPost({super.key, this.postModel});

  PostModel? postModel;

  @override
  State<EditPost> createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
  TextEditingController _calController = TextEditingController();
  TextEditingController _carController = TextEditingController();
  TextEditingController _descController = TextEditingController();
  TextEditingController _fatController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _proController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  late GroupButtonController _groupButtonController;
  
  var _category = "";

  var sel = 0;
  List<String> dropDownValues = ["Postre","Guisado","Crema","Ensalada","Pan"];

  final _formKey = GlobalKey<FormState>();

  PlatformFile? pickedFile;
  UploadTask? uploadTask;
  PostCollection postCollection = PostCollection();

  Future selectFile() async {
    final image = await FilePicker.platform.pickFiles();
    if (image == null) return;
    setState(() {
      pickedFile = image.files.first;
    });
  }

  Future EditFirebase() async {
    final urlDownload;
    if (pickedFile == null) {
      urlDownload = widget.postModel!.imagen!;
    } else {
      String? cont ="";
      final storage = FirebaseStorage.instance;
      //final reference = storage.ref().child('files');
      //final listResult = await reference.listAll();
      cont = obtenerNumerosDesdeURL(widget.postModel!.imagen!);
      await FirebaseStorage.instance.ref().child('files/${cont}.jpg').delete();
      final path = 'files/${cont}.jpg';

      final file = File(pickedFile!.path!);

      final ref = FirebaseStorage.instance.ref().child(path);
      uploadTask = ref.putFile(file);

      final snapshot = await uploadTask!.whenComplete(() {});

      urlDownload = await snapshot.ref.getDownloadURL();
      print('download link: ${urlDownload}');
    }

    

    final user = await emailAuth.getUserToken();
    postCollection.updFavorite(
      PostModel(
          caloria: _calController.text,
          carbohidratos: _carController.text,
          descripcion: _descController.text,
          grasas: _fatController.text,
          imagen: urlDownload,
          nombre: _nameController.text,
          proteina: _proController.text,
          tiempo: _timeController.text,
          usuario: user,
          categoria: _category),
      widget.postModel!.id!
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    switch (widget.postModel!.categoria){
      case 'Postre': sel = 0; break;
      case 'Guisado': sel = 1; break;
      case 'Crema': sel = 2; break;
      case 'Ensalada': sel = 3; break;
      case 'Pan': sel = 4; break;
    }
    
    _calController.text = widget.postModel!.caloria!;
    _carController.text = widget.postModel!.carbohidratos!;
    _descController.text = widget.postModel!.descripcion!;
    _fatController.text = widget.postModel!.grasas!;
    _nameController.text = widget.postModel!.nombre!;
    _proController.text = widget.postModel!.proteina!;
    _timeController.text = widget.postModel!.tiempo!;
    _groupButtonController = GroupButtonController(selectedIndexes: [sel]);
    _category = widget.postModel!.categoria!;
    print(widget.postModel!.id!);
    print(_category);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          children: [
            Icon(Icons.restaurant_menu),
            SizedBox(
              width: 10,
            ),
            Text('Publica tu reseta'),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                MyTextField(
                  myController: _nameController,
                  fieldName: "Nombre",
                  myIcon: Icons.food_bank,
                  prefixIconColor: Colors.deepPurple.shade300,
                ),
                MyTextField(
                  myController: _descController,
                  fieldName: "Descripcion",
                  myIcon: Icons.description,
                  prefixIconColor: Colors.deepPurple.shade300,
                ),
                MyTextField(
                  myController: _calController,
                  fieldName: "Calorias",
                  myIcon: Icons.set_meal,
                  prefixIconColor: Colors.deepPurple.shade300,
                  textInputType: TextInputType.number,
                ),
                MyTextField(
                  myController: _carController,
                  fieldName: "Carbohidratos",
                  myIcon: Icons.set_meal,
                  prefixIconColor: Colors.deepPurple.shade300,
                  textInputType: TextInputType.number,
                ),
                MyTextField(
                  myController: _fatController,
                  fieldName: "Grasas",
                  myIcon: Icons.set_meal,
                  prefixIconColor: Colors.deepPurple.shade300,
                  textInputType: TextInputType.number,
                ),
                MyTextField(
                  myController: _proController,
                  fieldName: "Proteinas",
                  myIcon: Icons.set_meal,
                  prefixIconColor: Colors.deepPurple.shade300,
                  textInputType: TextInputType.number,
                ),
                MyTextField(
                  myController: _timeController,
                  fieldName: "Tiempo",
                  myIcon: Icons.timelapse,
                  prefixIconColor: Colors.deepPurple.shade300,
                ),
                const SizedBox(
                  height: 10,
                ),
                GroupButton(
                  controller: _groupButtonController,
                  isRadio: false,
                  onSelected: (texto, index, isSelected) {
                    _category = texto;
                  },
                  buttons: [
                    "Postre",
                    "Guisado",
                    "Crema",
                    "Ensalada",
                    "Pan",
                  ],
                  maxSelected: 1,
                ),
                const Text(
                  'Selecciona una imagen.',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: selectFile,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      border: Border.all(
                          width: 2, color: Colors.deepPurple.shade500),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(29),
                      ),
                      child: pickedFile != null
                          ? Image.file(
                              File(pickedFile!.path!),
                              //File(pickedFile!.path!),
                              width: double.infinity,
                              height: 220,
                              fit: BoxFit.cover,
                            )
                          : Image.network(
                              widget.postModel!.imagen!,
                              height: 220,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await EditFirebase();

                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Actualizado'),
                        ),
                      );
                    }
                  },
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  height: 50,
                  color: const Color.fromARGB(255, 59, 160, 255),
                  textColor: Colors.black,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Actualizar',
                        style: TextStyle(
                          letterSpacing: 0.8,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String? obtenerNumerosDesdeURL(String cadena) {
      RegExp regExp = RegExp(r'%2F(\d+)\.jpg');
      Match? match = regExp.firstMatch(cadena);

      if (match != null) {
        return match.group(1);
      }else {
        return ''; // Retorna una cadena vacía si no se encuentran los números en la cadena
      }
    }

class MyTextField extends StatelessWidget {
  const MyTextField({
    Key? key,
    required this.fieldName,
    required this.myController,
    this.myIcon = Icons.verified_user_outlined,
    this.prefixIconColor = Colors.blueAccent,
    this.textInputType = TextInputType.text,
  }) : super(key: key);

  final TextEditingController myController;
  final String fieldName;
  final IconData myIcon;
  final Color prefixIconColor;
  final TextInputType textInputType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Requerido';
          } else
            null;
        },
        keyboardType: textInputType,
        controller: myController,
        decoration: InputDecoration(
          labelText: fieldName,
          prefixIcon: Icon(
            myIcon,
            color: prefixIconColor,
          ),
          border: const OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.deepPurple.shade300,
            ),
          ),
          labelStyle: const TextStyle(
            color: Colors.deepPurple,
          ),
        ),
      ),
    );
  }
}