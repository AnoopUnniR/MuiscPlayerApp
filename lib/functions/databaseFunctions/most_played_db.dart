import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:music_player1/models/models.dart';

ValueNotifier<List<MostPlayModel>> mostPlayedListNotifier = ValueNotifier([]);

mixin MostPlayedSongsClass {
  Future<void> addMostSongs(MostPlayModel value) async {
    List check = [];
    final mostDB = await Hive.openBox<MostPlayModel>('most_db');
    for (var song in mostDB.values) {
      check.add(song.songTitle);
    }
    if (check.contains(value.songTitle)) {
      return;
    } else {
      final id = await mostDB.add(value);
      value.id = id;
      value.count = 0;
      await mostDB.put(id, value);
    }
  }

  updateMostPlayed(MostPlayModel value) async {
    final mostDB = await Hive.openBox<MostPlayModel>('most_db');
    List check = mostDB.values.toList();
    int index = check.indexWhere((element) => element.id == value.id);
    value.count = check[index].count + 1;
    await mostDB.putAt(index, value);
    await getAllMostPlayed();
  }

  Future<void> getAllMostPlayed() async {
    List check = [];
    List allCountValues = [];
    final mostDB = await Hive.openBox<MostPlayModel>('most_db');
    check = mostDB.values.toList();
    for (var song in check) {
      allCountValues.add(song.count);
    }
    allCountValues.sort();
    List reversedlist = allCountValues.reversed
        // .take(8)
        .where((element) => element != 0)
        .toSet()
        .toList();
    List intexOfSong = [];
    for (int count in reversedlist) {
      int index = check.indexWhere((element) => element.count == count);
      intexOfSong.add(index);
    }
    List<MostPlayModel> mostPlayedCollections = [];
    for (int songIntex in intexOfSong) {
      mostPlayedCollections.add(mostDB.getAt(songIntex)!);
    }

    mostPlayedListNotifier.value.clear();
    mostPlayedListNotifier.value.addAll(mostPlayedCollections);
    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
    mostPlayedListNotifier.notifyListeners();
  }
}
