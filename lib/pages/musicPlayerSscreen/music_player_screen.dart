import 'package:music_player1/functions/databaseFunctions/favourites_db.dart';
import 'package:music_player1/models/models.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import 'package:music_player1/main.dart';
import 'package:just_audio/just_audio.dart';
import 'package:text_scroll/text_scroll.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:music_player1/pages/home_screen.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';

ConcatenatingAudioSource? playing;
String? title;
String? currentSongTitle;
String? currentSongArtist;
int? currentSongImg;
int? currentSongId;
String? currentSongPath;

class MusicPlayerScreen extends StatefulWidget {
  final String pathAudio;
  final int index;
  final String artist;
  final String title;
  final int imageId;
  final int id;
  final List songPath;
  final List songDetails;

  const MusicPlayerScreen(
      {super.key,
      required this.pathAudio,
      required this.index,
      required this.artist,
      required this.title,
      required this.imageId,
      required this.id,
      required this.songPath,
      required this.songDetails});

  @override
  State<MusicPlayerScreen> createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen>
    with FavouriteFunctionClass {
  Stream<DurationState> get _durationStateStream =>
      Rx.combineLatest2<Duration, Duration?, DurationState>(
          player.positionStream,
          player.durationStream,
          (position, duration) => DurationState(
              position: position, total: duration ?? Duration.zero));
  List<IconData> icons = [Icons.play_arrow_outlined, Icons.pause];

  @override
  void initState() {
    super.initState();

    player.currentIndexStream.listen((index) {
      if (index != null) {
        updateCurrentPlayingSongDetails(index);
      }
    });
  }

//used to control the player playpause
  bool play = true;
  var playlistAddButton = PlaylistAddDialogue();
  @override
  Widget build(BuildContext context) {
    bool? isFav = isInFav(currentSongId ?? widget.id);
    var iconColor = const Color.fromARGB(255, 238, 238, 238);
    currentSongImg = widget.imageId;
    isPlayerOn = true;
    double width = MediaQuery.of(context).size.width / 100;
    return Scaffold(
      backgroundColor: const Color(0xff121526),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            //main column
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 40,
                ),
                Container(
                  decoration: const BoxDecoration(),
                  height: width * 75,
                  child: QueryArtworkWidget(
                    id: currentSongImg!,
                    type: ArtworkType.AUDIO,
                    nullArtworkWidget: Image.asset(
                      'assets/icon.png',
                    ),
                  ),
                ),
                // -------------------------------play buttons-----------------------
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    height: 25,
                    width: width * 100,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {
                                playlistAddButton.playlistDialogue(
                                    image: currentSongImg ?? widget.imageId,
                                    artist: currentSongArtist ?? widget.artist,
                                    title: currentSongTitle ?? widget.title,
                                    id: currentSongId ?? widget.id,
                                    path: currentSongPath ?? widget.pathAudio,
                                    context: context);
                              },
                              icon: const Icon(
                                Icons.menu,
                                color: Colors.white,
                              )),
                          Builder(
                            builder: (context) {
                              if (isFav != true) {
                                return IconButton(
                                    onPressed: () {
                                      var listFavourites = FavouritesModel(
                                          imageId:
                                              currentSongImg ?? widget.imageId,
                                          songTitle:
                                              currentSongTitle ?? widget.title,
                                          songArtist:
                                              currentSongTitle ?? widget.artist,
                                          songuri: currentSongPath ??
                                              widget.pathAudio,
                                          id: currentSongId ?? widget.id);
                                      addFavourites(listFavourites, context);
                                      setState(() {
                                        isFav = true;
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.favorite_border,
                                      color: Colors.white,
                                    ));
                              } else {
                                return IconButton(
                                  onPressed: () {
                                    deleteFavourite(
                                        currentSongId ?? widget.id,
                                        context,
                                        currentSongTitle ?? widget.title);
                                    isFav = false;

                                    setState(() {});
                                  },
                                  icon: const Icon(
                                    Icons.favorite,
                                    color: Colors.white,
                                  ),
                                );
                              }
                            },
                          )
                        ]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SizedBox(
                          width: width * 100,
                          child: Center(
                            child: TextScroll(
                              currentSongTitle ?? '',
                              style: TextStyle(fontSize: 17, color: iconColor),
                              delayBefore: const Duration(milliseconds: 1000),
                              selectable: true,
                              pauseBetween: const Duration(milliseconds: 500),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        currentSongArtist ?? '<unknown>',
                        style: TextStyle(
                            color: iconColor, overflow: TextOverflow.ellipsis),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: const EdgeInsets.all(10),
                        //slider bar duration state stream
                        child: StreamBuilder<DurationState>(
                          stream: _durationStateStream,
                          builder: (context, snapshot) {
                            final durationState = snapshot.data;
                            final progress =
                                durationState?.position ?? Duration.zero;
                            final total = durationState?.total ?? Duration.zero;

                            return ProgressBar(
                              progress: progress,
                              total: total,
                              barHeight: 5.0,
                              baseBarColor: const Color(0xff8177ea),
                              progressBarColor: Colors.white,
                              thumbColor: Colors.white,
                              timeLabelLocation: TimeLabelLocation.sides,
                              timeLabelTextStyle: const TextStyle(
                                  fontSize: 15, color: Colors.white),
                              onSeek: (duration) {
                                player.seek(duration);
                              },
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                player.seekToPrevious();
                              });
                            },
                            icon: Icon(
                              Icons.skip_previous_outlined,
                              size: 40,
                              color: iconColor,
                            ),
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
                                    icon: const Icon(
                                      Icons.play_arrow,
                                      color: Colors.white,
                                    ),
                                    iconSize: 60.0,
                                    onPressed: player.play,
                                  ),
                                );
                              } else {
                                return Padding(
                                  padding: const EdgeInsets.all(0),
                                  child: IconButton(
                                    icon: const Icon(Icons.pause,
                                        color: Colors.white),
                                    iconSize: 60.0,
                                    onPressed: player.pause,
                                  ),
                                );
                              }
                            },
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                player.seekToNext();
                              });
                              // setState(() {});
                            },
                            icon: Icon(
                              Icons.skip_next_outlined,
                              size: 40,
                              color: iconColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void updateCurrentPlayingSongDetails(int index) {
    setState(() {
      if (widget.songDetails.isNotEmpty) {
        currentSongTitle = widget.songDetails[index].songTitle;
        currentSongArtist = widget.songDetails[index].songArtist;
        currentSongImg = widget.songDetails[index].imageId;
        currentSongId = widget.songDetails[index].id;
        currentSongPath = widget.songDetails[index].songuri;
      }
    });
  }
}

class DurationState {
  DurationState({this.position = Duration.zero, this.total = Duration.zero});
  Duration position, total;
}
