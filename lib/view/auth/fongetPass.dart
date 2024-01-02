import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = false;

  Future<void> _resetPassword() async {
    try {
      await _auth.sendPasswordResetEmail(email: _emailController.text);
      Get.snackbar("Félicitation", "Password reset email sent successfully",
          colorText: Colors.white, backgroundColor: Colors.green);
      // Show success message or navigate to login screen
      print('Password reset email sent successfully');
    } catch (e) {
      // Show error message
      Get.snackbar("Erreur ", "Error sending password reset email",
        colorText: Colors.white, backgroundColor: Colors.red, );
      print('Error sending password reset email: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),

            SizedBox(height: 20),

            isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
              onPressed: () {
                setState(() {
                  isLoading = true;
                });
                _emailController.clear();
                _resetPassword();
                setState(() {
                  isLoading = false;
                });
              },
              child: Text('Reset Password'),
            ),
          ],
        ),
      ),
    );
  }
}



