import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player1/models/models.dart';
import 'package:music_player1/pages/splash_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';

final OnAudioQuery audioQuery = OnAudioQuery();
final player = AudioPlayer();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(SongsListModelAdapter().typeId)) {
    Hive.registerAdapter(SongsListModelAdapter());
  }
  if (!Hive.isAdapterRegistered(FavouritesModelAdapter().typeId)) {
    Hive.registerAdapter(FavouritesModelAdapter());
  }
  if (!Hive.isAdapterRegistered(PlayListModelAdapter().typeId)) {
    Hive.registerAdapter(PlayListModelAdapter());
  }
  if (!Hive.isAdapterRegistered(RecentPlayModelAdapter().typeId)) {
    Hive.registerAdapter(RecentPlayModelAdapter());
  }
  if (!Hive.isAdapterRegistered(PlayListSongsModelAdapter().typeId)) {
    Hive.registerAdapter(PlayListSongsModelAdapter());
  }
  if (!Hive.isAdapterRegistered(MostPlayModelAdapter().typeId)) {
    Hive.registerAdapter(MostPlayModelAdapter());
  }

  //permission using permission handler
  // final androidInfo = await DeviceInfoPlugin().androidInfo;
  // late final Map<Permission, PermissionStatus> statuses;
  // if (androidInfo.version.sdkInt <= 32) {
  //   statuses = await [Permission.storage].request();
  // } else {
  //   statuses = await [Permission.storage].request();
  // }
  // var allAccepted = true;
  // statuses.forEach((permission, status) {
  //   if (status != PermissionStatus.granted) {
  //     allAccepted = true;
  //   }
  // });
  // if (allAccepted) {
  //   await musicFunction.songList();
  // }

  // permission using on audioquery
    await audioQuery.permissionsRequest();

  // bool status = await audioQuery.permissionsStatus();
  // if (status) {
  //   await audioQuery.permissionsRequest();
  // }

  // await musicFunction.songList();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music Player',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xff121526),
        textTheme: const TextTheme(
          displayLarge: TextStyle(color: Colors.white),
          displayMedium: TextStyle(color: Colors.white),
          displaySmall: TextStyle(color: Colors.white),
        ),
      ),
      home: const SplashScreenPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
