import 'package:flutter/material.dart';
import 'package:music_player1/functions/databaseFunctions/all_songs_db.dart';
import 'package:music_player1/functions/databaseFunctions/most_played_db.dart';
import 'package:music_player1/functions/databaseFunctions/recent_played_db.dart';
import 'package:music_player1/functions/music_functions.dart';
import 'package:music_player1/pages/menuIcon/menu_icon.dart';
import 'package:music_player1/pages/musicPlayerSscreen/music_player_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';

String search = '';
class SearchPage extends StatefulWidget {
  const SearchPage({super.key, required this.page});
  final int page;
  @override
  State<SearchPage> createState() => SearchPageState();
}
class SearchPageState extends State<SearchPage> with AllSongsClass,RecentPlayedFunction,MostPlayedSongsClass {
  final _musicFunction = MusicFunctionsClass();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    var menuIcon = MenuIconClass();
    List findList = [];
    return Scaffold(
      appBar: AppBar(
          title: Container(
            width: width * 70,
            alignment: Alignment.centerLeft,
            color: const Color.fromARGB(255, 38, 32, 63),
            child: TextField(
              style:const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.white),
                  hintText: 'search here...',
                ),
                onChanged: (value) => setState(() {
                      search = value;
                    })),
          ),
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
              builder: (BuildContext context, songLists, Widget? child) {
                if (songLists.isEmpty) {
                  return const Center(
                    child: Text(
                      'no audio files found with the name',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }
                if (search.isEmpty) {
                  findList = songLists.toList();
                } else {
                  findList = songLists
                      .where((element) => element.songTitle
                          .toLowerCase()
                          .contains(search.toLowerCase()))
                      .toList();
                }
                if (findList.isEmpty) {
                  return const Center(
                    child: Text(
                      'no songs found',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }
                return ListView.separated(
                  separatorBuilder: (context, index) => const Divider(
                    color: Colors.white,
                    thickness: 2,
                    height: 0,
                  ),
                  shrinkWrap: true,
                  itemCount: findList.length,
                  itemBuilder: (context, index) {
                    var path = findList[index].songuri;
                    var title = findList[index].songTitle;
                    var artist = findList[index].songArtist!;
                    var image = findList[index].imageId;
                    var id = findList[index].id;
                    return ColoredBox(
                      color: Colors.black,
                      //listing songs//------------------------------------------------
                      child: ListTile(
                        onTap: () async {
                          _musicFunction.playingAudio(index);
                          // var recent = RecentPlayModel(
                                  //     songTitle: title,
                                  //     songuri: path,
                                  //     imageId: image,
                                  //     id: id,
                                  //     songArtist: artist);
                                  // addRecent(recent);
                                  // var most = MostPlayModel(
                                  //     songTitle: title,
                                  //     songuri: path,
                                  //     imageId: image,
                                  //     songArtist: artist,
                                  //     id: id);
                                  // updateMostPlayed(most);
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
                                  songDetails: const []),
                            ),
                          );
                        },
                        title: Text(
                          title,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          artist,
                          style: const TextStyle(color: Colors.white),
                        ),
                        leading: QueryArtworkWidget(
                          id: image!,
                          type: ArtworkType.AUDIO,
                          nullArtworkWidget: Image.asset(
                            'assets/mmmm.jpeg',
                          ),
                        ),
                        trailing: menuIcon.menuIcon(
                            artist: artist,
                            context: context,
                            id: id,
                            image: image,
                            path: path,
                            title: title),
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
