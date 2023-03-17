import 'package:flutter/material.dart';
import 'package:music_player1/functions/databaseFunctions/most_played_db.dart';
import 'package:music_player1/functions/databaseFunctions/playlist_db.dart';
import 'package:music_player1/functions/databaseFunctions/recent_played_db.dart';
import 'package:music_player1/functions/music_functions.dart';
import 'package:music_player1/pages/miniPlayer/mini_player.dart';
import 'package:music_player1/pages/musicPlayerSscreen/music_player_screen.dart';
import 'package:music_player1/pages/musicPlayerSscreen/playlistPage/playlist_add_songs.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:music_player1/pages/musicPlayerSscreen/playlistPage/menu_playlist.dart';

class PlaylsitListPage extends StatefulWidget {
  final String playListname;
  final int id;
  const PlaylsitListPage(
      {super.key, required this.playListname, required this.id});

  @override
  State<PlaylsitListPage> createState() => PlaylsitListPageState();
}

class PlaylsitListPageState extends State<PlaylsitListPage>
    with PlaylistFunctionsClass, RecentPlayedFunction, MostPlayedSongsClass {
  var musicFunction = MusicFunctionsClass();
  List songDetails = [];
  List songs = [];

  @override
  Widget build(BuildContext context) {
    var menuIcon = MenuIconPlaylistClass();
    double width = MediaQuery.of(context).size.width / 100;
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.playListname),
          centerTitle: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          toolbarHeight: 50,
          backgroundColor: const Color.fromARGB(255, 38, 32, 63)),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  ValueListenableBuilder(
                    valueListenable: playListSongsNotifier,
                    builder:
                        (BuildContext context, List songLists, Widget? child) {
                      List collection = songLists
                          .where((element) => element.playlistId == widget.id)
                          .toList();
                      if (collection.isEmpty) {
                        return const Center(
                          child: Text(
                            'no audio files found',
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      }
                       songDetails.clear();
                       songs.clear();
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: collection.length,
                        itemBuilder: (context, index) {
                          var path = collection[index].songuri;
                          var title = collection[index].songTitle;
                          var artist = collection[index].songArtist;
                          var image = collection[index].imageId;
                          var id = collection[index].id;
                          if (!songs.contains(path)) {
                            songs.add(path);
                            songDetails.add(collection[index]);
                          }
                          // var playListId = collection[index].id;
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
                                onTap: () async {
                                  songDetailsList.clear();
                                  songDetailsList.addAll(songDetails);
                                  // musicFunction.update(collection, index);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MusicPlayerScreen(
                                          pathAudio: path,
                                          index: index,
                                          artist: artist,
                                          title: title,
                                          imageId: image,
                                          id: 1,
                                          songPath: songs,
                                          songDetails: songDetails),
                                    ),
                                  );
                                  await musicFunction.creatingPlayerList(songs);
                                  await musicFunction.playingAudio(index);
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
                                  ),
                                ),
                                leading: QueryArtworkWidget(
                                  id: image!,
                                  type: ArtworkType.AUDIO,
                                  nullArtworkWidget: Image.asset(
                                    'assets/0.png',
                                  ),
                                ),
                                trailing: IconButton(
                                  icon: const Icon(Icons.more_vert_outlined,
                                      size: 30),
                                  color: const Color(0xff8177ea),
                                  onPressed: () {
                                    menuIcon.menuButton(
                                        artist: artist,
                                        context: context,
                                        id: id,
                                        image: image,
                                        index: index,
                                        path: path,
                                        title: title);
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PlaylistSongAddPage(
                                  playListid: widget.id,
                                  playlistName: widget.playListname),
                            ),
                          );
                        },
                        child: const Text('Add Songs'),
                      ),
                      MiniPlayerClass(
                          currentSongTitles: currentSongTitle ?? '',
                          width: width),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
