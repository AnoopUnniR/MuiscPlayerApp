import 'package:hive/hive.dart';
part 'models.g.dart';

// for all songs from storage
@HiveType(typeId: 1)
class SongsListModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  final String songuri;
  @HiveField(2)
  final String songTitle;
  @HiveField(3, defaultValue: 'unknown')
  final String? songArtist;
  @HiveField(4)
  final int? duration;
  @HiveField(5)
  final int? imageId;

  SongsListModel(
      {this.id,
      this.duration,
      this.songArtist,
      required this.songTitle,
      required this.songuri,
      required this.imageId});
}

// for favouriites
@HiveType(typeId: 2)
class FavouritesModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  final String songuri;
  @HiveField(2)
  final String songTitle;
  @HiveField(3, defaultValue: 'unknown')
  final String? songArtist;
  @HiveField(4)
  final int? imageId;

  FavouritesModel(
      {this.id,
      this.songArtist,
      required this.songTitle,
      required this.songuri,
      required this.imageId});
}

// for creating playlist
@HiveType(typeId: 3)
class PlayListModel {
  @HiveField(0)
  int? playListId;
  @HiveField(1)
  String? playlistName;
  PlayListModel({
    this.playListId,
    this.playlistName,
  });
}

// for recently played
@HiveType(typeId: 4)
class RecentPlayModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  final String songuri;
  @HiveField(2)
  final String songTitle;
  @HiveField(3)
  final String? songArtist;
  @HiveField(4)
  final int? imageId;

  RecentPlayModel(
      {this.id,
      this.songArtist,
      required this.songTitle,
      required this.songuri,
      required this.imageId});
}

// for adding songs to the playlist
@HiveType(typeId: 5)
class PlayListSongsModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  final String songuri;
  @HiveField(2)
  final String songTitle;
  @HiveField(3)
  final String? songArtist;
  @HiveField(4)
  final int? playlistId;
  @HiveField(5)
  final int? imageId;

  PlayListSongsModel(
      {this.id,
      required this.playlistId,
      required this.songArtist,
      required this.songTitle,
      required this.songuri,
      required this.imageId});
}

//for most played
@HiveType(typeId: 6)
class MostPlayModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  final String songuri;
  @HiveField(2)
  final String songTitle;
  @HiveField(3)
  final String? songArtist;
  @HiveField(4)
  final int? imageId;
  @HiveField(5, defaultValue: 0)
  int? count;

  MostPlayModel(
      {this.id,
      this.songArtist,
      required this.songTitle,
      required this.songuri,
      required this.imageId,
      this.count});
}
