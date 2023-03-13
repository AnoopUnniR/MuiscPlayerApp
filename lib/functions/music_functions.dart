import 'package:music_player1/functions/databaseFunctions/all_songs_db.dart';
import 'package:music_player1/functions/databaseFunctions/most_played_db.dart';
import 'package:music_player1/functions/databaseFunctions/recent_played_db.dart';
import 'package:music_player1/main.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player1/models/models.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:music_player1/pages/musicPlayerSscreen/music_player_screen.dart';

class MusicFunctionsClass
    with AllSongsClass, MostPlayedSongsClass, RecentPlayedFunction {
  songList() async {
    List<SongModel> songs = await audioQuery.querySongs(
        sortType: null,
        ignoreCase: true,
        orderType: OrderType.ASC_OR_SMALLER,
        uriType: UriType.EXTERNAL);

    for (var song in songs) {
      var listSongs = SongsListModel(
          songTitle: song.title,
          songuri: song.uri!,
          duration: song.duration,
          songArtist: song.artist,
          imageId: song.id);
      await addSongs(listSongs);
      var listSongMostPlayed = MostPlayModel(
        songTitle: song.title,
        songuri: song.uri!,
        imageId: song.id,
        songArtist: song.artist,
      );
      await addMostSongs(listSongMostPlayed);
    }
  }

  creatingPlayerList(List songs) {
    List<AudioSource> sources = [];
    for (var song in songs) {
      sources.add(
        AudioSource.uri(
          Uri.parse(song),
        ),
      );
    }
    playing = ConcatenatingAudioSource(children: sources);
  }

  creatingPlayerListShuffle(List songs) async {
    await player.stop();
    List<AudioSource> sources = [];
    for (var song in songs) {
      sources.add(
        AudioSource.uri(
          Uri.parse(song),
        ),
      );
    }
    player.setShuffleModeEnabled(true);
    playing = ConcatenatingAudioSource(
        children: sources,
        shuffleOrder: DefaultShuffleOrder(),
        useLazyPreparation: true);
    await player.setAudioSource(
      playing!,
      initialPosition: Duration.zero,
    );
    await player.play();
  }

  void playingAudio(index) async {
    await player.stop();
    await player.setAudioSource(playing!,
        initialPosition: Duration.zero, initialIndex: index);
    await player.play();
  }

  update(songs, [event]) async {
    var title = songs[event].songTitle;
    var artist = songs[event].songArtist;
    var img = songs[event].imageId;
    var id = songs[event].id;
    var path = songs[event].songuri;
    var recent = RecentPlayModel(
        songTitle: title,
        songuri: path,
        imageId: img,
        id: id,
        songArtist: artist);
    await addRecent(recent);
    var most = MostPlayModel(
        songTitle: title,
        songuri: path,
        imageId: img,
        songArtist: artist,
        id: id);
    await updateMostPlayed(most);
  }
}
