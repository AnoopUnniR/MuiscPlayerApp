import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:music_player1/models/models.dart';

ValueNotifier<List<SongsListModel>> songlistNotifier = ValueNotifier([]);

mixin AllSongsClass {
  Future<void> addSongs(SongsListModel value) async {
    List check = [];
    final songDB = await Hive.openBox<SongsListModel>('songs_db');
    final mostDB = await Hive.openBox<MostPlayModel>('most_db');

    for (var song in songDB.values) {
      check.add(song.songTitle);
    }
    if (check.contains(value.songTitle)) {
      return;
    } else {
      final id = await songDB.add(value);
      value.id = id;
      await songDB.put(id, value);
      await getAllSongs();
      var listSongMostPlayed = MostPlayModel(
          songTitle: value.songTitle,
          songuri: value.songuri,
          imageId: value.imageId,
          songArtist: value.songArtist,
          id: value.id,
          count: 0);
      await mostDB.add(listSongMostPlayed);
    }
  }

  Future<void> getAllSongs() async {
    final songDB = await Hive.openBox<SongsListModel>('songs_db');
    songlistNotifier.value.clear();
    songlistNotifier.value.addAll(songDB.values);

    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    songlistNotifier.notifyListeners();
  }

  delete() async {
    final songDB = await Hive.openBox<SongsListModel>('songs_db');
    await songDB.clear();
  }
}
