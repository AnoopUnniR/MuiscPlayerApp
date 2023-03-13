import 'dart:async';
import 'package:flutter/material.dart';
import 'package:music_player1/functions/databaseFunctions/all_songs_db.dart';
import 'package:music_player1/pages/home_screen.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<SplashScreenPage> with AllSongsClass {
  @override
  void initState() {
    super.initState();
    delete();
    getAllSongs();
    Timer(
      const Duration(seconds: 2),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff121526),
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(),
          CircleAvatar(radius: 40,backgroundColor:const Color(0xff121526) ,child: Image.asset('assets/app_icon.png'),),
          const Padding(
            padding:  EdgeInsets.all(30.0),
            child:  Text('Loading...',style: TextStyle(color: Colors.white),),
          )
        ],
      )),
    );
  }
}
