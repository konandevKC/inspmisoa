import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:misoainsp/view/auth/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../auth/menuPage.dart';

class Location extends StatefulWidget {
  final String descri;
  final String loca;
  final String prix;
  final String status;

  const Location({
    required this.descri,
    required this.loca,
    required this.prix,
    required this.status,
  });

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  final _controller = PageController();
  int _currentCard = 0;
  bool _answer1 = false;
  bool _answer2 = false;

  void _nextCard(bool answer) {
    setState(() {
      if (_currentCard == 0) {
        _answer1 = answer;
      } else if (_currentCard == 1) {
        _answer2 = answer;
      }
      _currentCard++;
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  Future<void> _insertLocation() async {
    try {
      // Utilisez Firestore pour insérer les données
      await FirebaseFirestore.instance.collection('locations').add({
        'userid':user!.uid,
        'descri': widget.descri,
        'loca': widget.loca,
        'prix': widget.prix,
        'status': widget.status,
      });

      _showCongratulationsDialog();
    } catch (e) {
      print('Erreur lors de l\'insertion des données : $e');
      // Gérer l'erreur
    }
  }

  void _showCongratulationsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.green,
          title: const Text(
            'Félicitations!',
            style: TextStyle(fontSize: 20, fontFamily: 'devKC'),
          ),
          content: Text(
            'Vous venez de lancer une Procedure ${widget.status};.',
            style: const TextStyle(color: Colors.white),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Menu()),
                );
              },
              child: const Icon(
                Icons.arrow_back,
                size: 30,
              ),
            ),
          ],
        );
      },
    );
  }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: ElevatedButton(
//           onPressed: _insertLocation,
//           child: const Text('Ajouter Location'),
//         ),
//       ),
//     );
//   }
// }
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_null_comparison
    if (user!.uid != null) {
          return Center(
            child: Expanded(
              child: PageView(
                controller: _controller,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('images/az.jpg'),
                            fit: BoxFit.cover,
                            opacity: 1.0,
                            repeat: ImageRepeat.noRepeat,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Card(
                                color: Colors.grey,
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Ci-dessous les informations de votre choix de bien immobilier: Demande d(e)  ${widget.status} un(e) ${widget.descri}:Localiser A ${widget.loca}  Cliquez sur suivant si vous êtres sure de la veracité de ceux-ci sinon cliquez sur précédent pour aller les corriger",
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                      const SizedBox(height: 20),
                                      Row(
                                        children: [
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.red,
                                            ),
                                            child: const Text('Retour'),
                                            onPressed: () {
                                              Navigator.pop(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                  const Menu(),
                                                ),
                                              );
                                            },
                                          ),
                                          SizedBox(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                                  0.4),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.green,
                                            ),
                                            child: const Text('Suivant'),
                                            onPressed: () => _nextCard(true),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (_answer1)
                    SafeArea(
                      child: Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('images/az.jpg'),
                            fit: BoxFit.cover,
                            opacity: 1.0,
                            repeat: ImageRepeat.noRepeat,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                color: Colors.grey,
                                elevation: 20,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    const Text(
                                      "La politique de confidencialité de MISOA lui permet de garder vos données, MISOA vous demande l'autorisation d'utiliser vos données personnelles afin d'améliorer votre expérience client",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20),
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      children: [
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.red),
                                            child: const Text('retour'),
                                            onPressed: () {
                                              Navigator.pop(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                  const Menu(),
                                                ),
                                              );
                                            }),
                                        SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.4),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.green),
                                          child: const Text('Suivent'),
                                          onPressed: () => _nextCard(true),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  if (_answer1 && _answer2)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('images/az.jpg'),
                            fit: BoxFit.cover,
                            opacity: 1.0,
                            repeat: ImageRepeat.noRepeat,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Card(
                              color: Colors.grey,
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    "Vous Prenez l'engagement que cette precedure aboudira a un(e) ${widget.status};",
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    children: [
                                      const SizedBox(height: 10),
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.red),
                                          child: const Text('retour'),
                                          onPressed: () {
                                            Navigator.pop(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                const Menu(),
                                              ),
                                            );
                                          }),
                                      const SizedBox(
                                        width: 80,
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.green),
                                        child: const Text('Oui'),
                                        onPressed: () => _insertLocation(),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ].map((Widget child) {
                  return Flexible(child: child);
                }).toList(),
              ),
            ),
          );
        } else {
          // L'utilisateur n'est pas connecté, rediriger vers la page de connexion
          return const LoginView();
        }
      }

  }


