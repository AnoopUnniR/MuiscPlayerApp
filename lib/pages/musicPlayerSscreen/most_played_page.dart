import 'package:flutter/material.dart';
import 'package:music_player1/functions/databaseFunctions/most_played_db.dart';
import 'package:music_player1/functions/music_functions.dart';
import 'package:music_player1/pages/menuIcon/menu_icon.dart';
import 'package:music_player1/pages/musicPlayerSscreen/music_player_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MostPlayedPage extends StatelessWidget {
  const MostPlayedPage({super.key});

  @override
  Widget build(BuildContext context) {
    List mostPlayedDetails = [];
    List mostPlayedPlayer = [];
    var menuButton = MenuIconClass();
    var musicFunction = MusicFunctionsClass();
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
          title: const Text("Most Played"),
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
                      valueListenable: mostPlayedListNotifier,
                      builder: (context, List mostPlayedList, child) {
                        if (mostPlayedList.isEmpty) {
                          return SizedBox(
                            height: height,
                            child: const Center(
                              child: Text(
                                'nothing to show',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                        }
                        mostPlayedDetails.clear();
                        for (var song in mostPlayedList) {
                          mostPlayedDetails.add(song);
                          mostPlayedPlayer.add(song.songuri);
                        }
                        return GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 30,
                                  mainAxisSpacing: 30),
                          itemBuilder: (context, index) {
                            var path = mostPlayedDetails[index].songuri;
                            var title = mostPlayedDetails[index].songTitle;
                            var artist = mostPlayedDetails[index].songArtist!;
                            var image = mostPlayedDetails[index].imageId;
                            var id = mostPlayedDetails[index].id;
                            return InkWell(
                              child: Card(
                                color: Colors.white,
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(mostPlayedDetails[index]
                                          .count
                                          .toString()),
                                    ),
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
                                        id: mostPlayedDetails[index].imageId,
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
                                            mostPlayedDetails[index].songTitle,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () async {
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
                                      songPath: mostPlayedPlayer,
                                      songDetails: mostPlayedDetails,
                                    ),
                                  ),
                                );
                                await musicFunction
                                    .creatingPlayerList(mostPlayedPlayer);
                                musicFunction.playingAudio(index);
                                // musicFunction.update(mostPlayedList,index);
                              },
                            );
                          },
                          itemCount: mostPlayedList.length,
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
