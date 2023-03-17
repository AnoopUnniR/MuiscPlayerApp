import 'package:flutter/material.dart';
import 'package:music_player1/functions/databaseFunctions/favourites_db.dart';
import 'package:music_player1/functions/databaseFunctions/most_played_db.dart';
import 'package:music_player1/functions/databaseFunctions/recent_played_db.dart';
import 'package:music_player1/models/models.dart';
import 'package:music_player1/pages/home_screen.dart';
import 'package:music_player1/pages/miniPlayer/mini_player.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:music_player1/functions/music_functions.dart';
import 'package:music_player1/pages/musicPlayerSscreen/music_player_screen.dart';

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({super.key});

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage>
    with FavouriteFunctionClass, MostPlayedSongsClass, RecentPlayedFunction {
  @override
  void initState() {
    super.initState();
    getAllFavourites();
  }

  @override
  Widget build(BuildContext context) {
    List favourites = [];
    List favouritesDetails = [];
    var musicFunction = MusicFunctionsClass();
    double width = MediaQuery.of(context).size.width / 100;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xff121526),
      appBar: AppBar(
        title: const Text("Favourites"),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        toolbarHeight: 50,
        backgroundColor: const Color.fromARGB(255, 38, 32, 63),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: ValueListenableBuilder(
                valueListenable: favouritesListNotifier,
                builder: (BuildContext context,
                    List<FavouritesModel> favouritesLists, Widget? child) {
                  if (favouritesLists.isEmpty) {
                    return  SizedBox(
                      height: height,
                      child:const Center(
                        child: Text(
                          'nothing to show',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  }
                  favouritesDetails.clear();
                  //passing values to concatinating class
                  for (var song in favouritesLists) {
                    favourites.add(song.songuri);
                    favouritesDetails.add(song);
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: favouritesLists.length,
                    itemBuilder: (context, index) {
                      var path = favouritesLists[index].songuri;
                      var title = favouritesLists[index].songTitle;
                      var artist = favouritesLists[index].songArtist!;
                      var image = favouritesLists[index].imageId;
                      var id = favouritesLists[index].id;
                      return Padding(
                        padding:
                            const EdgeInsets.only(left: 8, right: 8, top: 8),
                        child: ColoredBox(
                          color: Colors.white,
                          //listing songs//
                          child: ListTile(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 10),
                            onTap: () async {
                              songDetailsList.clear();
                                  songDetailsList.addAll(favouritesDetails);
                              // musicFunction.update(favouritesLists, index);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MusicPlayerScreen(
                                    pathAudio: path,
                                    index: index,
                                    artist: artist,
                                    title: title,
                                    imageId: image,
                                    id: id!,
                                    songPath: favourites,
                                    songDetails: favouritesDetails,
                                  ),
                                ),
                              );
                              await musicFunction
                                  .creatingPlayerList(favourites);
                              musicFunction.playingAudio(index);
                              setState(() {
                                isPlayerOn= true;
                              });
                            },
                            title: Text(
                              title,
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 37, 36, 36),
                                  overflow: TextOverflow.ellipsis),
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
                            trailing: IconButton(
                              icon: const Icon(Icons.highlight_remove_sharp,
                                  size: 30),
                              color: Colors.red,
                              tooltip: 'remove',
                              onPressed: () {
                                deleteFavourite(id!, context, title);
                                // favouritesDetails.removeAt(index);
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
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
}
