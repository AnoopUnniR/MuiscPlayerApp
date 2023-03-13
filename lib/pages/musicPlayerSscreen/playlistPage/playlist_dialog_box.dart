import 'package:flutter/material.dart';
import 'package:music_player1/functions/databaseFunctions/playlist_db.dart';
import 'package:music_player1/models/models.dart';
import 'package:music_player1/pages/musicPlayerSscreen/playlistPage/playlist_page.dart';

class PlaylistAddDialogue with PlaylistFunctionsClass {
  List playListName = [];
  List playlistSongDetails = [];
  List playListIds = [];
  playlistDialogue({
    required int image,
    required String artist,
    required String title,
    required int id,
    required String path,
    required BuildContext context,
  }) {
    return showDialog(
      context: context,
      builder: (context) => Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Color(0xff121526)),
            height: 400,
            width: 400,
            child: ValueListenableBuilder(
              valueListenable: playListNotifier,
              builder: (BuildContext context, List<PlayListModel> playListLists,
                  Widget? child) {
                if (playListLists.isEmpty) {
                  return SizedBox(
                    height: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                       const Text(
                          'No Playlists created.',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        const SizedBox(height: 20,),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 119, 109, 234),),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const PlayListPage(),
                                  ),);
                            },
                            child: const Text('Go to Playlist Page'))
                      ],
                    ),
                  );
                }
                for (var song in playListLists) {
                  playListName.add(song.playlistName!);
                  playlistSongDetails.add(song);
                  playListIds.add(song.playListId);
                }
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        child: Column(
                          children: [
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: playListLists.length,
                              itemBuilder: (context, index) {
                                return ElevatedButton(
                                  child: Text(
                                    playListName[index],
                                  ),
                                  onPressed: () {
                                    var value = PlayListSongsModel(
                                        playlistId: playListIds[index],
                                        // playListIds[index],
                                        songArtist: artist,
                                        songTitle: title,
                                        songuri: path,
                                        imageId: image,
                                        id: id);
                                    addSongsPlaylist(value, context);
                                  },
                                );
                              },
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel'),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
