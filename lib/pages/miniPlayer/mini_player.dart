import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player1/main.dart';
import 'package:music_player1/pages/home_screen.dart';
import 'package:music_player1/pages/musicPlayerSscreen/music_player_screen.dart';
import 'package:text_scroll/text_scroll.dart';

class MiniPlayerClass extends StatefulWidget {
 const MiniPlayerClass({super.key,required this.currentSongTitles,required this.width});
  final double width;
  final String currentSongTitles;

  @override
  State<MiniPlayerClass> createState() => _MiniPlayerClassState();
}

class _MiniPlayerClassState extends State<MiniPlayerClass> {
  @override
  Widget build(BuildContext context) {
    bool? visible;
    if (player.playing == true || isPlayerOn == true) {
      if (isPlayerOn == true) {
        visible = true;
      } else {
        visible = false;
      }
    } else {
      visible = false;
    }
    return Visibility(
      visible: visible,
      child: Padding(
        padding: const EdgeInsets.only(left: 13.0, right: 13, bottom: 8),
        child: SizedBox(
          width: widget.width * 100,
          child: Stack(
            children: [
              InkWell(
                onLongPress: () {
                  setState(() {
                    isPlayerOn = false;
                    player.stop();
                  });
                },
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: 
                 (context) => MusicPlayerScreen(pathAudio: currentSongTitle!, index: 1, artist: currentSongArtist!, title: currentSongTitle!, imageId: 1, id: 1, songPath:const [], songDetails:const []),)),
                child: Container(
                  height: 70,
                  width: widget.width * 100,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    color: Color(0xff121526),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 25,
                        ),
                        child: SizedBox(
                          width: widget.width * 45,
                          child: TextScroll(
                            currentSongTitle??widget.currentSongTitles,
                            style: const TextStyle(
                                fontSize: 17,
                                color: Color.fromARGB(255, 213, 207, 207)),
                            delayBefore: const Duration(seconds: 3),
                            pauseBetween: const Duration(seconds: 2),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 300,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.skip_previous_outlined,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                player.seekToPrevious();
                                setState(() {});
                              },
                            ),
                            StreamBuilder<PlayerState>(
                                    stream: player.playerStateStream,
                                    builder: (context, snapshot) {
                                      final playerState = snapshot.data;
                                      final playing = playerState?.playing;
                                       if (playing != true) {
                                        return Padding(
                                          padding: const EdgeInsets.all(0),
                                          child: IconButton(
                                            icon: const Icon(Icons.play_arrow,color: Colors.white,),
                                            iconSize: 40.0,
                                            onPressed: player.play,
                                          ),
                                        );
                                      } else {
                                        return Padding(
                                          padding: const EdgeInsets.all(0),
                                          child: IconButton(
                                            icon: const Icon(Icons.pause,color: Colors.white),
                                            iconSize: 40.0,
                                            onPressed: player.pause,
                                          ),
                                        );
                                      } 
                                    },
                                  ),

                            IconButton(
                              icon: const Icon(
                                Icons.skip_next_outlined,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                player.seekToNext();
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
