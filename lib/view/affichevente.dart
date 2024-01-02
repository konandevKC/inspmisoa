import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class AfficheVent extends StatefulWidget {
  const AfficheVent({Key? key}) : super(key: key);

  @override
  State<AfficheVent> createState() => _AfficheVentState();
}

class _AfficheVentState extends State<AfficheVent> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('biens')
          .where('useruiid', isEqualTo: user!.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            var bien = snapshot.data!.docs[index];
            var imagePath = bien['image2'];

            final ref = FirebaseStorage.instance.ref().child(imagePath);

            // Utilisation de FutureBuilder pour obtenir l'URL de téléchargement
            return FutureBuilder<String>(
              future: ref.getDownloadURL(),
              builder: (context, urlSnapshot) {
                if (urlSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (urlSnapshot.hasError) {
                  return Text("Erreur lors du chargement de l'image ${bien['nature']}");
                } else {
                  final url = urlSnapshot.data;

                  return Card(
                    child: Column(
                      children: [
                        Image.network(url! , height: 200, fit: BoxFit.cover),
                        Text(bien['nature']),
                        Text(bien['description']),
                      ],
                    ),
                  );
                }
              },
            );
          },
        );
      },
    );
  }
}
