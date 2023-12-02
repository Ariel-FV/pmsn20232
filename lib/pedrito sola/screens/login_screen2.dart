import 'package:flutter/material.dart';
import 'package:pmsn20232/firebase/email_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final emailAuth = EmailAuth();

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

    final btninfo = ElevatedButton(onPressed: () => Navigator.pushNamed(context, '/knows'), 
      child: Text('Info'),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 25, 143, 31),
      ),
      );

    final btnEntrar = FloatingActionButton.extended(
      icon: Icon(Icons.login),
      label: Text('Entrar'),
      onPressed: () async {
        bool res = await emailAuth.validateUser(emailUser: txtConUser.text, pwdUser: txtConPass.text);
        if(res){
          Navigator.pushNamed(context, '/dash');
        }
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
                height: 260,
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
                    txtPass,
                    const SizedBox(height: 10),
                    btninfo
                    
                  ],
                ),
              ),
              //imgLogo,
              TextButton(
                onPressed: ()=>Navigator.pushNamed(context, '/register'), 
                child: Text('Registrate :)',
                style: TextStyle(fontSize: 15),)),
              //conocenos(),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: btnEntrar,
      
    );
  }
}

class conocenos extends StatelessWidget {
  const conocenos({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      heroTag: conocenos,
      onPressed: () {
        Navigator.pushNamed(context, '/knows');
      },
      label: const Text('Info.'),
      icon: const Icon(Icons.info),
      backgroundColor: const Color.fromARGB(255, 25, 143, 31),
    );
  }
}