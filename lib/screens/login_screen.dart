import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    //controladores
    TextEditingController txtConUser = TextEditingController();
    TextEditingController txtConPass = TextEditingController();

    //declaracion de los elementos
    final imgLogo = Container(
      width: 400,
        decoration: const BoxDecoration( 
          image: DecorationImage(
            image: NetworkImage('https://upload.wikimedia.org/wikipedia/en/thumb/c/ca/Studio_Ghibli_logo.svg/1200px-Studio_Ghibli_logo.svg.png')
         )
        ),
      );

    final txtUser = TextField(
      controller: txtConUser,
      decoration: const InputDecoration(
        border: OutlineInputBorder()
      ),
    );

    final txtPass = TextField(
      controller: txtConPass,
      decoration: const InputDecoration(
        border: OutlineInputBorder()
      ),
      obscureText: true,
    );

    final btnEntrar = FloatingActionButton.extended(
      icon: Icon(Icons.login),
      label: Text('Entrar'),
      onPressed: (){
      //onPressed: () => Navigator.pushNamed(context, '/dash');
        Navigator.pushNamed(context, '/dash');
      }
    );
    
    //construccion de la pantalla login
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration( 
          image: DecorationImage(
            opacity: .7,
            fit: BoxFit.cover,
            image: NetworkImage('https://e0.pxfuel.com/wallpapers/835/942/desktop-wallpaper-resultado-de-n-para-fondos-de-pantalla-para-celular-tumblr-totoro-design.jpg')
         )
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 100.0),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                height: 200,
                padding: EdgeInsets.all(30),
                margin: EdgeInsets.symmetric(horizontal: 30),
                //color: Colors.white,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white
                ),
                child: Column(
                  children: [
                    txtUser,
                    const SizedBox(height: 10),
                    txtPass
                  ],
                ),
              ),
              imgLogo
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: btnEntrar,
    );
  }
}