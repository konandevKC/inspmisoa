import 'package:flutter/material.dart';
import 'package:misoainsp/view/produit/humpage.dart';
import 'package:misoainsp/view/produit/locationpage.dart';

import '../auth/menuPage.dart';

class AchatPage extends StatefulWidget {

  final String titre;
  const AchatPage({required this.titre});

  @override
  State<AchatPage> createState() => _AchatPageState();
}

class _AchatPageState extends State<AchatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '${widget.titre} de Bien',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: 'beroKC',
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: ListView(
          children: [
          
            _buildBlock(
              title: "Villa",
              images: [
                {
                  "image":
                      "https://res.cloudinary.com/dgpmogg2w/image/upload/v1700149814/IMG-20231103-WA0066_ofylrw.jpg",
                  "description": "Villa duplex de 4 pièces sur un lot de 200m²",
                  "localisation": "Abidjan, Bassam",
                  "status": "Location",
                },
                {
                  "image":
                      "https://res.cloudinary.com/dgpmogg2w/image/upload/v1680697182/1_tqqgp6.png",
                  "description": "Villa duplex de 4 pièces sur un lot de 200m²",
                  "localisation": "Abidjan, Bassam",
                  "status": "Location",
                },
                {
                  "image":
                      "https://res.cloudinary.com/dgpmogg2w/image/upload/v1680700666/2_e1qage.png",
                  "description": "VVilla duplex de 4 pièces sur un lot de 200m²",
                  "localisation": "Abidjan, Port-bouêt",
                  "status": "Location",
                },
                {
                  "image":
                      "https://res.cloudinary.com/dgpmogg2w/image/upload/v1700149814/IMG-20231103-WA0070_mufhcf.jpg",
                  "description": "Villa duplex de 4 pièces sur un lot de 200m²",
                  "localisation": "Abidjan, Cocody",
                  "status": "Location",
                },
                {
                  "image":
                      "https://res.cloudinary.com/dgpmogg2w/image/upload/v1700149814/IMG-20231103-WA0069_nj7rws.jpg",
                  "description": "Villa duplex de 4 pièces sur un lot de 200m²",
                  "localisation": "Abidjan, Port-bouét",
                  "status": "Location",
                },
              ],
            ),
            _buildBlock(
              title: "Appartement",
              images: [
                {
                  "image":
                      "https://res.cloudinary.com/dgpmogg2w/image/upload/v1700149815/IMG-20231103-WA0068_vojcyp.jpg",
                  "description": "Résidence de 6 Appartements Parking interieur ,espace detente roofttop",
                  "localisation": "Abidjan, Bassam",
                  "status": "Location",
                },
                {
                  "image":
                      "https://res.cloudinary.com/dgpmogg2w/image/upload/v1700149814/IMG-20231103-WA0067_jsi6gw.jpg",
                  "description": "Résidence de 6 Appartements Parking interieur ,espace detente roofttop",
                  "localisation": "Abidjan, Bassam",
                  "status": "Location",
                },
                {
                  "image":
                      "https://res.cloudinary.com/dgpmogg2w/image/upload/v1700149814/IMG-20231103-WA0065_isfp3m.jpg",
                  "description": "Résidence de 6 Appartements Parking interieur ,espace detente roofttop",
                  "localisation": "Abidjan, Bassam",
                  "status": "Location",
                },
                {
                  "image":
                      "https://immogroup.ahouefa.com/wp-content/uploads/2022/01/IMG-20220121-WA0024.jpg",
                  "description": "Résidence de 6 Appartements Parking interieur ,espace detente roofttop",
                  "localisation": "Abidjan, Bassam",
                  "status": "Location",
                },
                {
                  "image":
                      "https://res.cloudinary.com/dgpmogg2w/image/upload/v1700149814/IMG-20231103-WA0064_sl0jnn.jpg",
                  "description": "Résidence de 6 Appartements Parking interieur ,espace detente roofttop",
                  "localisation": "Abidjan, Bassam",
                  "status": "Location",
                },
              ],
            ),
            _buildBlock(
              title: "AUTRES",
              images: [
                {
                  "image":
                      "https://res.cloudinary.com/dgpmogg2w/image/upload/v1681203917/WhatsApp_Image_2023-04-10_%C3%A0_14.14.01_gdsnco.jpg",
                  "description": "Belle villa avec piscine",
                  "localisation": "Nice, France",
                  "status": "À vendre",
                },
                {
                  "image":
                      "https://gandaimmobilier.com/wp-content/uploads/2022/03/villa-meublee-agla-80.jpg.webp",
                  "description": "Grande villa avec vue sur mer",
                  "localisation": "Cannes, France",
                  "status": "Location",
                },
                {
                  "image":
                      "https://beninhouse.com/wp-content/uploads/2021/03/Emap-4.jpeg",
                  "description": "Villa moderne avec jardin",
                  "localisation": "Marseille, France",
                  "status": "Location",
                },
                {
                  "image":
                      "https://immogroup.ahouefa.com/wp-content/uploads/2022/01/IMG-20220121-WA0024.jpg",
                  "description": "Villa moderne avec jardin",
                  "localisation": "Marseille, France",
                  "status": "Location",
                },
                {
                  "image":
                      "https://lanouvelletribune.info/wp-content/uploads/xwc.jpg",
                  "description": "Villa moderne avec jardin",
                  "localisation": "Marseille, France",
                  "status": "Location",
                },
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBlock(
      {required String title, required List<Map<String, String>> images}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 130),
          child: Text(
            title.toUpperCase(),
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 360,
          width: 500,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: images.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Stack(
                          children: [

                            InkWell(
                              child: Image.network(
                                images[index]["image"]!,
                                fit: BoxFit.cover,
                                height: 340,
                                width: 320,
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FullScreenImage(
                                        imageUrl: images[index]["image"]!,
                                        descri: images[index]["description"]!,
                                        loca: images[index]["localisation"]!,
                                        status: images[index]["status"]!),
                                  ),
                                );
                              },
                            ),
                            const Positioned(
                              top: 20,
                                right: 10,
                                child: InkWell(
                                  child: Icon(Icons.favorite_border, size: 25,color: Colors.red,),)),
                            Positioned(
                              bottom: 20.0,
                              left: 20.0,
                              child: Column(children: [
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Column(
                                            children: [
                                              ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              Colors.lightBlue),
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) => FullScreenImage(
                                                                imageUrl: images[index]
                                                                    ["image"]!,
                                                                descri: images[
                                                                        index][
                                                                    "description"]!,
                                                                loca: images[index][
                                                                    "localisation"]!,

                                                                status: images[
                                                                        index]
                                                                    ["status"]!)));
                                                  },
                                                  child: const Text('Detail')),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              const Row(
                                                children: [
                                                  Icon(
                                                    Icons.star,
                                                    color: Colors.yellow,
                                                  ),
                                                  Icon(
                                                    Icons.star,
                                                    color: Colors.yellow,
                                                  ),
                                                  Icon(
                                                    Icons.star,
                                                    color: Colors.yellow,
                                                  ),
                                                  Icon(Icons.star_half,
                                                      color: Colors.yellow),
                                                  Icon(
                                                    Icons.star_border_outlined,
                                                    color: Colors.yellow,
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.location_on,
                                                    color: Colors.white,
                                                  ),
                                                  Text(
                                                      images[index]
                                                          ["localisation"]!,
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white)),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
