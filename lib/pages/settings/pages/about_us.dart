import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
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
      body:const SafeArea(
          child: Padding(padding:EdgeInsets.all(16),
          child: Text('A simple music player created with flutter with easy to use functionalities and UI',
          style: TextStyle(color: Colors.white,fontSize: 15),),),),
    );
  }
}
