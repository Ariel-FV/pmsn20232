<<<<<<< Updated upstream
import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String? name;
  final String? photoUrl;
  final String? email;

  UserModel({this.name, this.photoUrl, this.email});

  factory UserModel.fromFirebaseUser(User firebaseUser) {
    String? name = firebaseUser.providerData[0].displayName;
    String? photoUrl = firebaseUser.providerData[0].photoURL;
    String? email = firebaseUser.providerData[0].email;
    UserModel aux = UserModel(name: name, photoUrl: photoUrl, email: email);
    return aux;
  }
=======
class UserModel {
  final String uid;
  final String name;
  final String platform;
  final String token;
  final String createdAt;

  const UserModel({
    required this.createdAt,
    required this.name,
    required this.platform,
    required this.token,
    required this.uid,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        uid: json['uid'],
        createdAt: json['createdAt'],
        platform: json['platform'],
        token: json['token'],
        name: json['name'],
      );

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'token': token,
        'name': name,
        'platform': platform,
        'createdAt': createdAt,
      };
>>>>>>> Stashed changes
}
