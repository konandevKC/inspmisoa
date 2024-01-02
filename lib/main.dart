import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:misoainsp/Controller/auth_controller.dart';
import 'package:misoainsp/rooter/app_routes.dart';
import 'package:misoainsp/view/SplashCreen.dart';
import 'package:misoainsp/view/auth/Resgister.dart';
import 'package:misoainsp/view/auth/login.dart';
import 'package:misoainsp/view/profile.dart';
import 'package:firebase_core/firebase_core.dart';

import 'Controller/SearchController.dart';
import 'Controller/userController.dart';
import 'fire_option.dart';

Future<void> main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Assurez-vous d'initialiser les liaisons Flutter

  // Initialisez Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Get.put(AuthController());
    Get.put(RechercheController());
    return GetMaterialApp(

      debugShowCheckedModeBanner: false ,
      theme: ThemeData(
          primarySwatch: Colors.red,
          textTheme: TextTheme(bodyText1: TextStyle()),
          brightness: Brightness.light),
      darkTheme: ThemeData(brightness: Brightness.dark
      ),
      title: 'Mon App Immobilier',
      initialRoute: '/',
      getPages: [
        GetPage(
            name: '/', page: () => splashcreen(), transition: Transition.fade),
        GetPage(
            name: AppRoutes.register,
            page: () => const RegisterView(),
            transition: Transition.fade),
        GetPage(
            name: AppRoutes.profile,
            page: () => ProfileView(),
            transition: Transition.fade),
      ],
    );
  }
}
