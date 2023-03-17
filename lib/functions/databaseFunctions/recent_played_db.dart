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
    int index = recentlist.indexWhere((element) => element.id == value.id);
    if (index == -1) {
      await recentDB.add(value);
    } else {
      recentDB.deleteAt(index);
      recentDB.add(value);
    }
    if (recentDB.values.length > 8) {
      await recentDB.deleteAt(0);
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
