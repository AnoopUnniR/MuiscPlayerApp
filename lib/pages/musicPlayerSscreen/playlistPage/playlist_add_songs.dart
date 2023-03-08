import 'package:flutter/material.dart';
import 'package:music_player1/functions/databaseFunctions/all_songs_db.dart';
import 'package:music_player1/functions/databaseFunctions/playlist_db.dart';
import 'package:music_player1/functions/databaseFunctions/recent_played_db.dart';
import 'package:music_player1/functions/music_functions.dart';
import 'package:music_player1/models/models.dart';
import 'package:music_player1/pages/musicPlayerSscreen/music_player_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlaylistSongAddPage extends StatefulWidget {
  final String playlistName;
  final int playListid;
  const PlaylistSongAddPage(
      {super.key, required this.playlistName, required this.playListid});

  @override
  State<PlaylistSongAddPage> createState() => PlaylistSongAddPageState();
}

class PlaylistSongAddPageState extends State<PlaylistSongAddPage>
    with AllSongsClass, PlaylistFunctionsClass,RecentPlayedFunction {
  @override
  void initState() {
    super.initState();
    getAllPlaylistSongs();
  }

  var musicFunctions =  MusicFunctionsClass();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Add Songs"),
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
            ValueListenableBuilder(
              valueListenable: songlistNotifier,
              builder: (BuildContext context, List<SongsListModel> songLists,
                  Widget? child) {
                if (songLists.isEmpty) {
                  return const Center(
                    child: Text(
                      'no audio files found',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: songLists.length,
                  itemBuilder: (context, index) {
                    var path = songLists[index].songuri;
                    var title = songLists[index].songTitle;
                    var artist = songLists[index].songArtist!;
                    var image = songLists[index].imageId;
                    var id = songLists[index].id;
                    return Padding(
                      padding: const EdgeInsets.only(
                        left: 8.0,
                        right: 8.0,
                        top: 8,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        //listing songs//------------------------------------------------
                        child: ListTile(
                          onTap: () async {
                            musicFunctions.playingAudio(index);
                            // var recent = RecentPlayModel(
                            //     songTitle: title,
                            //     songuri: path,
                            //     imageId: image,
                            //     id: id,
                            //     songArtist: artist);
                            // addRecent(recent);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MusicPlayerScreen(
                                  pathAudio: path,
                                  index: index,
                                  artist: artist,
                                  title: title,
                                  imageId: image,
                                  id: id!,
                                  songPath: const [],
                                  songDetails: const [],
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
                                color: Color.fromARGB(255, 37, 36, 36)),
                          ),
                          leading: QueryArtworkWidget(
                            id: image!,
                            type: ArtworkType.AUDIO,
                            nullArtworkWidget: Image.asset(
                              'assets/0.png',
                            ),
                          ),
                          trailing: IconButton(
                            icon:
                                const Icon(Icons.add_circle_outline, size: 30),
                            color: Colors.black,
                            tooltip: 'add to playlist',
                            onPressed: () {
                              var value = PlayListSongsModel(
                                  playlistId: widget.playListid,
                                  songArtist: artist,
                                  songTitle: title,
                                  songuri: path,
                                  imageId: image,
                                  id: id);
                              addSongsPlaylist(value, context);
                            },
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
