// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:music_player1/models/models.dart';

ValueNotifier<List<FavouritesModel>> favouritesListNotifier = ValueNotifier([]);

mixin FavouriteFunctionClass {
  Future<void> addFavourites(FavouritesModel value, context) async {
    final favouritesDB = await Hive.openBox<FavouritesModel>('favourites');
    await favouritesDB.add(value);
    await getAllFavourites();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${value.songTitle} added to favourites'),
      ),
    );
  }

//to check if song is already in favourites
  bool isInFav(value) {
    List check = [];
    final favourite = favouritesListNotifier;
    for (var song in favourite.value) {
      check.add(song.id);
      if (check.contains(value)) {
        return true;
      }
    }
    return false;
  }

  Future<void> getAllFavourites() async {
    final favouritesDB = await Hive.openBox<FavouritesModel>('favourites');
    favouritesListNotifier.value.clear();
    favouritesListNotifier.value.addAll(favouritesDB.values);
    // ignore: invalid_use_of_visible_for_testing_member
    favouritesListNotifier.notifyListeners();
  }

  deleteFavourite(id, context, title) async {
    List check = [];
    final favouriteDB = await Hive.openBox<FavouritesModel>('favourites');
    for (var song in favouriteDB.values) {
      check.add(song.id);
    }
    int index = check.indexWhere((element) => element == id);
    await favouriteDB.deleteAt(index);
    getAllFavourites();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '$title removed from favourites',
        ),
      ),
    );
  }
}
