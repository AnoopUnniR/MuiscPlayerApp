import 'package:flutter/material.dart';
import 'package:music_player1/functions/databaseFunctions/playlist_db.dart';
import 'package:music_player1/models/models.dart';

class PlaylistAddDialogue with PlaylistFunctionsClass{
  List playListName = [];
  List playlistSongDetails = [];
  List playListIds = [];
  playlistDialogue({
  required  int image,
   required String artist,
  required String title,
   required int id,
 required String path,
  required BuildContext context,
  }) {
    return showDialog(
      context: context,
      builder: (context) => Center(
        child: Container(
          color: Colors.black,
          height: 400,
          width: 400,
          child: ValueListenableBuilder(
            valueListenable: playListNotifier,
            builder: (BuildContext context, List<PlayListModel> playListLists,
                Widget? child) {
              if (playListLists.isEmpty) {
                return const Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    'No Playlists created.',
                    style: TextStyle(color: Colors.white, fontSize: 20),
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
    );
  }
}