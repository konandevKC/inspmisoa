

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  Rx<User?> user = Rx<User?>(null);



  @override
  void onInit() {
    super.onInit();
    updateUser();
  }

  void updateUser() {
    user.value = FirebaseAuth.instance.currentUser;
  }
}
