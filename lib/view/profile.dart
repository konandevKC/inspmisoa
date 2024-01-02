import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:misoainsp/view/auth/login.dart';
import 'package:misoainsp/view/detail_user_page.dart';
import 'package:misoainsp/view/vendt_page.dart';

import 'affichevente.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  int _selectedIndex = 0;
  String _username = "";
  String prenom = "";
  String numero = "";

  String localisa = "";

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final user = FirebaseAuth.instance.currentUser;
  final usersRef = FirebaseFirestore.instance.collection('users');

  String uid = '';
  dynamic userDoc;


  Future<void> _signOut() async {
    try {
      await _auth.signOut();
      Get.offAll(LoginView());
      print('Utilisateur déconnecté');
    } catch (e) {
      print('Erreur lors de la déconnexion : $e');
    }
  }
  void _showSimulationDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {

          return  AlertDialog(
            title: Text('Deconnexion',style: TextStyle(color: Colors.red,fontSize: 16),),
            content: Text('Voulez vous quitter  Misoa?'),
            actions: [
              TextButton(onPressed: ()=>Get.back(), child: Text('NON'),),
              TextButton(onPressed: ()=>_signOut(), child: Text('Oui'),)
            ],

          );
        }
    )
    ;}
  @override
  void initState() {
    super.initState();
    getUserDoc();
    checkUser();
  }
 Future<void> checkUser() async {
    final currentUser = _auth.currentUser;
    if (currentUser == null) {
      // Aucun utilisateur connecté, rediriger vers la page de connexion
      Get.offAll(LoginView());
    } else {
      uid = currentUser.uid;
      getUserDoc();
    }
  }

  Future<void> getUserDoc() async {
    final userSnapshot = await usersRef.doc(user!.uid).get();
    print('*****************$uid');


    if (userSnapshot.exists) {
      final userData = userSnapshot.data() as Map<String, dynamic>;

      setState(() {
        _username = userData['nom'] ?? CircularProgressIndicator(backgroundColor: Colors.amber,); // Remplacez 'nom' par le champ approprié
        prenom = userData['prenom'] ?? CircularProgressIndicator(backgroundColor: Colors.amber,); // Remplacez 'prenom' par le champ approprié
        localisa = userData['localisation'] ?? CircularProgressIndicator(backgroundColor: Colors.amber,); // Remplacez 'adresse' par le champ approprié
        numero = userData['numero'] ?? CircularProgressIndicator(backgroundColor: Colors.amber,);
      });

    }
  }

  final List<Widget> _widgetOptions = <Widget>[
    Detail(),
    AfficheVent(),
    VentePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double enhaut = MediaQuery.of(context).size.height;
    double largeur = MediaQuery.of(context).size.width;
    
  return Scaffold(
      body: SizedBox(
        height: enhaut,
        width: largeur,
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Stack(children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.25,
              width: largeur,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.red, Colors.redAccent],
                    end: Alignment.bottomCenter,
                    begin: Alignment.topCenter),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50)),
              ),
            ),
            const Positioned(
              top: 10,
              left: 140,
              right: 150,
              child: Text(
                'Profile',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 24, fontFamily: 'beroKC', color: Colors.white),
              ),
            ),
            const Positioned(
              top: 40,
              left: 150,
              right: 150,
              child: Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('images/p.jpg'),
                ),
              ),
            ),
            Positioned(
              bottom: 30,
              left: 40,
              right: 50,
              child: Text(
                '$_username $prenom',
                style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'beroKC'),
                textAlign: TextAlign.center,
              ),
            )
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  IconButton(
                    icon: Icon(Icons.person_pin_outlined),
                    color: _selectedIndex == 0 ? Colors.red : Colors.grey,
                    onPressed: () {
                      _onItemTapped(0);
                    },
                  ),
                  Text(
                    'Profile',
                    style: TextStyle(
                      color: _selectedIndex == 0 ? Colors.red : Colors.grey,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  IconButton(
                    icon: const Icon(Icons.add_box),
                    color: _selectedIndex == 1 ? Colors.red : Colors.grey,
                    onPressed: () {
                      _onItemTapped(1);
                    },
                  ),
                  Text(
                    'Mes Posts',
                    style: TextStyle(
                      color: _selectedIndex == 1 ? Colors.red : Colors.grey,
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  IconButton(
                    icon: const Icon(Icons.sell_rounded),
                    color: _selectedIndex == 2 ? Colors.red : Colors.grey,
                    onPressed: () {
                      _onItemTapped(2);
                    },
                  ),
                  Text(
                    'vendre',
                    style: TextStyle(
                      color: _selectedIndex == 2 ? Colors.red : Colors.grey,
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  IconButton(
                    icon: const Icon(Icons.logout_outlined),
                    color: _selectedIndex == 3 ? Colors.red : Colors.grey,
                    onPressed: _showSimulationDialog
                  ),
                  Text(
                    'Logout',
                    style: TextStyle(
                      color: _selectedIndex == 3 ? Colors.red : Colors.grey,
                    ),
                  )
                ],
              ),
            ],
          ),
          Expanded(
            child: Center(
              child: _widgetOptions.elementAt(_selectedIndex),
            ),
          ),
        ]),
      ));
  }
}