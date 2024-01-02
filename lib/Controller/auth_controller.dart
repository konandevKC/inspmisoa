import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:misoainsp/view/auth/login.dart';

import '../view/auth/menuPage.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Rx<User?> user = Rx<User?>(null);
  DateTime maint = DateTime.now();

  @override
  void onInit() {
    super.onInit();
    user.bindStream(_auth.userChanges());
  }

  Future<void> signUp(String email, String password, String nom, String prenom,
      String localisation, String numero) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      // Enregistrez les informations utilisateur dans Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'nom': nom,
        'prenom': prenom,
        'localisation': localisation,
        'numero': numero,
        'email': email,
        'password': password,
        'Uiid': userCredential.user!.uid,
        'dateCreate': DateTime.now()
      });
      Get.snackbar("Félicitation", "Inscription reussie",
          colorText: Colors.white, backgroundColor: Colors.green);
      Get.offAll(const LoginView());
    } catch (e) {
      Get.snackbar("Erreur d'inscription", "Veillez reessayer plus tard", colorText: Colors.white, backgroundColor: Colors.red, );
      print("*******************$e");
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Get.snackbar("Félicitation", "Vous  êtes connecté",
          colorText: Colors.white, backgroundColor: Colors.green);
      Get.offAll(Menu());
    } catch (e) {
      Get.snackbar("Erreur de connexion", "Mot de pass ou email incorrect",
          colorText: Colors.white, backgroundColor: Colors.red, );
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<Map<String, dynamic>?> getUserInfo() async {
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        // Utilisez le uid de l'utilisateur actuel pour récupérer les données de Firestore
        DocumentSnapshot userDoc =
            await _firestore.collection('users').doc(currentUser.uid).get();

        // Vérifiez si les données existent
        if (userDoc.exists) {
          Map<String, dynamic> userData =
              userDoc.data() as Map<String, dynamic>;
          return userData;
        } else {
          return null; // Aucune donnée trouvée pour cet utilisateur
        }
      } else {
        return null; // Aucun utilisateur connecté
      }
    } catch (e) {
      print(
          "Erreur lors de la récupération des informations de l'utilisateur : $e");
      return null;
    }
  }
}
