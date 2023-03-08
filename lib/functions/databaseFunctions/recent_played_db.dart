// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:music_player1/models/models.dart';

ValueNotifier<List<RecentPlayModel>> recentPlayedNotifier = ValueNotifier([]);

mixin RecentPlayedFunction {
  Future<void> addRecent(
    RecentPlayModel value,
  ) async {
    final recentDB = await Hive.openBox<RecentPlayModel>('recent_db');
    final recentlist = recentDB.values.toList();
    bool checkSong =
        recentlist.where((element) => element.id == value.id).isEmpty;
    if (checkSong) {
      await recentDB.add(value);
      print(checkSong);
      print(
          'qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq');
    } else {
      int index = recentlist.indexWhere((element) => element.id == value.id);
      await recentDB.deleteAt(index);
      await recentDB.add(value);
      print(
          'hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh');
    }
    if (recentDB.length > 8) {
      await recentDB.deleteAt(0);
      var a = recentDB.values;
      print(recentDB.getAt(0));
      print(
          'ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd');
    }
    // await recentDB.clear();
    await getAllRecent();
  }

  Future<void> getAllRecent() async {
    final recentDB = await Hive.openBox<RecentPlayModel>('recent_db');
    recentPlayedNotifier.value.clear();
    recentPlayedNotifier.value.addAll(recentDB.values);
    // ignore: invalid_use_of_protected_member
    recentPlayedNotifier.notifyListeners();
  }
}
