import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:misoainsp/view/auth/login.dart';

import '../content/AcceuillView.dart';
import '../content/SearshPage.dart';
import '../profile.dart';


class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final RxInt _selectedIndex = 0.obs;
  int selectedIndex = 0;
  final user = FirebaseAuth.instance.currentUser;
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currenScreen = const AcceuilView();

  final List<Widget> screens = [
    const AcceuilView(),
    SearchPage(),
    ProfileView(),
  ];

  Future<void> checkForUpdates() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> versionDoc =
      await FirebaseFirestore.instance.collection('version').doc('8MWCv6H7sTHbyGlAOjHm').get();

      int currentVersion = versionDoc.data()!['versionaap'];

      // Compare currentVersion with the version of your app
      if (currentVersion > 1) {
        // Show a dialog prompting the user to update
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('New Version Available'),
              content: Text('A new version of the app is available. Please update to continue using the app.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      print('Error checking for updates: $e');
    }
  }

  void changeScreen(int index) {
    checkForUpdates(); // Call the update check when changing screens
    _selectedIndex.value = index;
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(top: 7,left: 100),
          child: Row(
            children: [
              Image.network(
                "https://res.cloudinary.com/dgpmogg2w/image/upload/v1680881810/mo_gwvrih.png",
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              const Text(
                'MISOA',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.red,
      ),
     
      body: Obx(
            () => SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: EdgeInsets.only(),
            child: PageStorage(
              bucket: bucket,
              child: screens[_selectedIndex.value],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 30,
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.08,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MaterialButton(
                  minWidth: MediaQuery.of(context).size.width * 0.3,
                  onPressed: () {
                    setState(() {
                      changeScreen(0);
                    });},
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        size: 30,
                        Icons.home,
                        color: _selectedIndex.value == 0 ? Colors.red : Colors.grey,
                      ),
                      Text(
                        'Accueil',
                        style: TextStyle(
                          color: _selectedIndex.value == 0 ? Colors.red : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                MaterialButton(
                  minWidth: MediaQuery.of(context).size.width * 0.3,
                  onPressed: () {
                    setState(() {
                    changeScreen(1);
                  }); },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        size: 30,
                        Icons.search_outlined,
                        color: _selectedIndex.value == 1 ? Colors.red : Colors.grey,
                      ),
                      Text(
                        'Recherche',
                        style: TextStyle(
                          color: _selectedIndex.value == 1 ? Colors.red : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),

                  MaterialButton(
                    minWidth: MediaQuery
                        .of(context)
                        .size
                        .width * 0.2,
                    onPressed: () {
                      if(user?.uid == null){
                        Get.off(LoginView());
                      }else{
                      setState(() {
                        changeScreen(2);
                      });}
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          size: 33,
                          Icons.person,
                          color: _selectedIndex.value == 2 ? Colors.red : Colors
                              .grey,
                        ),
                        Text(
                          'Profil',
                          style: TextStyle(
                            color: _selectedIndex.value == 2
                                ? Colors.red
                                : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
