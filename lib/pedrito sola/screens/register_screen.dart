import 'package:flutter/material.dart';
import 'package:pmsn20232/firebase/email_auth.dart';
import 'package:pmsn20232/firebase/google_auth.dart';
import 'package:social_login_buttons/social_login_buttons.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

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
      ),
    );
  }
}