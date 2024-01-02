import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:misoainsp/view/auth/login.dart';
import 'package:misoainsp/view/auth/menuPage.dart';

import 'Choix_Page.dart';


class splashcreen extends StatefulWidget {
  const splashcreen({super.key});

  @override
  State<splashcreen> createState() => _splashcreenState();
}

class _splashcreenState extends State<splashcreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    Future.delayed(Duration(milliseconds: 5000), () {
      User? user = _auth.currentUser;
      // Vérifiez ici si un utilisateur est connecté (par exemple, en utilisant FirebaseAuth).
      bool isUserLoggedIn = false; // Mettez à jour en fonction de la logique de connexion

      // Redirigez l'utilisateur vers la page d'accueil ou de connexion
      if (user != null) {
        Get.offAll(const Menu());
      } else {
        Get.offAll(const ChoixPage());
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/test.gif"),
            fit: BoxFit.cover,
          ),
        ),
        child: null /* add child content here */,
      ),
    );
  }
}