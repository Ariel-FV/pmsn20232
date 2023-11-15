import 'package:flutter/material.dart';
import 'package:pmsn20232/firebase/favorites_firebase.dart';

class PopularFirebaseScreen extends StatefulWidget {
  const PopularFirebaseScreen({super.key});

  @override
  State<PopularFirebaseScreen> createState() => _PopularFirebaseScreenState();
}

class _PopularFirebaseScreenState extends State<PopularFirebaseScreen> {
  FavoritesFirebase? _favoritesFirebase;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _favoritesFirebase = FavoritesFirebase();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _favoritesFirebase!.getAllFavorites(),
      builder: (context, snapshot){
        if(snapshot.hasData){
          return ListView.builder(
            itemBuilder: (context, index) {
              return Text(snapshot.data!.docs[index].get('title'));
            },
          );
        }else{
          if(snapshot.hasError){
            return Center(child: Text('Error!'),);
          }else{
            return Center(child: CircularProgressIndicator(),);
          }

          
        }

      },
    );
  }
}