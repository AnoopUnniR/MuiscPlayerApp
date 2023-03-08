import 'dart:async';
import 'package:flutter/material.dart';
import 'package:music_player1/functions/databaseFunctions/all_songs_db.dart';
import 'package:music_player1/pages/widgets.dart';
import 'package:music_player1/pages/home_screen.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<SplashScreenPage> with AllSongsClass{
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
          builder: (context) =>
           const HomeScreen(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff121526),
      body: Stack(
        children: [
          circleUI(-2.7, -1.4),
          circleUI(4, 0),
          circleUI(-2.7, 1.4),
        ],
      ),
    );
  }
}




