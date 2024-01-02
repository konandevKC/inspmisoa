
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:misoainsp/Controller/auth_controller.dart';
import 'package:misoainsp/view/auth/Resgister.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Choix_Page.dart';
import 'fongetPass.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool _obscureText = true;
  bool _isLoading = false;
   final AuthController _authController = Get.find();
  @override
  Widget build(BuildContext context) {
    double hauteur = MediaQuery.of(context).size.height;
    double largeur = MediaQuery.of(context).size.width;
    return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text('Connexion'),
              ),
              body: SingleChildScrollView(
                child: Column(children: [
                  SizedBox(
                    height: hauteur * 0.1,
                  ),
                  const Text(
                    'MISOA',
                    style: TextStyle(
                        fontFamily: 'beroKC',
                        fontSize: 30,
                        color: Colors.black),
                  ),
                  const CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://res.cloudinary.com/dgpmogg2w/image/upload/v1683569192/vrai_vsctog.png'),
                    radius: 70,
                  ),
                  SizedBox(
                    height: hauteur * 0.1,
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Form(
                            key: _formKey,
                            child: Column(children: [
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: _email,
                                style: const TextStyle(
                                    color:
                                    Colors.black),
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1,
                                          color: Colors.black,
                                          style: BorderStyle.solid)),
                                  labelText: 'Email',
                                  labelStyle: TextStyle(
                                      color:
                                      Colors.black),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Veuillez entrer votre email';
                                  } else if (!RegExp(
                                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                      .hasMatch(value)) {
                                    return 'Veuillez entrer un email valide';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                  style: const TextStyle(
                                      color:
                                      Colors.black),
                                  obscureText: _obscureText,
                                  controller: _password,
                                  decoration: InputDecoration(
                                    hoverColor: Colors.black,
                                    border: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1,
                                            color: Colors.black)),
                                    labelText: 'Mot de passe',
                                    labelStyle: const TextStyle(
                                        color: Colors.black),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _obscureText = !_obscureText;
                                        });
                                      },
                                      icon: Icon(
                                          _obscureText
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: Colors.black
                                      ),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Veuillez entrer votre mot de passe';
                                    } else if (value.length < 6) {
                                      return 'Le mot de passe doit comporter au moins 6 caractères';
                                    } else if (value.length > 10) {
                                      return 'Le mot de passe doit etre compris entre 6 et 10 caractères';
                                    }
                                    return null;
                                  }),
                              Align(
                                alignment: Alignment.topRight,
                                child: InkWell(

                                  child: const Text(
                                    "Mot de pass oublié?",
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontFamily: 'beroKC',
                                      fontSize: 15,
                                    ),
                                  ),
                                  onTap: () {
                                  Get.to(ForgotPasswordScreen());
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: largeur * 0.8,
                                height: largeur * 0.13,
                                margin: EdgeInsets.only(top: 10),
                                padding: EdgeInsets.only(left: 10),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:  Colors.red
                                  ),
                                  onPressed: _isLoading
                                      ? null
                                      : () async {
                                    if (_formKey.currentState
                                        ?.validate() ??
                                        false) {
                                      setState(() {
                                        _isLoading = true;
                                      });

                                      await _authController.signIn(_email.text , _password.text).then((value) {
                                        setState(() {
                                          _isLoading = false;
                                        });
                                      });
                                    }
                                  },
                                  child: _isLoading
                                      ? const CircularProgressIndicator()
                                      : const Text('Se connecter',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontFamily: 'beroKC')),
                                ),
                              ),
                              const SizedBox(height: 10),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text('Vous êtes  nouveau ?',style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'beroKC',
                                    fontSize: 15,
                                  ),),
                                  InkWell(
                                    child: const Text(
                                      " Je cree un compte",
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontFamily: 'beroKC',
                                        fontSize: 15,
                                      ),
                                    ),
                                    onTap: () {
                                      Get.to(RegisterView());
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                            /*  const Row(
                                children: [
                                  SizedBox(width: 60),
                                  InkWell(
                                    child: CircleAvatar(
                                      backgroundImage:
                                      AssetImage('images/ikon.png'),
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  InkWell(
                                    child: CircleAvatar(
                                      backgroundImage:
                                      AssetImage('images/insta.png'),
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  InkWell(
                                    child: CircleAvatar(
                                      backgroundImage:
                                      AssetImage('images/in.png'),
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  InkWell(
                                    child: CircleAvatar(
                                      backgroundImage:
                                      AssetImage('images/go.png'),
                                    ),
                                  )
                                ],
                              )*/
                            ]),
                          ),
                        ),
                      ],
                    ),
                  )
                ]),
              ),
            ),

          );
        }

}