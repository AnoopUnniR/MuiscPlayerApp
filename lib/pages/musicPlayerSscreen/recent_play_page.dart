import 'package:flutter/material.dart';
import 'package:music_player1/functions/databaseFunctions/recent_played_db.dart';
import 'package:music_player1/functions/music_functions.dart';
import 'package:music_player1/models/models.dart';
import 'package:music_player1/pages/menuIcon/menu_icon.dart';
import 'package:music_player1/pages/musicPlayerSscreen/music_player_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';

class RecentlyPlayedPage extends StatelessWidget {
  const RecentlyPlayedPage({super.key});

  @override
  Widget build(BuildContext context) {
    List recentDetails = [];
    List recentPlayer = [];
    var menuButton = MenuIconClass();
    var musicFunction = MusicFunctionsClass();
    return Scaffold(
      appBar: AppBar(
          title: const Text("Recently Played"),
          centerTitle: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          toolbarHeight: 50,
          backgroundColor: const Color.fromARGB(255, 38, 32, 63)),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                
                child: Column(
                  children: [
                    ValueListenableBuilder(
                      valueListenable: recentPlayedNotifier,
                      builder:
                          (context, List<RecentPlayModel> recentList, child) {
                        if (recentList.isEmpty) {
                          return const Center(
                            child: Text('nothing to show',style: TextStyle(color: Colors.white),),
                          );
                        }
                        recentDetails.clear();
                        var reversed = recentList.reversed;
                        for (var song in reversed) {
                          recentDetails.add(song);
                          recentPlayer.add(song.songuri);
                        }
                        musicFunction.creatingPlayerList(recentPlayer);
                        return GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 30,
                                  mainAxisSpacing: 30),
                          itemBuilder: (context, index) {
                            var path = recentDetails[index].songuri;
                            var title = recentDetails[index].songTitle;
                            var artist = recentDetails[index].songArtist!;
                            var image = recentDetails[index].imageId;
                            var id = recentDetails[index].id;
              
                            return InkWell(
                              child: Card(
                                color: Colors.white,
                                child: Stack(
                                  children: [
                                    Align(
                                        alignment: Alignment.topRight,
                                        child: menuButton.menuIcon(
                                            image: image!,
                                            artist: artist,
                                            title: title,
                                            id: id!,
                                            path: path,
                                            context: context)),
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: QueryArtworkWidget(
                                        artworkHeight: 100,
                                        artworkWidth: 100,
                                        id: recentDetails[index].imageId,
                                        type: ArtworkType.AUDIO,
                                        nullArtworkWidget: Image.asset(
                                          height: 100,
                                          width: 60,
                                          'assets/icon.png',
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                            recentDetails[index].songTitle,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {
                              musicFunction.playingAudio(index);
                              // musicFunction.update(reversed,index);
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
                                      songPath: recentPlayer,
                                      songDetails: recentDetails,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          itemCount: recentList.length,
                        );
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
