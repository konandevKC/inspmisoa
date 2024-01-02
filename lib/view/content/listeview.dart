import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:misoainsp/view/content/askrelooking.dart';

class RelookingList extends StatefulWidget {
  @override
  _RelookingListState createState() => _RelookingListState();
}

class _RelookingListState extends State<RelookingList> {
  final user = FirebaseAuth.instance.currentUser;

  // Référence à la collection Firestore
  final CollectionReference _relookingCollection =
      FirebaseFirestore.instance.collection('relooking');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Text('Demandes de relooking'),
        ),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 20,
            ),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              child: Center(
                child: IconButton(
                  icon: const Icon(
                    Icons.add,
                    color: Colors.black,
                    size: 28,
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return RelookingDialog();
                      },
                    );
                  },
                ),
              ),
            ),
          )
        ],
      ),
      backgroundColor:  Color(0xFFF1F1F1),
      body: StreamBuilder(
        stream: _relookingCollection
            .where('userid', isEqualTo: user!.uid)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var relookingData = snapshot.data!.docs[index].data() as Map;
                return Dismissible(
                  key: Key(relookingData['propertyName']), // Correction ici
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  onDismissed: (direction) {
                    // Supprimer le bien
                    FirebaseFirestore.instance
                        .collection('relooking')
                        .doc(snapshot.data!.docs[index].id)
                        .delete();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(
                             horizontal: 6 ),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(width: 1, color: Colors.black12)),
                          child: ListTile(
                            title: Text(relookingData['propertyName'],style: TextStyle(color: Colors.blue),),
                            subtitle: Text(relookingData['additionalDetails'],style: TextStyle(color: Colors.blue),),
                            trailing: SizedBox(
                            width: 110,
                           child: Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                           Column(
                           crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Icon(Icons.location_on,color: Colors.blue,),
                      Text(relookingData['propertyAddress'],style: TextStyle(color: Colors.blue),),
                    ],
                  ),

                        ])
                ])
                            ),
                            leading: const Icon(
                              Icons.palette,
                              color: Colors.redAccent,
                              size: 30,
                            ),
                          ),
                        ),
                        Container(
                          height: 5,
                          width: MediaQuery.of(context).size.width * 0.93,
                          decoration: const BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(50), bottomLeft: Radius.circular(30))
                          ),
                        ),
                Align(
                alignment: Alignment.topRight,
                child:Text("Publier le:${relookingData['dateCreate'].toString()}",style: TextStyle(fontSize: 10),)
                ,
                )
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Une erreur s\'est produite.'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
