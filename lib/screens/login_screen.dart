import 'dart:async';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
<<<<<<< Updated upstream
import 'package:pmsn20232/assets/global_values.dart';
import 'package:pmsn20232/firebase/email_auth.dart';
import 'package:pmsn20232/firebase/google_auth.dart';
=======
import 'package:github_sign_in_plus/github_sign_in_plus.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pmsn20232/services/email_authentication.dart';
>>>>>>> Stashed changes
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/responsive.dart';

EmailAuth emailAuth = EmailAuth();
TextEditingController conEmail = TextEditingController();
TextEditingController conPass = TextEditingController();

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool isLoading = false;
  late StreamSubscription _subs;
  bool loader = false;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    loader = false;
    _initDeepLinkListener();
    super.initState();
  }

  @override
  void dispose() {
    _disposeDeepLinkListener();
    super.dispose();
  }

  void _initDeepLinkListener() async {
    _subs = getLinksStream().listen((link) {
      _checkDeepLink(link!);
    }, cancelOnError: true);
  }

  void _checkDeepLink(String link) {
    if (link != null) {
      String code = link.substring(link.indexOf(RegExp('code=')) + 5);
      emailAuth.signInWithGithub(code).then((firebaseUser) {
        print(firebaseUser.email);
        print(firebaseUser.photoURL);
        print("LOGGED IN AS: ${firebaseUser.displayName}");
      }).catchError((e) {
        print("LOGIN ERROR: " + e.toString());
      });
    }
  }

  void _disposeDeepLinkListener() {
    if (_subs != null) {
      _subs.cancel();
    }
  }

  /*void onClickGitHubLoginButton() async {
    const String url =
        "https://github.com/login/oauth/authorize?client_id=0b659cbaa326f82d5bdf&scope=public_repo%20read:user%20user:email";

    if (await canLaunch(url)) {
      setState(() {
        loader = true;
      });
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
      );
    } else {
      setState(() {
        loader = false;
      });
      print("CANNOT LAUNCH THIS URL!");
    }
  }*/

  @override
  Widget build(BuildContext context) {
<<<<<<< Updated upstream
    //controladores
    bool isLoading = false;
    GoogleAuth googleAuth = GoogleAuth();

    TextEditingController txtConUser = TextEditingController();
    TextEditingController txtConPass = TextEditingController();

    final btnGoogle = SocialLoginButton(
      buttonType: SocialLoginButtonType.google,
      onPressed: () async {
        isLoading = true;
        setState(() {});
        await googleAuth.signInWithGoogle().then((value) {
          if (value.name != null) {
            isLoading = false;
            Navigator.pushNamed(context, '/dash', arguments: value);
          } else {
            isLoading = false;
            setState(() {});
            SnackBar(
              content: Text('Verifica tus credenciales'),
            );
          }
        });
      },
    );

    final txtRegister = Padding(
      padding: const EdgeInsets.symmetric(vertical: 25),
       child: TextButton(
        onPressed: () {
          Navigator.pushNamed(context, '/register');
          },
          child: const Text('Crear cuenta :)', style: TextStyle(fontSize: 18, decoration: TextDecoration.underline))));
=======
    const spaceHorizontal = SizedBox(height: 15);
>>>>>>> Stashed changes

    final txtEmail = TextFormField(
      controller: conEmail,
      decoration: const InputDecoration(label: Text('Email User'), enabledBorder: OutlineInputBorder()),
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
      decoration: const InputDecoration(label: Text('Password User'), enabledBorder: OutlineInputBorder()),
    );

    final btnLogin = SocialLoginButton(
      buttonType: SocialLoginButtonType.generalLogin,
      onPressed: () async {
        if (formKey.currentState!.validate()) {
          final emaiT = conEmail.text;
          final passT = conPass.text;
          if ("".compareTo(conEmail.text) == 0 ||
              "".compareTo(conPass.text) == 0) {
          } else {
            try {
                //FacebookAuth.instance.logOut();
              FirebaseAuth.instance.signOut();
              var ban = await FirebaseAuth.instance.signInWithEmailAndPassword(email: emaiT, password: passT);
              if (ban.user?.emailVerified ?? false) {
                Navigator.pushNamed(context, '/dash');
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Error: Verifica tu correo'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            } on FirebaseAuthException catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Error: Datos no validos'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          }
        }
          /*try{
                await emailAuth.singInWithEmailAndPassword(email: conEmail.text, password: conPass.text);
                Navigator.pushNamed(context, '/dash');
              } on FirebaseAuthException catch (e) {
                ErrorSummary(e.code);
              }*/
      }
        /*isLoading = true;
          setState(() {});
          Future.delayed(Duration(milliseconds: 3000)).then((value) {
            isLoading = false;
            setState(() {});
            Navigator.pushNamed(context, '/dash');
          });*/
    );

    Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      return await _auth.signInWithCredential(credential);
    } catch (error) {
      print("Error durante la autenticación con Google: $error");
      return null;
    }
  }

  final btnGoogle = SocialLoginButton(
        buttonType: SocialLoginButtonType.google,
        onPressed: () async {
          await emailAuth.signInWithGoogle(context);
          isLoading = true;
          setState(() {});
          Future.delayed(const Duration(milliseconds: 3000)).then((value) {
            isLoading = false;
            setState(() {});
            Navigator.pushNamed(context, '/dash');
          });
        });

    final btnGoogle2 = SocialLoginButton(
      buttonType: SocialLoginButtonType.google,
      onPressed: () async {
                UserCredential? userCredential = await signInWithGoogle();
                if (userCredential != null) {
                  // ignore: use_build_context_synchronously
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Un error ha ocurrido'),
                        content: Text('Error de autenticación con Google'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'OK',
                              style: TextStyle(
                                color: Colors.black, // Cambia el color a negro
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  Navigator.pushNamed(context, '/dash');
                  // Credenciales incorrectas, mostrar un showDialog
                  // ignore: use_build_context_synchronously
                }
              },);

        

    final btnFacebook = SocialLoginButton(
        buttonType: SocialLoginButtonType.facebook, onPressed: () {});

    final gitHubSignIn = GitHubSignIn(
        clientId: '4f9463d1d6916e0d1224',
        clientSecret: 'aa6fbae99f3c9c6e5205e30377815e1cd97dea7d',
        redirectUrl: 'https://pmsn2023-2.firebaseapp.com/__/auth/handler',
        title: 'GitHub Connection',
        centerTitle: false,
      );

    void _gitHubSignIn(BuildContext context) async {
    var result = await gitHubSignIn.signIn(context);
    switch (result.status) {
      case GitHubSignInResultStatus.ok:
        // Verifica si el Checkbox está marcado
        
        Navigator.pushReplacementNamed(context, '/dash');
        break;

      case GitHubSignInResultStatus.cancelled:
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Un error ha ocurrido'),
              content: Text('Error de autenticación con GitHub'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'OK',
                    style: TextStyle(
                      color: Colors.black, // Cambia el color a negro
                    ),
                  ),
                ),
              ],
            );
          },
        );
        break;
      case GitHubSignInResultStatus.failed:
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Un error ha ocurrido'),
              content: Text('Error de autenticación con GitHub'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'OK',
                    style: TextStyle(
                      color: Colors.black, // Cambia el color a negro
                    ),
                  ),
                ),
              ],
            );
          },
        );
        break;
    }
  }
        

    final btngithub = SocialLoginButton(
        buttonType: SocialLoginButtonType.github,
        onPressed: () async {
                _gitHubSignIn(context);
              },);

    final txtRegister = Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/register');
          },
          child: const Text('Crear cuenta :)',
              style: TextStyle(decoration: TextDecoration.underline))),
    );

    final btnForgot = TextButton(
      onPressed: () {
        Navigator.pushNamed(context, '/pwd');
      },
      child: const Text(
        "¿Olvidaste la constraseña?",
        style: TextStyle(color: Color.fromARGB(255, 126, 173, 255)),
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: responsive(
                    mobile: MobileLoginScreen(
                      spaceHorizontal: spaceHorizontal,
                      btnRegister: txtRegister,
                      txtEmail: txtEmail,
                      txtPass: txtPass,
                      btnLogin: btnLogin,
                      btnGoogle: btnGoogle,
                      btnFacebook: btnFacebook,
                      btngithub: btngithub,
                      btnForgot: btnForgot,
                    ),
                    desktop: Row(
                      children: [
<<<<<<< Updated upstream
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                              imglogo,
                              txtEmail,
                              spaceHorizontal,
                              txtPass,
                              spaceHorizontal,
                              session,
                              spaceHorizontal,
                              btnEmail,
                              spaceHorizontal,
                              btnGoogle,
                              txtRegister,
                              spaceHorizontal,
                              conocenos()
                          ],
=======
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: 450,
                                child: Center(child: TopLoginImage()),
                              ),
                              SizedBox(
                                  child: LoginScreenTopWidget(
                                spaceHorizontal: spaceHorizontal,
                                btnRegister: txtRegister,
                              ))
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 450,
                                child: LoginForm(
                                  txtEmail: txtEmail,
                                  spaceHorizontal: spaceHorizontal,
                                  txtPass: txtPass,
                                  btnLogin: btnLogin,
                                  btnGoogle: btnGoogle,
                                  btnFacebook: btnFacebook,
                                  btngithub: btngithub,
                                  btnForgot: btnForgot,
                                ),
                              ),
                            ],
                          ),
>>>>>>> Stashed changes
                        ),
                      ],
                    ),
                    tablet: Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: 450,
                                child: Center(child: TopLoginImage()),
                              ),
                              SizedBox(
                                  child: LoginScreenTopWidget(
                                spaceHorizontal: spaceHorizontal,
                                btnRegister: txtRegister,
                              ))
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 450,
                                child: LoginForm(
                                  txtEmail: txtEmail,
                                  spaceHorizontal: spaceHorizontal,
                                  txtPass: txtPass,
                                  btnLogin: btnLogin,
                                  btnGoogle: btnGoogle,
                                  btnFacebook: btnFacebook,
                                  btngithub: btngithub,
                                  btnForgot: btnForgot,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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

class MobileLoginScreen extends StatelessWidget {
  const MobileLoginScreen({
    super.key,
    required this.spaceHorizontal,
    required this.txtEmail,
    required this.txtPass,
    required this.btnLogin,
    required this.btnGoogle,
    required this.btnFacebook,
    required this.btngithub,
    required this.btnRegister,
    required this.btnForgot,
  });

  final SizedBox spaceHorizontal;
  final TextFormField txtEmail;
  final TextFormField txtPass;
  final SocialLoginButton btnLogin;
  final SocialLoginButton btnGoogle;
  final SocialLoginButton btnFacebook;
  final SocialLoginButton btngithub;
  final Padding btnRegister;
  final TextButton btnForgot;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const SizedBox(height: 100, child: TopLoginImage()),
            LoginScreenTopWidget(
                spaceHorizontal: spaceHorizontal, btnRegister: btnRegister),
            LoginForm(
                txtEmail: txtEmail,
                spaceHorizontal: spaceHorizontal,
                txtPass: txtPass,
                btnLogin: btnLogin,
                btnGoogle: btnGoogle,
                btnFacebook: btnFacebook,
                btngithub: btngithub,
                btnForgot: btnForgot),
          ]),
        ],
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    required this.txtEmail,
    required this.spaceHorizontal,
    required this.txtPass,
    required this.btnLogin,
    required this.btnGoogle,
    required this.btnFacebook,
    required this.btngithub,
    required this.btnForgot,
  });

  final TextFormField txtEmail;
  final SizedBox spaceHorizontal;
  final TextFormField txtPass;
  final SocialLoginButton btnLogin;
  final SocialLoginButton btnGoogle;
  final SocialLoginButton btnFacebook;
  final SocialLoginButton btngithub;
  final TextButton btnForgot;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        txtEmail,
        spaceHorizontal,
        txtPass,
        spaceHorizontal,
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
        ),
        btnLogin,
        spaceHorizontal,
        const Text(
          "or",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        btnGoogle,
        spaceHorizontal,
        btnFacebook,
        spaceHorizontal,
        btngithub,
        spaceHorizontal,
        btnForgot
      ],
    );
  }
}

class LoginScreenTopWidget extends StatelessWidget {
  const LoginScreenTopWidget({
    super.key,
    required this.spaceHorizontal,
    required this.btnRegister,
    //required this.btnAbout,
  });

  final SizedBox spaceHorizontal;
  final Padding btnRegister;
  //final Padding btnAbout;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        spaceHorizontal,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            btnRegister,
            //btnAbout,
          ],
        ),
      ],
    );
  }
}

class TopLoginImage extends StatelessWidget {
  const TopLoginImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/logoapp.png',
      height: 250,
    );
  }
}
