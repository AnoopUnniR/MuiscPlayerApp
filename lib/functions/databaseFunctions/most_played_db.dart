import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:music_player1/models/models.dart';

ValueNotifier<List<MostPlayModel>> mostPlayedListNotifier = ValueNotifier([]);

mixin MostPlayedSongsClass {
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
    allCountValues.sort((a, b) => b.compareTo(a));
    List reversedlist =
        allCountValues.take(8).where((element) => element != 0).toList();
    List intexOfSong = [];
    for (var intex in reversedlist) {
      for (var checking in check) {
        if (checking.count == intex) {
          intexOfSong.add(checking.id);
        }
      }
    }

    List<MostPlayModel> mostPlayedCollections = [];
    for (int songIntex in intexOfSong.toSet().toList().take(8)) {
      mostPlayedCollections.add(mostDB.getAt(songIntex)!);

    }

    mostPlayedListNotifier.value.clear();
    mostPlayedListNotifier.value.addAll(mostPlayedCollections);
    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
    mostPlayedListNotifier.notifyListeners();
  }
}
