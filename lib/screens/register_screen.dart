import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
<<<<<<< Updated upstream
import 'package:pmsn20232/firebase/email_auth.dart';
import 'package:pmsn20232/firebase/google_auth.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

=======
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:pmsnb1/firebase/email_auth.dart';

import '../services/email_authentication.dart';
>>>>>>> Stashed changes

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  File? _image;

<<<<<<< Updated upstream
  final TextEditingController conNameUser = TextEditingController();
  final TextEditingController conEmailUser = TextEditingController();
  final TextEditingController conPwdUser = TextEditingController();
  final emailAuth = EmailAuth();
  GoogleAuth googleAuth = GoogleAuth();

  

  @override
  Widget build(BuildContext context) {
  final btnGoogle = SocialLoginButton(
      buttonType: SocialLoginButtonType.google,
      text: 'Continue with Google',
      onPressed: () {
        googleAuth.registerWithGoogle().then((value) {
          if (value) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('User successfully registered')),
            );
            Navigator.pushNamed(context, '/login');
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text(
                      'There is already a registered user with this account')),
            );
          }
        });
      },
    );

    return Scaffold(
      appBar: AppBar(title: Text('Registrar Usuario'),),
      body: Column(
        children: [
          
          TextFormField(
            controller: conNameUser,
          ),
          TextFormField(
            controller: conEmailUser,
          ),
          TextFormField(
            controller: conPwdUser,
          ),
          ElevatedButton(onPressed: (){
            var email = conEmailUser.text;
            var pwd = conPwdUser.text;

            conEmailUser.text = '';
            conPwdUser.text = '';

            emailAuth.createUser(emailUser: email, pwdUser: pwd);
            

            Navigator.pop(context);
          }, child: Text('Registrar')),
          btnGoogle,
        ],
=======
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

  EmailAuth emailAuth = EmailAuth();
  TextEditingController conEmail = TextEditingController();
  TextEditingController conPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final txtName = TextFormField(
      decoration: const InputDecoration(
          label: Text('Name User'), enabledBorder: OutlineInputBorder()),
      validator: (value) {
        if (value != null && value.isEmpty) {
          return 'Ingresa un nombre';
        } else {
          return null;
        }
      },
    );

    final txtEmail = TextFormField(
        controller: conEmail,
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(
            label: Text('Email User'), enabledBorder: OutlineInputBorder()),
        validator: (value) {
          if (value != null && !EmailValidator.validate(value)) {
            return 'Ingresa un correo valido';
          } else {
            return null;
          }
        });

    final txtPass = TextFormField(
        controller: conPass,
        obscureText: true,
        decoration: const InputDecoration(
            label: Text('Password User'), enabledBorder: OutlineInputBorder()),
        validator: (value) {
          if (value != null && value.isEmpty) {
            return 'Ingresa una contraseña';
          } else {
            return null;
          }
        });

    final spaceHorizontal = SizedBox(
      height: 15,
    );
    final spaceGiant = SizedBox(
      height: 60,
    );

    final btnRregister = ElevatedButton(
      onPressed: () async {
        if (formKey.currentState!.validate()) {
          await emailAuth.createUserWithEmailAndPassword(
              email: conEmail.text, password: conPass.text);
          Navigator.pushNamed(context, '/login');
        }
      },
      style: ElevatedButton.styleFrom(
          elevation: 10.0,
          textStyle: const TextStyle(color: Colors.white, fontSize: 20),
          fixedSize: const Size(800, 60)),
      child: const Text('Registrarse'),
    );

    final btnGallery = ElevatedButton(
        onPressed: () {
          getImage(ImageSource.gallery);
        },
        style: ElevatedButton.styleFrom(fixedSize: const Size(200, 50)),
        child: Row(
          children: [
            Icon(Icons.image_outlined),
            SizedBox(
              width: 20,
            ),
            Text('Pick from Gallery')
          ],
        ));

    final btnCamera = ElevatedButton(
        onPressed: () {
          getImage(ImageSource.camera);
        },
        style: ElevatedButton.styleFrom(fixedSize: const Size(200, 50)),
        child: Row(
          children: [
            Icon(Icons.camera),
            SizedBox(
              width: 20,
            ),
            Text('Pick from Camera')
          ],
        ));

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: MediaQuery.of(context).size.height,
        /*decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/fondoregistro.jpg'),
            fit: BoxFit.cover,
            opacity: 0.9
          )
        ),*/

        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    spaceHorizontal,
                    
                    ClipOval(
                      child: _image != null
                          ? Image.file(
                              _image!,
                              width: 150,
                              height: 150,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              'assets/avatar.png',
                              width: 150,
                            ),
                    ),
                    spaceHorizontal,
                    spaceHorizontal,
                    btnGallery,
                    spaceHorizontal,
                    btnCamera,
                    spaceHorizontal,
                    txtName,
                    spaceHorizontal,
                    txtEmail,
                    spaceHorizontal,
                    txtPass,
                    spaceHorizontal,
                    spaceHorizontal,
                    spaceHorizontal,
                    btnRregister,
                    spaceGiant
                  ],
                ),
              ],
            ),
          ),
        ),
>>>>>>> Stashed changes
      ),
    );
  }
}
