

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:flutter/material.dart';

import '../../Controller/auth_controller.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  bool isDark = false;
  bool isActive = false;
  TextEditingController pseudo = TextEditingController();
  TextEditingController localisa = TextEditingController();
  TextEditingController nom = TextEditingController();
  TextEditingController nmero = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController repass = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _areNotificationsEnabled = true;
  int? userId;
  String thereponse = "";
  bool _isLoading = false;
  bool _obscureText = true;
  bool _ferme = true;
  final AuthController _authController = Get.find();
  void clear() {
    localisa.clear();
    pseudo.clear();
    nom.clear();
    email.clear();
    nmero.clear();
    pass.clear();
    repass.clear();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/co.jpg'),
              fit: BoxFit.cover,
              opacity: 1.0,
              repeat: ImageRepeat.noRepeat,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  'Inscription',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'beroKC',
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),

                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(children: [
                        TextFormField(
                          autocorrect: true,
                          controller: pseudo,
                          decoration: const InputDecoration(
                            label: Text('PRENOM'),
                            enabledBorder: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Veuillez entrer votre prenom svp';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          autocorrect: true,
                          controller: nom,
                          decoration: const InputDecoration(
                            label: Text('NOM'),
                            enabledBorder: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Veuillez entrer votre nom svp';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          autocorrect: true,
                          controller: localisa,
                          decoration: const InputDecoration(
                            label: Text('Localisation'),
                            hintText: 'Abidjan,Côte D\'Ivoire',
                            enabledBorder: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Veuillez entrer une localisation svp';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(
                          height: 10,
                        ),
                        IntlPhoneField(
                          controller: nmero,
                          languageCode : 'fr',
                          searchText : 'Chercher votre pays',
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                          ],
                          decoration: const InputDecoration(
                            label: Text('Numero'),
                            enabledBorder: OutlineInputBorder(),
                          ),
                          invalidNumberMessage : 'Numéro de téléphone invalide',
                          initialCountryCode: 'CI',
                          onCountryChanged: (countryCode){
                            print(countryCode.displayCC);
                            print(countryCode.dialCode);
                            print(countryCode.regionCode);
                            print(countryCode.code);
                          },
                          onChanged: (phone) {
                            print(phone.completeNumber);
                          },
                        ),

                        /*TextFormField(
                            controller: nmero,
                            autocorrect: true,
                            decoration: const InputDecoration(
                              label: Text('Numero'),
                              enabledBorder: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Veuillez entrer votre numéro svp';
                              }
                              if (!value.startsWith("+22501") &&
                                  !value.startsWith("+22505") &&
                                  !value.startsWith("+22507")) {
                                return 'Le numéro doit commencer par +22501, +22505 ou +22507';
                              }
                              if (value.length != 14) {
                                return 'Le numéro doit contenir 14 caractères au total';
                              }
                              return null;
                            },
                          ),
                        ),*/

                        TextFormField(
                          autocorrect: true,
                          controller: email,
                          style: const TextStyle(color: Colors.black),
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(color: Colors.black),
                            enabledBorder: OutlineInputBorder(),
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
                            style: const TextStyle(color: Colors.black),
                            controller: repass,
                            obscureText: _obscureText,
                            decoration: InputDecoration(
                              labelText: 'Mot de passe',
                              labelStyle:
                              const TextStyle(color: Colors.black),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
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
                                  color: Colors.black,
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
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: pass,
                          style: const TextStyle(color: Colors.black),
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Comfirme Mot de passe',
                            labelStyle: TextStyle(color: Colors.black),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _ferme = !_ferme;
                                });
                              },
                              icon: Icon(
                                _ferme
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.black,
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
                          },
                        ),

                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                            "J'accepte tout les conditions d'utilisation que l'application  "),
                        SwitchListTile(
                          title: const Text(
                              ' Misao offre pour la securité de vos donnée'),
                          value: _areNotificationsEnabled,
                          onChanged: (value) {
                            setState(() {
                              _areNotificationsEnabled = value;
                            });
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child:  _isLoading
                              ? const CircularProgressIndicator()
                              :  Container(
                            height: MediaQuery.of(context).size.height * 0.08,
                            width: MediaQuery.of(context).size.width * 0.8,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(20)),
                            child: InkWell(

                              onTap: _isLoading
                                  ? null
                                  : () async {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  setState(() {
                                    _isLoading = true;
                                  });

                                  await _authController.signUp(email.text,pass.text,nom.text,pseudo.text,localisa.text,nmero.text).then((value) {
                                    setState(() {
                                      _isLoading = false;
                                    });
                                  });

                                }
                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                                child: Text(
                                  "S'inscrire",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'beroKC',
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]),
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