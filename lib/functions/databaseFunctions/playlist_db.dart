import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:music_player1/models/models.dart';

ValueNotifier<List<PlayListModel>> playListNotifier = ValueNotifier([]);
ValueNotifier<List> playListSongsNotifier = ValueNotifier([]);

mixin PlaylistFunctionsClass {
  Future<void> createPlaylist(PlayListModel value) async {
    final playlistDB = await Hive.openBox<PlayListModel>('playlist_db');
    final id = await playlistDB.add(value);
    value.playListId = id;
    await playlistDB.put(id, value);
    await getAllPlaylist();
  }

  Future<void> getAllPlaylist() async {
    final playlistDB = await Hive.openBox<PlayListModel>('playlist_db');
    playListNotifier.value.clear();
    playListNotifier.value.addAll(playlistDB.values);
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    playListNotifier.notifyListeners();
    
  }

  deletePlaylist(int index, int id) async {
    final playlistDB = await Hive.openBox<PlayListModel>('playlist_db');
    await playlistDB.deleteAt(index);
    final playlistsongDB =
        await Hive.openBox<PlayListSongsModel>('playlistsongs_db');
    List songs = playlistsongDB.values.toList();
    List playlistSongs =
        songs.where((element) => element.playlistId == id).toList();
    for (var song in playlistSongs) {
      removeFromPlaylistDelete(song.songid);
    }
    await getAllPlaylist();
  }

  addSongsPlaylist(PlayListSongsModel value, context) async {
    final playlistsongDB =
        await Hive.openBox<PlayListSongsModel>('playlistsongs_db');
    //  await playlistsongDB.clear();
    List songs = playlistsongDB.values.toList();
    List check = songs
        .where((element) => value.playlistId == element.playlistId)
        .toList();
    int num =
        check.indexWhere((element) => element.songTitle == value.songTitle);

    if (num != -1) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${value.songTitle} already exist in this playlist')));
      return;
    } else {
      final songid = await playlistsongDB.add(value);
      value.id = songid;
      await getAllPlaylistSongs();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${value.songTitle} added to playlist'),
        ),
      );
    }
  }

  Future<void> getAllPlaylistSongs() async {
    final playlistsongDB =
        await Hive.openBox<PlayListSongsModel>('playlistsongs_db');
    playListSongsNotifier.value.clear();
    playListSongsNotifier.value.addAll(playlistsongDB.values);
    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
    playListSongsNotifier.notifyListeners();
    // await Hive.close();
  }

  removeFromPlaylist(indexId, context) async {
    List songs = [];
    final playlistsongDB =
        await Hive.openBox<PlayListSongsModel>('playlistsongs_db');
    for (var song in playlistsongDB.values) {
      songs.add(song);
    }
    int index = songs.indexWhere((element) => element.id == indexId);
    await playlistsongDB.deleteAt(index);
    getAllPlaylistSongs();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('song has been removed from the playlist'),
      ),
    );
  }

//to delete songs from playlist when playlist is deleted
  removeFromPlaylistDelete(indexId) async {
    List songs = [];
    final playlistsongDB =
        await Hive.openBox<PlayListSongsModel>('playlistsongs_db');
    for (var song in playlistsongDB.values) {
      songs.add(song);
    }
    int index = songs.indexWhere((element) => element.id == indexId);
    await playlistsongDB.deleteAt(index);
    getAllPlaylistSongs();
  }

  updatePlaylist(value, index) async {
    final playlistDB = await Hive.openBox<PlayListModel>('playlist_db');
    await playlistDB.putAt(index, value);
    await getAllPlaylist();
  }
}
