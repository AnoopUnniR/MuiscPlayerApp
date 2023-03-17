import 'package:flutter/material.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        toolbarHeight: 50,
        backgroundColor: const Color.fromARGB(255, 38, 32, 63),
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Zong - AudioPlayer:',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Zong - AudioPlayer.("us", "we", or "our") is an audio player application designed to provide a seamless audio listening experience. This privacy policy explains how we collect, use, and protect the personal information of users of our app. ',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Collection of Personal Information:',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                    'Zong Audio Player App does not collect any personal information from its users. We do not collect, store, or share any information from your device or your online activity. Our app only requires access to your internal storage to play audio files stored on your device.',
                    style: TextStyle(color: Colors.white, fontSize: 15)),
                SizedBox(
                  height: 20,
                ),
                Text('Use of Personal Information:',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 10,
                ),
                Text(
                    'As we do not collect any personal information from our users, we do not use any personal information for any purposes. We respect your privacy and do not engage in any practices that may compromise your privacy.',
                    style: TextStyle(color: Colors.white, fontSize: 15)),
                SizedBox(
                  height: 20,
                ),
                Text('Data Security:',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 10,
                ),
                Text(
                    'We take appropriate security measures to protect the personal information of our users from unauthorized access, alteration, or destruction. We store all information locally on the device and do not transmit any information to external servers.',
                    style: TextStyle(color: Colors.white, fontSize: 15)),
                SizedBox(
                  height: 20,
                ),
                Text('Changes to the Privacy Policy:',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 10,
                ),
                Text(
                    'We may update this privacy policy from time to time to reflect changes to our app, industry standards, or legal requirements. We encourage you to review this policy periodically to stay informed of our privacy practices.',
                    style: TextStyle(color: Colors.white, fontSize: 15)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
