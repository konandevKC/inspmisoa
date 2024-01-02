import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:misoainsp/view/content/listeDemande.dart';

import '../../Controller/SearchController.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final RechercheController searchController = Get.find();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isloading = false;
  TextEditingController LocalisationController = TextEditingController();
  TextEditingController choipmaisonController = TextEditingController();
  TextEditingController nombresController = TextEditingController();
  TextEditingController MaximumController = TextEditingController();
  TextEditingController doucheController = TextEditingController();
  TextEditingController BienController = TextEditingController();

  // Inside _SearchPageState class
  void clearFields() {
    doucheController.clear();
      MaximumController.clear();
      nombresController.clear() ;
      LocalisationController.clear();
      choipmaisonController.clear();
      BienController.clear();

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.23,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/fon.jpg'),
                        fit: BoxFit.cover,
                        repeat: ImageRepeat.noRepeat),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                  ),
                ),
                const Positioned(
                  top: 60,
                  left: 100,
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage('images/vrai.png'),
                        radius: 30,
                      ),
                      Text(
                        'MISOA',
                        style: TextStyle(
                            fontFamily: 'beroKC',
                            fontSize: 30,
                            color: Colors.white),
                      )
                    ],
                  ),
                ),
                Positioned(
                    bottom: 20,
                    left: 20,
                    child: GestureDetector(
                      onTap: () {
                        Get.to(ListeBiensPage());
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white),
                        child: const Center(
                          child: Row(
                            children: [
                              Icon(Icons.visibility),
                              Text(
                                'Liste',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.red,
                                  fontFamily: 'beroKC',
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ))
              ]),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const Text(
                          'Exprimé vos desirs',
                          style: TextStyle(
                            color: Colors.red,
                            fontFamily: 'beroKC',
                            fontSize: 25,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(

                          validator: (value) {
                            if (value!.isEmpty) {
                              return '';
                            }
                            return null;
                          },
                          controller:BienController,
                          decoration: const InputDecoration(
                              labelText: 'Type de Biens',
                              border: OutlineInputBorder()),


                        ),
                        const SizedBox(height: 16.0),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                maxLength: 1,
                                controller: nombresController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return '';
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                    labelText: 'Nombre de Pièces',
                                    border: OutlineInputBorder()),
                                keyboardType: TextInputType.number ,

                              ),
                            ),
                            const SizedBox(width: 16.0),
                            Expanded(
                              child: TextFormField(
                                maxLength: 1,
                                controller: doucheController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return '';
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                    labelText: 'Nombre de douche',
                                    border: OutlineInputBorder()),

                            keyboardType: TextInputType.number ,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.0),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                maxLength: 9,
                                controller: MaximumController,
                                decoration: const InputDecoration(
                                    labelText: 'Prix maximum',
                                    border: OutlineInputBorder()),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Le champ est vide ';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.number,

                              ),
                            ),
                            const SizedBox(width: 16.0),
                            Expanded(
                              child: TextFormField(
                                controller: LocalisationController,
                                decoration: const InputDecoration(
                                  labelText: 'Localisation',
                                  border: OutlineInputBorder(),
                                ),


                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        isloading
                            ? const CircularProgressIndicator()
                            : Container(
                                height: 60,
                                width: 200,
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(100)),
                                child: InkWell(
                                  onTap: () {
                                    if(_formKey.currentState != null && _formKey.currentState!.validate())  {
                                      setState(() {
                                        isloading = true;
                                      });
                                    }
                                    searchController.insertData(
                                        BienController.text,
                                        nombresController.text,
                                        doucheController.text,
                                        MaximumController.text ,
                                        LocalisationController.text);

                                    clearFields();
                                    setState(() {
                                      isloading = false;
                                    });


                                  },
                                  child: const Center(
                                    child: Text(
                                      'Rechercher',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'beroKC',
                                        fontSize: 25,
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
