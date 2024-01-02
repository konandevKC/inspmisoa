import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:misoainsp/Controller/auth_controller.dart';

class ListeBiensPage extends StatefulWidget {
  const ListeBiensPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ListeBiensPageState createState() => _ListeBiensPageState();
}

class _ListeBiensPageState extends State<ListeBiensPage> {
  AuthController monController = AuthController();

  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Padding(
          padding: EdgeInsets.all(20.0),
          child: Text('Liste des Biens',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
        ),
        elevation: 0,
      ),
      backgroundColor:  Color(0xFFF1F1F1),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('properties')
            .where('iduser', isEqualTo: user!.uid)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Erreur de chargement des données'),
            );
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('Aucun bien trouvé'),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var bien = snapshot.data!.docs[index];
                return Dismissible(
                  key: Key(bien.id),
                  background: Container(
                    color: Colors.red,
                    // ignore: sort_child_properties_last
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 30,
                    ),
                    
                    padding: const EdgeInsets.only(right: 10),
                  ),
                  onDismissed: (direction) {
                    // Supprimer le bien
                    FirebaseFirestore.instance
                        .collection('properties')
                        .doc(bien.id)
                        .delete();
                  },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child:  Column(
                          children: [
                      Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 6 ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(width: 1, color: Colors.black12)),

                              child: ListTile(
                                title: Text(bien['typeBien']),
                                subtitle: Text(bien['selectedLocalite']),
                                leading: const Icon(
                                  Icons.search_outlined,
                                  size: 30,
                                  color: Colors.redAccent,
                                ),
                                trailing: Text('${bien['prixMax'].toString()} FCFA'), // Ajoutez d'autres éléments à afficher ici
                              ),
                            ),
                            Container(
                              height: 5,
                              width: MediaQuery.of(context).size.width * 0.96,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: const BorderRadius.only(bottomRight: Radius.circular(50), bottomLeft: Radius.circular(30))
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child:Text("Publier le:${bien['dateCreate'].toString()}",style: TextStyle(fontSize: 10),)
                              ,
                            )
                          ],
                        ),
                      ),

                  );
              },
            );
          }
        },
      ),
    );
  }
}
