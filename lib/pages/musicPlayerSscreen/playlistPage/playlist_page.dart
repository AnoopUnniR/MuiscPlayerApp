import 'package:flutter/material.dart';
import 'package:music_player1/functions/databaseFunctions/playlist_db.dart';
import 'package:music_player1/models/models.dart';
import 'package:music_player1/pages/miniPlayer/mini_player.dart';
import 'package:music_player1/pages/musicPlayerSscreen/music_player_screen.dart';
import 'package:music_player1/pages/musicPlayerSscreen/playlistPage/playlist_edit.dart';
import 'package:music_player1/pages/musicPlayerSscreen/playlistPage/playlist_list.dart';
import 'package:text_scroll/text_scroll.dart';

class PlayListPage extends StatefulWidget {
  const PlayListPage({super.key});

  @override
  State<PlayListPage> createState() => _PlayListPageState();
}

class _PlayListPageState extends State<PlayListPage>
    with PlaylistFunctionsClass {
  @override
  void initState() {
    super.initState();
    getAllPlaylistSongs();
  }

  final playlistNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List playlistSongDetails = [];
    List<String> playListName = [];
    List playListIds = [];
    var edit = EditplayListName();
    // List<String> playListName = [];
    double width = MediaQuery.of(context).size.width / 100;
    return Scaffold(
      appBar: AppBar(
          title: const Text("PLAYLISTS"),
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
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //create new playlist button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 119, 109, 234)),
                  onPressed: () {
                    
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text(
                          'Enter the playlist name',
                          style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 25),
                        ),
                        backgroundColor:
                            const Color.fromARGB(255, 218, 215, 215),
                        content: SizedBox(
                          height: 50,
                          child: Center(
                            child: TextFormField(
                              controller: playlistNameController,
                              validator: (value) {
                                if (playlistNameController.text.isEmpty ||
                                    playlistNameController.text
                                        .trim()
                                        .isEmpty) {
                                  return 'name required';
                                } else {
                                  return null;
                                }
                              },
                              decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.all(8),
                                  hintText: 'Enter playlist name...,',
                                  hintStyle: TextStyle(
                                      color: Color.fromARGB(153, 35, 28, 28),
                                      fontSize: 20,
                                      fontStyle: FontStyle.italic),
                                  border: OutlineInputBorder()),
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                          ),
                        ),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              if (playListName
                                  .contains(playlistNameController.text)) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        'playlist with name "${playlistNameController.text}" already exists'),
                                  ),
                                );
                              } else {
                                createPlaylist(
                                  PlayListModel(
                                    playlistName:
                                        playlistNameController.text.trim(),
                                  ),
                                );
                                playlistNameController.clear();
                                Navigator.pop(context);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff8177ea),
                            ),
                            child: const Text('create'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              playlistNameController.clear();
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff8177ea),
                            ),
                            child: const Text(
                              'cancel',
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  child: const Text('create new'),
                ),
                Expanded(
                  child: ValueListenableBuilder(
                    valueListenable: playListNotifier,
                    builder: (BuildContext context,
                        List<PlayListModel> playListLists, Widget? child) {
                      if (playListLists.isEmpty) {
                        return const Center(
                          child: Text(
                            'No Playlists created.',
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      }
                      playListIds.clear();
                      for (var song in playListLists) {
                        playListName.add(song.playlistName!);
                        playlistSongDetails.add(song);
                        playListIds.add(song.playListId);
                        // print(playListIds);
                      }
                      // print(playListId);
                      // createPlaylist(playListSongs);
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: GridView.builder(
                          shrinkWrap: true,
                          itemCount: playListLists.length,
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: width * 40,
                                  crossAxisSpacing: 16,
                                  mainAxisSpacing: 16),
                          itemBuilder: (context, index) {
                            return InkWell(
                              child: Card(
                                color: const Color(0xff8177ea),
                                child: Stack(
                                  children: [
                                    Align(
                                        alignment: Alignment.topCenter,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  edit.editingPlaylist(
                                                      playListIds[index],
                                                      playListLists[index],
                                                      context,
                                                      index);
                                                },
                                                icon: const Icon(Icons.edit)),
                                            IconButton(
                                              icon: const Icon(
                                                  Icons.delete_forever),
                                              onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) => AlertDialog(
                                                      title: Text(
                                                          'Do you want to delete the playlist ${playListName[index]}?'),
                                                      actions: [
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            deletePlaylist(
                                                                index,
                                                                playListIds[
                                                                    index]);
                                                            setState(() {});
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: const Text(
                                                              'Delete'),
                                                        ),
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: const Text(
                                                              "Cancel"),
                                                        )
                                                      ],),
                                                );
                                              },
                                            ),
                                          ],
                                        )),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: TextScroll(
                                          playListName[index],
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 18),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PlaylsitListPage(
                                      playListname: playListName[index],
                                      id: playListIds[index]),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
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
}
