// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SongsListModelAdapter extends TypeAdapter<SongsListModel> {
  @override
  final int typeId = 1;

  @override
  SongsListModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SongsListModel(
      id: fields[0] as int?,
      duration: fields[4] as int?,
      songArtist: fields[3] == null ? 'unknown' : fields[3] as String?,
      songTitle: fields[2] as String,
      songuri: fields[1] as String,
      imageId: fields[5] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, SongsListModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.songuri)
      ..writeByte(2)
      ..write(obj.songTitle)
      ..writeByte(3)
      ..write(obj.songArtist)
      ..writeByte(4)
      ..write(obj.duration)
      ..writeByte(5)
      ..write(obj.imageId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SongsListModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class FavouritesModelAdapter extends TypeAdapter<FavouritesModel> {
  @override
  final int typeId = 2;

  @override
  FavouritesModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavouritesModel(
      id: fields[0] as int?,
      songArtist: fields[3] == null ? 'unknown' : fields[3] as String?,
      songTitle: fields[2] as String,
      songuri: fields[1] as String,
      imageId: fields[4] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, FavouritesModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.songuri)
      ..writeByte(2)
      ..write(obj.songTitle)
      ..writeByte(3)
      ..write(obj.songArtist)
      ..writeByte(4)
      ..write(obj.imageId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavouritesModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PlayListModelAdapter extends TypeAdapter<PlayListModel> {
  @override
  final int typeId = 3;

  @override
  PlayListModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlayListModel(
      playListId: fields[0] as int?,
      playlistName: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PlayListModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.playListId)
      ..writeByte(1)
      ..write(obj.playlistName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayListModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class RecentPlayModelAdapter extends TypeAdapter<RecentPlayModel> {
  @override
  final int typeId = 4;

  @override
  RecentPlayModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecentPlayModel(
      id: fields[0] as int?,
      songArtist: fields[3] as String?,
      songTitle: fields[2] as String,
      songuri: fields[1] as String,
      imageId: fields[4] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, RecentPlayModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.songuri)
      ..writeByte(2)
      ..write(obj.songTitle)
      ..writeByte(3)
      ..write(obj.songArtist)
      ..writeByte(4)
      ..write(obj.imageId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecentPlayModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PlayListSongsModelAdapter extends TypeAdapter<PlayListSongsModel> {
  @override
  final int typeId = 5;

  @override
  PlayListSongsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlayListSongsModel(
      id: fields[0] as int?,
      playlistId: fields[4] as int?,
      songArtist: fields[3] as String?,
      songTitle: fields[2] as String,
      songuri: fields[1] as String,
      imageId: fields[5] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, PlayListSongsModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.songuri)
      ..writeByte(2)
      ..write(obj.songTitle)
      ..writeByte(3)
      ..write(obj.songArtist)
      ..writeByte(4)
      ..write(obj.playlistId)
      ..writeByte(5)
      ..write(obj.imageId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayListSongsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MostPlayModelAdapter extends TypeAdapter<MostPlayModel> {
  @override
  final int typeId = 6;

  @override
  MostPlayModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MostPlayModel(
      id: fields[0] as int?,
      songArtist: fields[3] as String?,
      songTitle: fields[2] as String,
      songuri: fields[1] as String,
      imageId: fields[4] as int?,
      count: fields[5] == null ? 0 : fields[5] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, MostPlayModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.songuri)
      ..writeByte(2)
      ..write(obj.songTitle)
      ..writeByte(3)
      ..write(obj.songArtist)
      ..writeByte(4)
      ..write(obj.imageId)
      ..writeByte(5)
      ..write(obj.count);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MostPlayModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
