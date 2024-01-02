import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:misoainsp/view/auth/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class FullScreenImage extends StatefulWidget {
  final String imageUrl;
  final String descri;
  final String loca;
  final String status;
  const FullScreenImage(
      {super.key,
      required this.imageUrl,
      required this.descri,
      required this.loca,
      required this.status});

  @override
  State<FullScreenImage> createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> {
  final user = FirebaseAuth.instance.currentUser;
  bool _isInterested = false;
  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_null_comparison
    if (user!.uid != null) {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.red,
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Card(
                child:
                    Column(mainAxisSize: MainAxisSize.min, children: <Widget>[

                  Stack(
                    children: [

                     Image.network(
                      widget.imageUrl,
                      fit: BoxFit.cover,
                      height: 400,
                      width: 400,
                    ),
                      const Positioned(
                          top: 20,
                          right: 10,
                          child: InkWell(
                            child: Icon(Icons.favorite_border, size: 25,color: Colors.red,)
                            ,)
                      ),
                ]
                  ),
                      SizedBox(
                        height: 10,
                      ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(width: 2, color: Colors.white30)
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.bedroom_parent,color: Colors.white,),Text('3 chambre',style: TextStyle(color: Colors.white),)
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(width: 2, color: Colors.white30)
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.bathtub,color: Colors.white),Text('2 douche',style: TextStyle(color: Colors.white),)
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(width: 2, color: Colors.white30)
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.car_repair,color: Colors.white),Text('2 Garage',style: TextStyle(color: Colors.white),)
                          ],
                        ),
                      ),
                    ],
                  ),
                  ListTile(
                    leading: const Icon(Icons.description),
                    title: const Text('Description'),
                    subtitle: Text(widget.descri),
                  ),
                  ListTile(
                    leading: const Icon(Icons.location_on),
                    title: const Text('Localisation'),
                    subtitle: Text(widget.loca),
                  ),
                  ListTile(
                    leading: const Icon(Icons.leave_bags_at_home),
                    title: const Text('status'),
                    subtitle: Text(widget.status),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      StatefulBuilder(
                        builder: (context, setState) {
                          return SizedBox(
                            width: MediaQuery.of(context).size.width * 0.45,
                            height: 60,
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _isInterested = true;
                                });
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text('Intéressé'),
                                      content: const Text(
                                          'Vous êtes maintenant intéressé !'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor:
                                    _isInterested ? Colors.green : Colors.red,
                              ),
                              child: Text(
                                  _isInterested ? 'Intéressé !' : 'Intéresser'),
                            ),
                          );
                        },
                      ),

                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.45,
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () async {
                            // launch('tel//$number');
                            // await FlutterPhoneDirectCaller.callNumber(number);
                            final Uri url = Uri(
                              scheme: 'tel',
                              path: "+2250709171734",
                            );
                            if (await canLaunchUrl(url)) {
                              await launchUrl(url);
                            } else {
                              print('Le numero ne fonction plus');
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 24, 82, 255),
                              maximumSize: Size(180, 40)),
                          child: const Row(
                            children: [
                              Icon(
                                Icons.phone,
                                size: 40,
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                              Text(
                                'Telephone',
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ]),
              ),
            ),
          ));
    } else {
      // L'utilisateur n'est pas connecté, rediriger vers la page de connexion
      return const LoginView();
    }
  }
}
