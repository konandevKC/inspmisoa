import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PropertyRelookingRequest {
  String propertyName;
  String propertyAddress;
  String additionalDetails;

  PropertyRelookingRequest({
    required this.propertyName,
    required this.propertyAddress,
    required this.additionalDetails,
  });
}

class RelookingDialog extends StatefulWidget {
  @override
  _RelookingDialogState createState() => _RelookingDialogState();
}

class _RelookingDialogState extends State<RelookingDialog> {
  final _formKey = GlobalKey<FormState>();
  // Obtenir la date actuelle
  DateTime Now = DateTime.now();

  // Formater la date pour exclure les heures
  String formattedDate = DateFormat.yMMMd().format(DateTime.now());
  final _relookingRequest =
  PropertyRelookingRequest(additionalDetails: '', propertyAddress: '', propertyName: '');
  final user = FirebaseAuth.instance.currentUser;

  // Référence à la collection Firestore
  final CollectionReference _relookingCollection = FirebaseFirestore.instance.collection('relooking');

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Demande de relooking'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Nom du bien'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Veuillez entrer le nom du bien immobilier.';
                }
                return null;
              },
              onSaved: (value) {
                _relookingRequest.propertyName = value!;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Adresse du bien'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Veuillez entrer l\'adresse du bien immobilier.';
                }
                return null;
              },
              onSaved: (value) {
                _relookingRequest.propertyAddress = value!;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Détails supplémentaires'),
              onSaved: (value) {
                _relookingRequest.additionalDetails = value!;
              },
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          child: Text('Annuler'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
          child: Text('Envoyer'),
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();

              // Enregistrement des données dans Firebase
              await _relookingCollection.add({
                'userid':user!.uid,
                'propertyName': _relookingRequest.propertyName,
                'propertyAddress': _relookingRequest.propertyAddress,
                'additionalDetails': _relookingRequest.additionalDetails,
                'dateCreate': formattedDate
              });

              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}
