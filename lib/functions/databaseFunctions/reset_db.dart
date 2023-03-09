import 'package:hive/hive.dart';
import 'package:music_player1/functions/databaseFunctions/all_songs_db.dart';
import 'package:music_player1/functions/databaseFunctions/favourites_db.dart';
import 'package:music_player1/functions/databaseFunctions/most_played_db.dart';
import 'package:music_player1/functions/databaseFunctions/playlist_db.dart';
import 'package:music_player1/functions/databaseFunctions/recent_played_db.dart';
import 'package:music_player1/main.dart';
import 'package:music_player1/models/models.dart';
import 'package:music_player1/pages/home_screen.dart';

class ResetApp
    with
        AllSongsClass,
        FavouriteFunctionClass,
        PlaylistFunctionsClass,
        RecentPlayedFunction,
        MostPlayedSongsClass {
  resetAppFunction() async {
    await player.stop();
    isPlayerOn = false;
    await player.dispose();
    final songDB = await Hive.openBox<SongsListModel>('songs_db');
    final favouritesDB = await Hive.openBox<FavouritesModel>('favourites');
    final playlistDB = await Hive.openBox<PlayListModel>('playlist_db');
    final playListSongsDB =
        await Hive.openBox<PlayListSongsModel>('playlistsongs_db');
    final recentDB = await Hive.openBox<RecentPlayModel>('recent_db');
    final mostDB = await Hive.openBox<MostPlayModel>('most_db');

    await songDB.clear();
    await favouritesDB.clear();
    await playListSongsDB.clear();
    await playlistDB.clear();
    await recentDB.clear();
    await mostDB.clear();
    await getAllSongs();
    await getAllFavourites();
    await getAllPlaylist();
    await getAllRecent();
    await getAllPlaylistSongs();
    await getAllMostPlayed();
  }
}
