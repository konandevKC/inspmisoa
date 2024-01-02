import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:misoainsp/view/content/listeDemande.dart';

class RechercheController extends GetxController {


  // Référence à la collection Firestore
  final CollectionReference propertiesCollection = FirebaseFirestore.instance.collection('properties');
  final user = FirebaseAuth.instance.currentUser;
  String formattedDate = DateFormat.yMMMd().format(DateTime.now());
  // Fonction pour insérer les informations dans Firestore
  Future<void> insertData(String typeBien,String nombreChambres,String nombredouche,String prixMax,String selectedLocalite  ) async {
    try {
      await propertiesCollection.add({
        'typeBien': typeBien,
        'nombreChambres': nombreChambres,
        'nombredouche': nombredouche,
        'prixMax': prixMax,
        'selectedLocalite': selectedLocalite,
        'iduser': user!.uid,
        'dateCreate': formattedDate
      });
      // Réinitialisez les valeurs du formulaire après l'insertion
      Get.snackbar('Succès', 'Données insérées avec succès', colorText: Colors.white,backgroundColor: Colors.green,);
      Get.to(ListeBiensPage());
    } catch (error) {
      Get.snackbar('Erreur', 'Une erreur s\'est produite lors de l\'insertion des données',colorText: Colors.white,backgroundColor: Colors.red);
    }
  }
}
