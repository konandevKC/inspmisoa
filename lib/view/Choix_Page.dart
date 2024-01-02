import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:misoainsp/view/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:misoainsp/view/auth/Resgister.dart';
import 'package:misoainsp/view/auth/login.dart';

import 'auth/menuPage.dart';


class ChoixPage extends StatefulWidget {
  const ChoixPage({super.key});

  @override
  State<ChoixPage> createState() => _ChoixPageState();
}

class _ChoixPageState extends State<ChoixPage> {
  @override
  Widget build(BuildContext context) {
     // L'utilisateur n'est pas connecté, rediriger vers la page de connexion
          return Scaffold(
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/user.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top:30,),
                    child:  Text(
                      'MISOA',
                      style: TextStyle(
                        fontFamily: 'beroKC',
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  const CircleAvatar(
                    backgroundImage: AssetImage('images/vrai.png'),
                    radius: 80,
                  ),
                  Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(280, 50),
                      primary: Colors.white,
                    ),
                    child: const Text(
                      "S'INSCRIRE",
                      style: TextStyle(
                        fontFamily: 'beroKC',
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () {
                      Get.to(RegisterView());
                    },
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(280, 50),
                      primary: Colors.white,
                    ),
                    child: const Text(
                      "SE CONNECTER",
                      style: TextStyle(
                        fontFamily: 'beroKC',
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () {
                      Get.to(LoginView());

                    },
                  ),
                  const SizedBox(height: 20),
                  const SizedBox(
                    height: 30.0,
                    child: Text(
                      'OU',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(280, 50),
                      side: const BorderSide(color: Colors.white),
                    ),
                    onPressed: () {
                      Get.to(const Circular());
                    },
                    child: const Text(
                      "CONSULTER",
                      style: TextStyle(
                        fontFamily: 'beroKC',
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Spacer()
                ],
              ),
            ),
          );
        }
}


class Circular extends StatefulWidget {
  const Circular({super.key});

  @override
  State<Circular> createState() => _CircularState();
}

class _CircularState extends State<Circular> {
  Future<bool> checkInternetConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    checkInternetConnectivity().then((internet) {
      if (internet == true) {
        Timer(
          const Duration(seconds: 2),
              () => Get.offAll(Menu()));
      } else {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text("Erreur de connexion"),
            content:
            const Text("Vérifiez votre connexion internet et réessayez."),
            actions: [
              TextButton(
                child: const Text("OK"),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: Colors.red,
            backgroundColor: Colors.blueGrey,
          ),
        ));
  }
}