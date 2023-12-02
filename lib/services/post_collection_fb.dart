import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/post_model.dart';

class PostCollection {
  FirebaseFirestore? _firestore;
  CollectionReference? _postCollection;
  DocumentReference? uwu;

  PostCollection() {
    _firestore = FirebaseFirestore.instance;
    _postCollection = _firestore!.collection('recetas');
  }

  Future<void> insert(PostModel postModel) async {
    return _postCollection!.doc().set(
      {
        'nombre': postModel.nombre,
        'caloria': postModel.caloria,
        'carbohidratos': postModel.carbohidratos,
        'descripcion': postModel.descripcion,
        'grasas': postModel.grasas,
        'imagen': postModel.imagen,
        'proteina': postModel.proteina,
        'usuario': postModel.usuario,
        'tiempo': postModel.tiempo,
        'categoria': postModel.categoria
      },
    );
  }

  Stream<QuerySnapshot> getAllPost() {
    return _postCollection!.snapshots();
  }

  getPost(String id) async {
    uwu = FirebaseFirestore.instance.collection('recetas').doc(id);
    DocumentSnapshot<Object?>? snapshot = await uwu?.get();
    Map<String, dynamic> datos = snapshot?.data() as Map<String, dynamic>;
    return datos;
  }

  Future<void> updFavorite(PostModel postModel, String id) async {
    Map<String, dynamic> mapita = {
        'nombre': postModel.nombre,
        'caloria': postModel.caloria,
        'carbohidratos': postModel.carbohidratos,
        'descripcion': postModel.descripcion,
        'grasas': postModel.grasas,
        'imagen': postModel.imagen,
        'proteina': postModel.proteina,
        'usuario': postModel.usuario,
        'tiempo': postModel.tiempo,
        'categoria': postModel.categoria};
    return _postCollection!.doc(id).update(mapita);
  }

  Future<void> delFavorite(String id) async {
    return _postCollection!.doc(id).delete();
  }
}
