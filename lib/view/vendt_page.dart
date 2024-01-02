import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io' as Io;

class VentePage extends StatefulWidget {
  const VentePage({super.key});

  @override
  State<VentePage> createState() => _VentePageState();
}

class _VentePageState extends State<VentePage> {
  Uint8List? image;
  Uint8List? file;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController natureController = TextEditingController();
  TextEditingController localistController = TextEditingController();
  TextEditingController descripController = TextEditingController();
  bool _isLoading = false;
  final user = FirebaseAuth.instance.currentUser;

  void clear() {
    descripController.clear();
    localistController.clear();
    natureController.clear();
    image = null;
    file = null;
  }
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;

      final imageTemporary = await image.readAsBytes();
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      // Gérer les erreurs si nécessaire
    }
  }

  Future pickchoose() async {
    try {
      final file = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (file == null) return;

      final fileTemporary = await file.readAsBytes();
      setState(() => this.file = fileTemporary);
    } on PlatformException catch (e) {
      // Gérer les erreurs si nécessaire
    }
  }

  Future<String?> uploadImage(Uint8List? imageData) async {
    if (imageData == null) {
      print('*************image null');
      // Gérer le cas où aucune image n'est sélectionnée
      return null;
    }

    try {
      final storageReference =
      FirebaseStorage.instance.ref().child('images/${DateTime.now().millisecondsSinceEpoch}');
      print('*************$storageReference');
      await storageReference.putData(imageData);
      return storageReference.getDownloadURL();
    } catch (e) {
      return null;
    }
  }

  Future<void> submitForm() async {
    // Dans la méthode submitForm()
    setState(() {
      _isLoading = true;
    });
    final ref = FirebaseFirestore.instance.collection('biens');

    // Téléchargement et récupération des liens des images
    String? imageUrl;
    if (file != null) {
      imageUrl = await uploadImage(file);
    }


    // Ajout des données dans la collection Firestore
    ref.add({
      'useruiid': user!.uid,
      'nature': natureController.text,
      'localisation': localistController.text,
      'description': descripController.text,
      'image2': imageUrl ?? '',
      'datecreate' : DateTime.now(),
    }).then((value) {
      Get.snackbar(
        "Félicitation",
        "Information publiée",
        colorText: Colors.white,
        backgroundColor: Colors.green,
      );
      // ignore: invalid_return_type_for_catch_error
    }).catchError((error) => print("Erreur: $error"));
    // Effacer les champs et réinitialiser l'état
    clear();
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _showSimpleDialog() async {
    await showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Choisir une option"),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 136, 9, 5),
                    borderRadius: BorderRadius.circular(10)),
                child: GestureDetector(
                  onTap: () => pickchoose(),
                  child: Container(
                    decoration: const BoxDecoration(color: Colors.grey),
                    width: 80,
                    height: 80,
                    child: const Icon(
                      Icons.photo,
                      color: Color.fromARGB(255, 239, 239, 239),
                      size: 40,
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 136, 33, 5),
                    borderRadius: BorderRadius.circular(20)),
                child: GestureDetector(
                  onTap: () => pickImage(),
                  child: Container(
                    decoration: const BoxDecoration(color: Colors.grey),
                    width: 80,
                    height: 80,
                    child: const Icon(
                      Icons.camera_alt,
                      color: Color.fromARGB(255, 249, 249, 249),
                      size: 40,
                    ),
                  ),
                ),
              )
            ],
          );
        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/blan.jpg'),
              fit: BoxFit.cover,
              opacity: 1.0,
              repeat: ImageRepeat.noRepeat,
            ),
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: natureController,
                          onChanged: (value) {
                            setState(() {});
                          },
                          decoration: const InputDecoration(
                            label: Text('Nature Du Bien'),
                            enabledBorder: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Veuillez entrer La Nature de votre bien svp';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: localistController,
                          decoration: const InputDecoration(
                            label: Text('Localisation du Bien'),
                            enabledBorder: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Veuillez entrer la Localisation svp';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: descripController,
                          style: const TextStyle(color: Colors.black),
                          decoration: const InputDecoration(
                            labelText: 'Description ',
                            labelStyle: TextStyle(color: Colors.black),
                            enabledBorder: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Veuillez decrire  votre bien svp';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            const Text(
                              "Ajouter l'image du bien",
                              style:
                                  TextStyle(fontFamily: 'beroKC', fontSize: 20),
                            ),
                            InkWell(
                                onTap: () {
                                  _showSimpleDialog();
                                },
                                child: const Icon(
                                  Icons.photo,
                                  size: 100,
                                  color: Colors.red,
                                ))
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: _isLoading
                              ? const CircularProgressIndicator()
                              : Container(
                                  height: 50,
                                  width: 300,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30)),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                    ),
                                    onPressed:  () async {
                                            setState(() {
                                              _isLoading = true;
                                            });
                                            if (_formKey.currentState != null &&
                                                _formKey.currentState!
                                                    .validate()) {
                                              setState(() {
                                                _isLoading = true;
                                              });
                                            }
                                            submitForm();
                                            clear();
                                            setState(() {
                                              _isLoading = false;
                                            });
                                          },
                                    child: const Text(
                                      "VALIDER",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontFamily: 'beroKC',
                                      ),
                                  ),
                              ),
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
    );
  }
}
