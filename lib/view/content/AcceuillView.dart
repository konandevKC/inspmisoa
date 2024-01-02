import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:misoainsp/view/content/listeview.dart';

import '../../Controller/auth_controller.dart';
import '../produit/achatView.dart';
import 'ConseilPage.dart';
import 'askrelooking.dart';

class AcceuilView extends StatefulWidget {
  const AcceuilView({super.key});

  @override
  State<AcceuilView> createState() => _AcceuilViewState();
}

class _AcceuilViewState extends State<AcceuilView> {
  final AuthController _authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    double hauteur = MediaQuery.of(context).size.height;
    double largeur = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: hauteur,
        width: largeur,
        decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage('images/co.jpg'))),
        child: Column(
          children: [
            Obx(() {
              if (_authController.user.value == null) {
                return Text('Vous n\'êtes pas connecté.');
              } else {
                return FutureBuilder<DocumentSnapshot>(
                  future: FirebaseFirestore.instance
                      .collection('users')
                      .doc(_authController.user.value!.uid)
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Erreur : ${snapshot.error}');
                    } else {
                      final userData = snapshot.data;
                      return Container(
                        color: Colors.red,
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            const CircleAvatar(
                              radius: 30,
                              backgroundImage: AssetImage('images/p.jpg'),
                            ),
                            SizedBox(width: 8),
                            Text(
                              '${userData!['nom']} ${userData['prenom']}',
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Spacer(),
                            const Icon(
                              Icons.notifications_active,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      );
                    }
                  },
                );
              }
            }),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Get.to(AchatPage(titre: 'Achat' ));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            image: const DecorationImage(
                                image: AssetImage('images/ad4.jpg')),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.shopping_cart,
                                  size: 50, color: Colors.white),
                              SizedBox(height: 8),
                              Text(
                                'Achat',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Get.to(AchatPage(titre : 'Location'));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            image: const DecorationImage(
                                image: AssetImage('images/ad3.png')),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.key, size: 50, color: Colors.white),
                              SizedBox(height: 8),
                              Text(
                                'Location',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: InkWell(
                      onTap: () {
                        Get.to(const ConseilPage());
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          image: const DecorationImage(
                              image: AssetImage('images/ad1.png')),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 30, horizontal: 40),
                        child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.support_agent_outlined,
                                size: 50,
                                color: Colors.white,
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Conseil',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ]),
                      ),
                    )),
                    const SizedBox(width: 20),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            image: const DecorationImage(
                                image: AssetImage('images/ad2.png')),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          child: InkWell(
                            onTap: () {
                             Get.to(RelookingList());
                            },
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.palette,
                                  size: 50,
                                  color: Colors.white,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Relooking',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
