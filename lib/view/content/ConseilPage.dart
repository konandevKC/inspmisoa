import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ConseilPage extends StatefulWidget {
  const ConseilPage({Key? key}) : super(key: key);

  @override
  State<ConseilPage> createState() => _ConseilPageState();
}

class _ConseilPageState extends State<ConseilPage> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Padding(
          padding: EdgeInsets.only(top: 20),
          child: Text(
            'Joindre un conseiller',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                buildButton(
                  Icons.wifi_calling_3,
                  'Par téléphone',
                  'tel:+2250709171734',
                ),
                SizedBox(height: 50),
                buildButton(
                  Icons.messenger,
                  'Par message',
                  'sms:+2250709171734',
                ),
                SizedBox(height: 50),
                buildButton(
                  Icons.email,
                  'Par email',
                  'mailto:admin&com@inspicorporate.com',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButton(IconData icon, String text, String url) {
    return GestureDetector(
      onTap: () async {
        setState(() {
          isLoading = true;
        });

        final Uri launchUri = Uri.parse(url);

        if (await canLaunchUrl(launchUri)) {
          await launchUrl(launchUri);
        } else {
          print('Lancement de l\'URL échoué');
        }

        setState(() {
          isLoading = false;
        });
      },
      child: isLoading
          ? CircularProgressIndicator()
          : Column(
        children: [
          CircleAvatar(
            radius: 60,
            child:  IconButton(
              onPressed: () {},
              icon: Icon(
                icon,
                size: 40,
              ),
            ),
          ),
          Text(
            text,
            style: TextStyle(color: Colors.grey, fontSize: 20),
          ),
        ],
      ),
    );
  }

  Future<void> launchUrl(Uri uri) async {
    if (await canLaunch(uri.toString())) {
      await launch(uri.toString());
    } else {
      print('Le lancement de l\'URL a échoué');
    }
  }

  Future<bool> canLaunchUrl(Uri uri) async {
    return await canLaunch(uri.toString());
  }
}
