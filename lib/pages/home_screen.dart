import 'package:flutter/material.dart';
import 'package:music_player1/functions/databaseFunctions/all_songs_db.dart';
import 'package:music_player1/functions/databaseFunctions/favourites_db.dart';
import 'package:music_player1/functions/databaseFunctions/most_played_db.dart';
import 'package:music_player1/functions/databaseFunctions/playlist_db.dart';
import 'package:music_player1/functions/databaseFunctions/recent_played_db.dart';
import 'package:music_player1/main.dart';
import 'package:music_player1/models/models.dart';
import 'package:music_player1/pages/menuIcon/menu_icon.dart';
import 'package:music_player1/pages/miniPlayer/mini_player.dart';
import 'package:music_player1/pages/musicPlayerSscreen/most_played_page.dart';
import 'package:music_player1/pages/musicPlayerSscreen/recent_play_page.dart';
import 'package:music_player1/pages/search.dart';
import 'package:music_player1/pages/settings/settings.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:music_player1/functions/music_functions.dart';
import 'package:music_player1/pages/musicPlayerSscreen/favourites_page.dart';
import 'package:music_player1/pages/musicPlayerSscreen/music_player_screen.dart';
import 'package:music_player1/pages/musicPlayerSscreen/playlistPage/playlist_page.dart';

bool? isPlayerOn;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with
        AllSongsClass,
        FavouriteFunctionClass,
        PlaylistFunctionsClass,
        RecentPlayedFunction,
        MostPlayedSongsClass {
  @override
  void initState() {
    super.initState();
    getAllFavourites();
    getAllFavourites();
    getAllRecent();
    getAllPlaylist();
    getAllMostPlayed();
    player.currentIndexStream.listen((index) {
      if (index != null) {
        updateCurrentPlayingSongDetail(index);
      }
    });
  }

  @override
  void dispose() {
    player;
    super.dispose();
  }

  List songs = [];
  List songDetails = [];
  @override
  Widget build(BuildContext context) {
    var musicFunction = MusicFunctionsClass();
    var menuIcon = MenuIconClass();
    double width = MediaQuery.of(context).size.width / 100;
    return Scaffold(
      backgroundColor: const Color(0xff121526),
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(
              Icons.settings_outlined,
              color: Colors.white,
            ),
            onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsPage(),
                  ),
                )),
        title: const Text("Zong"),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        toolbarHeight: 50,
        backgroundColor: const Color.fromARGB(255, 38, 32, 63),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchPage(),
                ),
              );
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            //main column
            SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
//----------------------------Your Collections list----------------------------
                  Container(
                    decoration: const BoxDecoration(
                        color: Color(0xff121526),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(15))),
                    width: width * 100,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 60,
                          width: width * 100,
                          child: const Center(
                            child: Text(
                              'Collections',
                              style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.w500,
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 20,
                              ),
                              InkWell(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const FavouritesPage(),
                                  ),
                                ),
                                child: Container(
                                  width: width * 33,
                                  height: width * 10,
                                  decoration: const BoxDecoration(
                                    color: Color(0xfffb8943),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'FAVOURITES',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              InkWell(
                                child: Container(
                                  width: width * 28,
                                  height: width * 10,
                                  decoration: const BoxDecoration(
                                    color: Color(0xff71c4fc),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'PLAYLIST',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const PlayListPage(),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              InkWell(
                                child: Container(
                                  width: width * 44,
                                  height: width * 10,
                                  decoration: const BoxDecoration(
                                    color: Color(0xfff8ce67),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'RECENT SONGS',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const RecentlyPlayedPage(),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              //------------------------------------------------------------------------
                              InkWell(
                                child: Container(
                                  width: width * 38,
                                  height: width * 10,
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 236, 236, 239),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'MOST PLAYED',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const MostPlayedPage(),
                                    )),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                            color: Color(0xff121526),
                          ),
//playall----------------------------------
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  child: const Text(
                                    'Play All',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  onPressed: () {
                                    musicFunction.playingAudio(0);
                                    isPlayerOn = true;
                                    setState(() {});
                                  },
                                ),
                                TextButton(
                                  child: const Text(
                                    'Shuffle All',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  onPressed: () {
                                    musicFunction
                                        .creatingPlayerListShuffle(songs);
                                    isPlayerOn = true;
                                    setState(() {});
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ValueListenableBuilder(
                    valueListenable: songlistNotifier,
                    builder: (BuildContext context,
                        List<SongsListModel> songLists, Widget? child) {
                      if (songLists.isEmpty) {
                        return const Center(
                          child: Text(
                            'no audio files found',
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      }
                      //passing values to concatinating class
                      for (var song in songLists) {
                        songs.add(song.songuri);
                        songDetails.add(song);
                      }
                      musicFunction.creatingPlayerList(songs);
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: songLists.length,
                        itemBuilder: (context, index) {
                          var path = songLists[index].songuri;
                          var title = songLists[index].songTitle;
                          var artist = songLists[index].songArtist!;
                          var image = songLists[index].imageId;
                          var id = songLists[index].id;
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 8, right: 8, top: 8),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              //listing songs//------------------------------------------------
                              child: ListTile(
                                onTap: () {
                                  musicFunction.playingAudio(index);

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MusicPlayerScreen(
                                        pathAudio: path,
                                        index: index,
                                        artist: artist,
                                        title: title,
                                        imageId: image,
                                        id: id,
                                        songPath: songs,
                                        songDetails: songDetails,
                                      ),
                                    ),
                                  );
                                },
                                title: Text(
                                  title,
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 37, 36, 36),
                                  ),
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Text(
                                  artist,
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 55, 55, 55),
                                      overflow: TextOverflow.ellipsis),
                                ),
                                leading: QueryArtworkWidget(
                                  id: image!,
                                  type: ArtworkType.AUDIO,
                                  nullArtworkWidget: Image.asset(
                                    'assets/0.png',
                                  ),
                                ),
                                trailing: menuIcon.menuIcon(
                                    artist: artist,
                                    context: context,
                                    id: id!,
                                    image: image,
                                    path: path,
                                    title: title),
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  player.playing == true
                      ? const SizedBox(
                          height: 100,
                        )
                      : const Divider(),
                ],
              ),
            ),
            Align(
              alignment: AlignmentDirectional.bottomEnd,
              child: MiniPlayerClass(
                  currentSongTitles: currentSongTitle ?? '', width: width),
            ),
          ],
        ),
      ),
    );
  }

  void updateCurrentPlayingSongDetail(int index) {
    var musicFunction = MusicFunctionsClass();
    musicFunction.update(songDetails, index);
    setState(() {
      if (songDetails.isNotEmpty) {
        currentSongTitle = songDetails[index].songTitle;
        currentSongArtist = songDetails[index].songArtist;
        currentSongImg = songDetails[index].imageId;
        currentSongId = songDetails[index].id;
      }
    });
  }
}
